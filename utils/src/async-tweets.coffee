
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'
q = require 'q'

makeTweetPromiseArr = (searchTerm) ->
  deferredTweetResults = q.defer()
  fetchSentimentTweets searchTerm, (results) ->  # Fetch all data for one Tweet
    deferredTweetResults.resolve(results)
  deferredTweetResults.promise

makeRequests = (searchTerms, completeAction) ->
  results = []
  promises = []
  for term in searchTerms then promises.push makeTweetPromiseArr term
  q.all(promises).spread -> # When all the twitter promises have returned
    for argument, index in arguments
      results.push searchTerm: searchTerms[index], tweets: argument
    completeAction results # Done!

module.exports = makeRequests

