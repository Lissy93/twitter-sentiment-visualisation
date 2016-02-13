
# Require necessary modules, API keys and instantiate objects
express = require('express')
router = express.Router()
asyncTweets = require '../utils/async-tweets'


# Main route - no search term
router.get '/', (req, res, next) ->
  searchTerms = ['hello', 'oxford', 'dinosaur']
  asyncTweets searchTerms, (results) ->
    res.render 'page_comparer', # Render template
      title: 'Comparer'
      pageNum: 10
      data: results
      searchTerm: ''

## Route with search term
#router.get '/:query', (req, res) ->
#  searchTerm = req.params.query # Get the search term from URL param
#  fetchSentimentTweets searchTerm, (results, average) ->  # Fetch all data
#    res.render 'page_comparer', # Render template
#      title: 'Comparer'
#      pageNum: 10
#      data: results
#      searchTerm: searchTerm

module.exports = router