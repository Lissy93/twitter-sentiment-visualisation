
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
moment = require 'moment'
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
removeWords = require 'remove-words'
hpSentimentAnalysis =  require 'haven-sentiment-analysis'
hpKey = require('../config/keys').hp
express = require('express')
router = express.Router()


fetchAndFormatTweets = (searchTerm, cb) ->
  fetchTweets.byTopic searchTerm, (results) ->
    cb formatTweets results

formatTweets = (twitterResults) ->
  results = ""
  for tweet in twitterResults then results += tweet.body + " "
  results =  results.replace(/[^A-Za-z0-9 ]/g, '')
  results = results.substring(0, 5000)

getHpSentimentResults = (tweetBody, cb) ->
  hpSentimentAnalysis tweetBody, hpKey, (results) ->
    cb results


formatResultsForChart = (hpResults) ->
  data = {
    name: 'sentiment-tree', children: [
      {name:'positive', children: []}
      {name:'negative', children: []}
    ]
  }

  i = 1
  while i <= 10
    data.children[0].children.push({name: i/10, children: [] })
    data.children[1].children.push({name: i/-10+'', children: [] })
    i++

  for posRes in hpResults.positive
    score = Math.round(posRes.score*10)/10
    for i in data.children[0].children
      if i.name == score then i.children.push(
        name: posRes.sentiment
        size: posRes.score
        topic: posRes.topic
      )

  for negRes in hpResults.negative
    score = Math.round(negRes.score*10)/10+''
    for i, index in data.children[1].children
      if i.name == score then i.children.push(
          name: negRes.sentiment
          size: Math.abs(negRes.score)
          topic: negRes.topic
        )
  data


# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param

  fetchAndFormatTweets searchTerm, (tweetBody) ->
    getHpSentimentResults tweetBody, (hpResults) ->
      results = formatResultsForChart hpResults
      res.render 'page_breakDown',
        title: searchTerm+' results'
        pageNum: 8
        data: results
        searchTerm: searchTerm

router.get '/', (req, res) ->
  Tweet.getAllTweets (tweets) ->
      tweetBody = formatTweets tweets
      getHpSentimentResults tweetBody, (hpResults) ->
        results = formatResultsForChart hpResults
        res.render 'page_breakDown',
          title: 'Break down results'
          pageNum: 8
          data:  results
          searchTerm: ''

module.exports = router