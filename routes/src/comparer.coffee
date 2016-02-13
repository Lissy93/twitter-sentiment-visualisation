
# Require necessary modules, API keys and instantiate objects
express = require('express')
router = express.Router()
asyncTweets = require '../utils/async-tweets'


# Main route - no search term
router.get '/:query', (req, res, next) ->
  searchTerms = req.params.query.split(',').splice(0,4)
  asyncTweets searchTerms, (results) ->
    res.render 'page_comparer', # Render template
      title: 'Comparer'
      pageNum: 10
      data: results
      searchTerm: searchTerms

module.exports = router