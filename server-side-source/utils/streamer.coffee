
Twit = require 'twit'
streamHandler = require '../utils/stream-handler'

class streamer
  constructor: (@credentials, @io) ->

    T = new Twit(
      consumer_key: @credentials.consumer_key
      consumer_secret: @credentials.consumer_secret
      access_token: @credentials.token
      access_token_secret: @credentials.token_secret
      timeout_ms: 60 * 1000)

    formatResults = (twitterResults) ->

      prepareLocation = (body) ->
        location = undefined
        location =
          place_name: '_'
          location:
            lat: 0.0000000
            lng: 0.0000000
        if body.coordinates != null
          location.location.lat = body.coordinates.coordinates[1]
          location.location.lng = body.coordinates.coordinates[0]
        else if body.geo != null
          location.location.lat = body.geo.coordinates[0]
          location.location.lng = body.geo.coordinates[1]
        if body.place != null
          location.place_name = body.place.name
        else if body.user != null
          location.place_name = body.user.location
        location

      {
        'date': twitterResults.created_at
        'body': twitterResults.text
        'location': prepareLocation(twitterResults)
        'retweet-count': twitterResults.retweet_count
        'favorited-count': twitterResults.favorite_count
        'lang': twitterResults.lang
      }

    world = [-180, -90, 180, 90 ]
    stream = T.stream('statuses/filter', locations: world)

    io = @io
    stream.on 'tweet', (tweet) ->
      streamHandler(formatResults(tweet),io)

    stream.on 'disconnect', (disconnectMessage) ->
      console.log 'Twitter Stream Disconnected'
      console.log disconnectMessage
      stream = T.stream('statuses/filter', locations: world)

    stream.on 'connected', (response) ->
      console.log 'Twitter Stream Connected'

module.exports = streamer
