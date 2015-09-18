(function() {
  var Tweet;

  Tweet = require('../models/Tweet');

  module.exports = function(stream, io) {
    return stream.on('data', function(data) {
      var tweet, tweetEntry;
      tweet = {
        twid: data['id'],
        body: data['text'],
        dateTime: data['created_at']
      };
      tweetEntry = new Tweet(tweet);
      return tweetEntry.save(function(err) {
        if (!err) {
          return io.emit('tweet', tweet);
        }
      });
    });
  };

}).call(this);
