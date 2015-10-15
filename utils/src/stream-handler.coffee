Tweet = require '../models/Tweet'

removeWords = require 'remove-words'
sentimentAnalysis = require 'sentiment-analysis'

module.exports = (data, io) ->

  tweet = # Construct a new tweet object
    body:     data.body
    dateTime: data.date
    keywords  : removeWords(data.body)
    sentiment : sentimentAnalysis(data.body)
#      location  : {lat: 0, lon: 0}

  tweetEntry = new Tweet(tweet) # Create new model instance from object

  console.log tweetEntry

  tweetEntry.save (err) -> # Save to db

    if !err
      io.emit 'tweet', tweet # If everythings cool, socket.io emits the tweet.



