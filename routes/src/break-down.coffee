
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
moment = require 'moment'
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
removeWords = require 'remove-words'
express = require('express')
router = express.Router()



# Main route - no search term
router.get '/', (req, res, next) ->
  Tweet.getAllTweets (tweets) ->
    res.render 'page_breakDown',
      title: 'Sentiment Analysis Breakdown'
      pageNum: 8
      data: tweets
      searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  fetchTweets.byTopic searchTerm, (tweets) ->
    res.render 'page_breakDown',
      title: searchTerm+' results'
      pageNum: 8
      data: tweets
      searchTerm: searchTerm

module.exports = router