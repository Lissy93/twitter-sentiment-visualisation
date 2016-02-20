express = require('express')
router = express.Router()

watson = require 'watson-developer-cloud'
watsonCredentials = require('../../config/keys').watson


toneAnalyzer = watson.tone_analyzer {
  url: 'https://gateway.watsonplatform.net/tone-analyzer-beta/api/'
  username: watsonCredentials.username
  password: watsonCredentials.password
  version_date: '2016-11-02'
  version: 'v3-beta'
}

router.post '/', (req, res, next) ->
  toneAnalyzer.tone req.body, (err, data) ->
    if err then next err
    else res.json data

module.exports = router