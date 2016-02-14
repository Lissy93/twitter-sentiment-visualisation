# Include relevant node modules
FetchTweets = require 'fetch-tweets'
placeLookup = require 'place-lookup'
sentiment = require 'sentiment-analysis'
removeWords = require 'remove-words'
q = require 'q'

class GetGeoSentimentTweets

  constructor: (@twitterApiKeys, @placesApiKey) ->

# Function fetches Tweets from Twitter API, returning a deferred promise
  fetchFromTwitter = (query, twitterApiKeys) ->
    fetchTweets = new FetchTweets(twitterApiKeys)
    deferredTweets = q.defer()
    fetchTweets.byTopic query, (results) ->
      deferredTweets.resolve(results)
    deferredTweets.promise

  # Fetches place data (lat and long) from Google places api, return promise
  findPlaceInfo = (locationObject, placesApiKey) ->
    deferredLocation = q.defer()
    if locationObject.place_name!=""
      placeLookup locationObject.place_name, placesApiKey, (placeData)->
        deferredLocation.resolve(placeData)
    else deferredLocation.resolve({error:'no place available'})
    deferredLocation.promise

  # Main
  go: (searchQuery, completeAction) ->
    placesApiKey = @placesApiKey
    fetchFromTwitter(searchQuery, @twitterApiKeys).then (twitterResults) ->
      promises = [] # array of google places promises
      for tweet in twitterResults
        promises.push findPlaceInfo tweet.location, placesApiKey
      q.all(promises).spread -> # When all the places promises have returned
        for tweet, index in twitterResults
          tweet.location = arguments[index] # Attach new location to Tweet
          tweet.sentiment = sentiment tweet.body # Attach sentiment to Tweet
          tweet.keywords = removeWords tweet.body # Attach keywords to Tweet
        completeAction twitterResults # Done!

module.exports = GetGeoSentimentTweets