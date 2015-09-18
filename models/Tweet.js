(function() {
  var Tweet, mongoose, schema;

  mongoose = require('mongoose');

  schema = new mongoose.Schema({
    twid: String,
    body: String,
    dateTime: String
  });

  schema.statics.getTweets = function(page, skip, callback) {
    var start, tweets;
    tweets = [];
    start = page * 10 + skip * 1;
    return Tweet.find({}, 'twid active author avatar body date screenname', {
      skip: start,
      limit: 10
    }).sort({
      dateTime: 'desc'
    }).exec(function(err, docs) {
      if (!err) {
        tweets = docs;
        tweets.forEach(function(tweet) {
          return tweet.active = true;
        });
      }
      return callback(tweets);
    });
  };

  module.exports = Tweet = mongoose.model('Tweet', schema);

}).call(this);
