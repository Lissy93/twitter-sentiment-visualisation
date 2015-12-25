mongoose = require 'mongoose'

schema = new mongoose.Schema({
body      : String
dateTime  : String
keywords  : Array
sentiment : Number
location  : { type : Object , "default" : {} }
})

schema.statics.getTweets = (page, skip, callback) ->
  tweets = []
  start = page * 10 + skip * 1

  # Query the db, using skip and limit to achieve page chunks
  Tweet.find({}, 'twid active author avatar body date screenname',
  skip: start
  limit: 10).sort(dateTime: 'desc').exec (err, docs) ->
      # If everything is cool...
    if !err
      tweets = docs # We got tweets
      tweets.forEach (tweet) ->
        tweet.active = true # Set them to active

    callback tweets # Pass them back to the specified callback


schema.statics.getAllTweets = (callback) ->
  Tweet.find {}, (err, results) ->
    callback results


module.exports = Tweet = mongoose.model('Tweet', schema)
