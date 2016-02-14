mongoose = require 'mongoose'

schema = new mongoose.Schema({
  body      : String
  dateTime  : String
  sentiment : Number
  location  : { type : Object , "default" : {} }
},
{ capped: { size: 49152, max: 1500, autoIndexId: true } }
)

schema.statics.getAllTweets = (callback) ->
  Tweet.find {}, (err, results) ->
    callback results

schema.statics.searchTweets = (searchTerm, callback) ->
  Tweet.find { keywords: searchTerm }, (err, results) ->
    callback results


module.exports = Tweet = mongoose.model('Tweet', schema)
