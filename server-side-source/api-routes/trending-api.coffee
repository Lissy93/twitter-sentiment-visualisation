express = require('express')
router = express.Router()
FetchTweets = require 'fetch-tweets'
twitterKey  = require('../config/keys').twitter
asyncTweets = require '../utils/async-tweets'


findAverageSentiment = (tweetArr) ->
  totalSentiment = 0
  for tweet in tweetArr.tweets then totalSentiment += tweet.sentiment
  totalSentiment / tweetArr.tweets.length

findOriginalTrend = (searchTerm, searchTerms, trends) ->
  for st, i in searchTerms then if st == searchTerm then return trends[i]
  {}


router.post '/', (req, res) ->
  (new FetchTweets twitterKey).trending req.body.woid, (trendingResults) ->

    # Make a list of searchTerms from the trending topics
    searchTerms = []
    originalTrends = []
    i = 0
    while searchTerms.length < 5
      trend = trendingResults[i].trend.replace(/[\W_]+/g, '')
      if trend.length > 0
        searchTerms.push trend
        originalTrends.push trendingResults[i]
      i++

    # Make the actual request
    asyncTweets searchTerms, (twitterResults) ->

      #Make the results array
      results = []
      for tweetArr in twitterResults
        t = findOriginalTrend(tweetArr.searchTerm, searchTerms, trendingResults)
        results.push
          topic: t.trend
          sentiment: findAverageSentiment tweetArr
          volume: t.volume

      # Done, just render the json
      res.json results

module.exports = router