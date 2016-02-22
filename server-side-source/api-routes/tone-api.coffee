express = require('express')
router = express.Router()
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'

watson = require 'watson-developer-cloud'
watsonCredentials = require('../config/keys').watson

toneAnalyzer = watson.tone_analyzer {
  url: 'https://gateway.watsonplatform.net/tone-analyzer-beta/api/'
  username: watsonCredentials.username
  password: watsonCredentials.password
  version_date: '2016-11-02'
  version: 'v3-beta'
}

noBodyProvided = (req, res, next) ->
  makeBody = (twAr) ->
    tweetBody = ''
    for tw in twAr then tweetBody += tw.body + ' '
    tweetBody = tweetBody.replace(/(?:https?|ftp):\/\/[\n\S]+/g, '')
    tweetBody = tweetBody.replace(/[^A-Za-z0-9 ]/g, '').substring(0, 5000)

  toneRes = (body) ->
    toneAnalyzer.tone {text: body}, (err, data) ->
      if err then next err else res.json data

  if req.body.searchTerm? && req.body.searchTerm != ''
    fetchSentimentTweets req.body.searchTerm, (r) -> toneRes makeBody r
  else fetchSentimentTweets '', (r) -> toneRes makeBody r


router.post '/', (req, res, next) ->
  if !req.body.text? or req.body.text == '' then noBodyProvided req, res, next
  else
    toneAnalyzer.tone req.body, (err, data) ->
      if err then next err else res.json data

module.exports = router