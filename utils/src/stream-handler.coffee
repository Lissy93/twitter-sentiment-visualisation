Tweet = require '../models/Tweet'

removeWords = require 'remove-words'
sentimentAnalysis = require 'sentiment-analysis'
placeLookup = require 'place-lookup'

placesApiKey = require('../config/keys').googlePlaces

blankPlace = { place_name: '', location: { lat: 0.0000000, lng: 0.0000000 } }

module.exports = (data, io) ->

  if data.location.location.lat == 0 and data.location.place_name != ''
    placeLookup data.location.place_name, placesApiKey, (placeResults) ->
        tweetLocation = if !placeResults.error then placeResults else blankPlace
        tweet = makeTweetObj(data, tweetLocation)
        tweetEntry = new Tweet(tweet) # Create new model instance from object

        tweetEntry.save
        console.log tweet
        io.emit 'tweet', tweet # If everythinks cool, emit the tweet

  else
    tweet = makeTweetObj(data, blankPlace)
    tweetEntry = new Tweet(tweet) # Create new model instance from object
    tweetEntry.save
    console.log tweet
    io.emit 'tweet', tweet # If everythinks cool, emit the tweet


makeTweetObj = (data, location)->
    body:     data.body
    dateTime: data.date
    keywords  : removeWords(data.body)
    sentiment : sentimentAnalysis(data.body)
    location  : location
