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
  if tweetData.sentiment == 0 then return false
  if tweetData.location.error? then return false
  if !tweetData.location.location.lat? then return false
  if !tweetData.location.location.lng? then return false
  return true


module.exports = (data, io) ->

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


  else if data.location.location.lat == 0 and data.location.place_name != ''
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


  else
    tweet = makeTweetObj(data, blankPlace)
    io.emit 'tweet', tweet # If everythinks cool, emit the tweet


