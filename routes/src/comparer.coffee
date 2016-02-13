
# Require necessary modules, API keys and instantiate objects
express = require('express')
router = express.Router()
asyncTweets = require '../utils/async-tweets'


formatResults = (data) ->
  for tweetArr in data

    # Find average sentiment
    totalSentiment = 0
    for tweet in tweetArr.tweets then totalSentiment += tweet.sentiment
    tweetArr.averageSentiment = totalSentiment / tweetArr.length

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