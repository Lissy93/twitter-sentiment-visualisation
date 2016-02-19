express = require('express')
router = express.Router()

entityExtraction =  require 'haven-entity-extraction'
hpKey = require('../config/keys').hp


# Formats tweets into a massive tweet body
formatText = (tweetBody) ->
  tweetBody = tweetBody.replace(/(?:https?|ftp):\/\/[\n\S]+/g, '')
  tweetBody =  tweetBody.replace(/[^A-Za-z0-9 ]/g, '')
  tweetBody = tweetBody.substring(0, 5000)

router.post '/', (req, res) ->
  entityExtraction formatText(req.body.text), hpKey, (data) ->
    res.json data

module.exports = router