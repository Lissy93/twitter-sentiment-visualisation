
# Require necessary modules, API keys and instantiate objects
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'
express = require('express')
router = express.Router()

# Main route - no search term
router.get '/', (req, res, next) ->
  fetchSentimentTweets '', (results, average) ->  # Fetch all data
    res.render 'index', # Render template
      title: 'Sentiment Sweep'
      pageNum: 0
      data: results
      averageSentiment: average

module.exports = router