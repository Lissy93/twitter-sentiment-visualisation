
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
moment = require 'moment'
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
express = require('express')
router = express.Router()


# Converts Tweet objects into the right format
formatTweets = (tweets) ->
 tweets

# Main route - no search term
router.get '/', (req, res, next) ->
  Tweet.getAllTweets (tweets) ->
    res.render 'page_search',
      title: 'Search'
      pageNum: -1
      data: {}
      searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  fetchTweets.byTopic searchTerm, (tweets) ->
    res.render 'page_search',
      title: searchTerm+' results'
      pageNum: -1
      data: {}
      searchTerm: searchTerm

module.exports = router