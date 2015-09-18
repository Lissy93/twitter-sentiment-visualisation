Tweet = require '../models/Tweet'

module.exports = (stream, io) ->

  stream.on 'data', (data) -> # When tweets get sent our way ...
    tweet = # Construct a new tweet object
      twid:     data['id']
      body:     data['text']
      dateTime: data['created_at']
#      keywords  : [] # take from data['text']
#      sentiment : 0
#      location  : {lat: 0, lon: 0}

    tweetEntry = new Tweet(tweet) # Create new model instance from object

    tweetEntry.save (err) -> # Save to db

      if !err
        io.emit 'tweet', tweet # If everythings cool, socket.io emits the tweet.



