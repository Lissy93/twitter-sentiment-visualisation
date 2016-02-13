
# Require necessary modules, API keys and instantiate objects
express = require('express')
router = express.Router()
asyncTweets = require '../utils/async-tweets'
wordFormatter = require('../utils/format-for-keyword-vis').findTopWords


formatResults = (data) ->
  for tweetArr in data

    # Add keywords list
    wrdsjs = wordFormatter(tweetArr.tweets, true)
    topData = wrdsjs.topPositive.concat(wrdsjs.topNegative, wrdsjs.topNeutral)
    topData = topData.sort (a, b) -> parseFloat(b.freq) - parseFloat(a.freq)
    topData = topData.splice(0,10)
    tweetArr.keywordData= topData = topData.sort -> 0.5 - Math.random()

    # Find average sentiment
    totalSentiment = 0
    for tweet in tweetArr.tweets then totalSentiment += tweet.sentiment
    tweetArr.averageSentiment = totalSentiment / tweetArr.tweets.length

    # Find percentage positive, negative and neutral
    pieChart = {positive: 0, neutral: 0, negative: 0}
    for tweet in tweetArr.tweets
      if tweet.sentiment > 0 then pieChart.positive += 1
      else if tweet.sentiment < 0 then pieChart.negative += 1
      else pieChart.neutral += 1
    tweetArr.pieChart = pieChart

  data

# Main route - no search term
router.get '/:query', (req, res, next) ->
  searchTerms = req.params.query.split(',').splice(0,4)
  asyncTweets searchTerms, (results) ->
    res.render 'page_comparer', # Render template
      title: 'Comparer'
      pageNum: 10
      data: formatResults results
      searchTerm: searchTerms

module.exports = router