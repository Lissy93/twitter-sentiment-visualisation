
# Require necessary modules, API keys and instantiate objects
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'
express = require('express')
router = express.Router()


# Converts Tweet objects into the right format
formatTweets = (tweets) ->
 tweets

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

    res.render 'page_search', # Render template
      title: searchTerm+' results'
      pageNum: -1
      data: results
      averageSentiment: average
      searchTerm: searchTerm

module.exports = router