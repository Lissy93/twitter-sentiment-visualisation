# Include relevant node modules
FetchTweets = require 'fetch-tweets'
sentiment   = require 'sentiment-analysis'
removeWords = require 'remove-words'
twitterKey  = require('../config/keys').twitter


module.exports = (searchTerm, callback) ->
  (new FetchTweets twitterKey).byTopic searchTerm, (results) ->

    # Assign Sentiments
    for tweet in results then tweet.sentiment = sentiment tweet.body

    # Assign keywords
    for tweet in results then tweet.keywords = removeWords tweet.body

    # Find average sentiment
    total =  0
    for tweet in results then total += tweet.sentiment
    averageSentiment = total / results.length
    averageSentiment = Math.round(averageSentiment*100)/100

    # Done, call callback with results and sentiment average
    callback results, averageSentiment

