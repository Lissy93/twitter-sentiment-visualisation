
watson = require('watson-developer-cloud')
watsonCredentials = require('../config/keys').watson


# Fetch tone analyser results from BlueMix instance
fetchToneAnalyzerResults = (tweetsArr, callback) ->
  text = ''
  for tweet in tweetsArr then text += tweet.body + ' '
  tone_analyzer = watson.tone_analyzer(
    username: watsonCredentials.username
    password: watsonCredentials.password
    version: 'v3-beta'
    version_date: '2016-02-11')
  tone_analyzer.tone { text: text }, (err, tone) ->
    if err then console.log err; callback {}
    else callback tone

module.exports = fetchToneAnalyzerResults