
# Require necessary modules, API keys and instantiate objects
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'
wordFormatter = require('../utils/format-for-keyword-vis').findTopWords
toneAnalyzer = require '../utils/watson-tone-analyzer'
makeClickWords = require '../utils/make-click-words'

express = require('express')
router = express.Router()

# Converts Tweet objects into the right format
formatResults = (tweetArr) ->
  results = {}
  # Add keywords list
  wrdsjs = wordFormatter(tweetArr, true)
  topData = wrdsjs.topPositive.concat(wrdsjs.topNegative, wrdsjs.topNeutral)
  topData = topData.sort (a, b) -> parseFloat(b.freq) - parseFloat(a.freq)
  topData = topData.splice(0,10)
  results.keywordData= topData = topData.sort -> 0.5 - Math.random()

  # Find average sentiment
  totalSentiment = 0
  for tweet in tweetArr then totalSentiment += tweet.sentiment
  results.averageSentiment = totalSentiment / tweetArr.length

  # Find percentage positive, negative and neutral
  pieChart = {positive: 0, neutral: 0, negative: 0}
  for tweet in tweetArr
    if tweet.sentiment > 0 then pieChart.positive += 1
    else if tweet.sentiment < 0 then pieChart.negative += 1
    else pieChart.neutral += 1
  results.pieChart = pieChart
  results.tweets = tweetArr
  results

getTopTweets = (tweetArr) ->
  tweetArr = JSON.parse(JSON.stringify(tweetArr)) # Clone tweetArr
  results = {}
  topPositiveTweets = tweetArr.sort((b, a) ->
    a.sentiment - (b.sentiment)
  ).slice(0, 5)
  topNegativeTweets = tweetArr.sort((a, b) ->
    a.sentiment - (b.sentiment)
  ).slice(0, 5)
  for tweet in topPositiveTweets then tweet.body = makeClickWords tweet.body
  for tweet in topNegativeTweets then tweet.body = makeClickWords tweet.body
  results.topPositive = topPositiveTweets
  results.topNegative = topNegativeTweets
  results



# Main route - no search term
router.get '/', (req, res, next) ->
  res.render 'page_search',
    title: 'Search'
    pageNum: -1
    data: {}
    searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->

  searchTerm = req.params.query # Get the search term from URL param

  fetchSentimentTweets searchTerm, (results, average) ->  # Fetch all data

    toneAnalyzer results, (toneResults) ->

      res.render 'page_search', # Render template
        title: searchTerm+' results'
        pageNum: -1
        data: formatResults results
        averageSentiment: average
        searchTerm: searchTerm
        toneResults: toneResults
        topTweets: getTopTweets results

module.exports = router