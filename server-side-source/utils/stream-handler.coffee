Tweet = require '../models/Tweet'

removeWords = require 'remove-words'
sentimentAnalysis = require 'sentiment-analysis'
moment = require 'moment'
placeLookup = require 'place-lookup'

placesApiKey = require('../config/keys').googlePlaces
blankPlace = { place_name: '', location: { lat: 0.0000000, lng: 0.0000000 } }


makeTweetObj = (data, location)->
  body:     data.body
  dateTime: data.date
  keywords  : removeWords(data.body)
  sentiment : sentimentAnalysis(data.body)
  location  : location

# Determines if a Tweet object is complete & if it should be saved in the db
isSuitableForDb = (tweetData) ->
  if tweetData.sentiment == 0 then return false   # Reject neutral tweets
  if tweetData.location.error? then return false  # Reject no location tweets
  # Double check location is actually there, and reject if not
  if !tweetData.location.location.lat? then return false
  if !tweetData.location.location.lng? then return false
  # new! to make the db fill up more slowly, reject all slightly neutral tweets
  if tweetData.sentiment < 0.4 && tweetData.sentiment > -0.2 then return false
  return true


module.exports = (data, io) ->

  # Emit all tweets to the anyTweet listener
  anyTweet = makeTweetObj data, data.location
  anyTweet.dateTime = moment(new Date(anyTweet.dateTime)).fromNow()
  io.emit 'anyTweet', anyTweet


  if data.location.location.lat !=0
    tweet = makeTweetObj data, data.location
    io.emit 'tweet', tweet
    if isSuitableForDb tweet
      Tweet.findOneAndUpdate
        body: tweet.body,
        tweet,
        upsert: true,
        (err) -> if err then console.log 'ERROR UPDATING TWEET - '+err

## Uncomment this to stream live geo-accurate tweets- it will drain API usage
#  else if data.location.location.lat == 0 and data.location.place_name != ''
#    placeLookup data.location.place_name, placesApiKey, (placeResults) ->
#      tweetLocation = if !placeResults.error then placeResults else blankPlace
#      tweet = makeTweetObj(data, tweetLocation)
#
#      if isSuitableForDb tweet
#        Tweet.findOneAndUpdate
#          body: tweet.body,
#          tweet,
#          upsert: true,
#          (err) -> if err then console.log 'ERROR UPDATING TWEET - '+err
#
#      io.emit 'tweet', tweet # If everythinks cool, emit the tweet


