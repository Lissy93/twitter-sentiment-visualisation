
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
entityExtraction =  require 'haven-entity-extraction'
hpKey = require('../config/keys').hp
express = require('express')
router = express.Router()


# Formats tweets into a massive tweet body
formatTweets = (twitterResults) ->
  results = ""
  for tweet in twitterResults then results += tweet.body + " "
  results = results.replace(/(?:https?|ftp):\/\/[\n\S]+/g, '')
  results =  results.replace(/[^A-Za-z0-9 ]/g, '')
  results = results.substring(0, 5000)

# Main route - no search term
router.get '/', (req, res, next) ->
  Tweet.getAllTweets (tweets) ->
    entityExtraction formatTweets(tweets), hpKey, (results) ->
      res.render 'page_entityExtraction',
        title: 'Entity Extraction'
        pageNum: 8
        data: results
        searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  fetchTweets.byTopic searchTerm, (tweets) ->
    entityExtraction formatTweets(tweets), hpKey, (results) ->
      res.render 'page_entityExtraction',
        title: searchTerm+' | Entity Extraction'
        pageNum: 8
        data: results
        searchTerm: searchTerm

module.exports = router