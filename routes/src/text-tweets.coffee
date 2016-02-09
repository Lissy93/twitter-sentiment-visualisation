
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
sentimentAnalysis = require 'sentiment-analysis'
moment = require 'moment'
makeClickWords = require '../utils/make-click-words'
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
removeWords = require 'remove-words'
express = require('express')
router = express.Router()


# Converts Tweet objects into the right format
formatTweets = (tweets) ->
  pos = []
  neg = []

  tweets.sort (b, a) -> new Date(a.dateTime).getTime() - new Date(b.dateTime).getTime()
  tweets.slice(0,350)

  for t in tweets
    body = makeClickWords t.body
    location = t.location.place_name
    sentiment = if t.sentiment then t.sentiment else sentimentAnalysis t.body
    keywords = removeWords t.body
    r = body: body, location: location, sentiment: sentiment, keywords: keywords
    r.dateTime = moment(new Date(t.dateTime)).fromNow()
    if sentiment > 0 then pos.push r else if sentiment < 0 then neg.push r

  pos.sort (b, a) -> parseFloat(a.sentiment) - parseFloat(b.sentiment)
  neg.sort (a, b) -> parseFloat(a.sentiment) - parseFloat(b.sentiment)
  positive: pos.slice(0,100), negative: neg.slice(0,100)

# Main route - no search term
router.get '/', (req, res, next) ->
  Tweet.getAllTweets (tweets) ->
    res.render 'page_textTweets',
      title: 'View Raw Tweets'
      pageNum: 7
      data: formatTweets tweets
      searchTerm: ''

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  fetchTweets.byTopic searchTerm, (tweets) ->
    res.render 'page_textTweets',
      title: searchTerm+' raw tweets'
      pageNum: 7
      data: formatTweets tweets
      searchTerm: searchTerm

module.exports = router