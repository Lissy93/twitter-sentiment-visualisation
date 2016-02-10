
# Require necessary modules, API keys and instantiate objects
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'
express = require('express')
router = express.Router()

# Main route - no search term
router.get '/', (req, res, next) ->
  fetchSentimentTweets '', (results, average) ->  # Fetch all data
    res.render 'page_hexagons', # Render template
      title: 'Sentiment Hexagons'
      pageNum: 9
      data: results
      averageSentiment: average
      searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  fetchSentimentTweets searchTerm, (results, average) ->  # Fetch all data
    res.render 'page_hexagons', # Render template
      title: searchTerm+' hex results'
      pageNum: 9
      data: results
      averageSentiment: average
      searchTerm: searchTerm

module.exports = router