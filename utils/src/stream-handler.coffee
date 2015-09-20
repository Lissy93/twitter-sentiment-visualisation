Tweet = require '../models/Tweet'

module.exports = (data, io) ->

  tweet = # Construct a new tweet object
    body:     data['body']
    dateTime: data['date']
#      keywords  : [] # take from data['text']
#      sentiment : 0
#      location  : {lat: 0, lon: 0}

  tweetEntry = new Tweet(tweet) # Create new model instance from object

  tweetEntry.save (err) -> # Save to db

    if !err
      io.emit 'tweet', tweet # If everythings cool, socket.io emits the tweet.



