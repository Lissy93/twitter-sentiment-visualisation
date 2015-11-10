express = require('express')
router = express.Router()

defaultRes = require('../public/data/all_sentiment_results_edwardsnowdon.json')


# Renders the layout with the sentiment results passed as param
renderWithResults = (res, results) ->
#res.render('index', { title: 'Express' });
  res.json results

# Root task, called when no params passed, should use default results
router.get '/', (req, res, next) ->
  renderWithResults res, defaultRes


# Fetches Tweets for given query, calculates sentiment then calls render
router.get '/:query', (req, res, next) ->

  # Node modules
  fetchTweets = require('fetch-tweets')
  dictionarySA = require('sentiment-analysis')
  nluSA = require('haven-sentiment-analysis')

  # Keys and instance variables
  hpKey = require('../config/keys').hp
  twitterKey = require('../config/keys').twitter
  results = [] # Will hold list of json objects to be rendered
  completedRequests = 0 # Counts how many results returned
  searchTerm = req.params.query # Get the search term from URL param

  # Method will generate an object with all calculated sentiments for tweet
  calculateResults = (searchTerm) ->
    makeSentimentResults = (rawTweets) ->
      rawTweets.forEach (tweet, index) ->
        nluSA { text: tweet }, hpKey, (nluResults) ->
          results.push
            index: index
            tweet: tweet
            dictionary_sentiment: dictionarySA(tweet)
            nlu_sentiment: Math.round(nluResults.aggregate.score * 1000) / 1000
          completedRequests++
          if completedRequests == rawTweets.length
            renderWithResults res, results # Everything is done, now call render

    # Fetch the Tweets
    fetchTweets = new fetchTweets(twitterKey)
    searchOptions =
      q: searchTerm
      lang: 'en'
      count: 50
    fetchTweets.byTopic searchOptions, (results) ->
      rawTweets = []
      results.forEach (tweet) -> rawTweets.push tweet.body
      makeSentimentResults rawTweets


  if searchTerm != null
    calculateResults searchTerm
  else
    renderWithResults res, defaultRes

    

module.exports = router

