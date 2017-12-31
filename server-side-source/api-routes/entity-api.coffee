express = require('express')
router = express.Router()

entityExtraction =  require 'haven-entity-extraction'
hpKey = require('../config/keys').hp


# Formats tweets into a massive tweet body
formatText = (tweetBody) ->
  tweetBody = tweetBody.replace(/(?:https?|ftp):\/\/[\n\S]+/g, '')
  tweetBody =  tweetBody.replace(/[^A-Za-z0-9 ]/g, '')
  tweetBody = tweetBody.substring(0, 5000)

formatData = (data) ->
  results = []
  if data == null then return []
  for key in Object.keys data
    category = key.charAt(0).toUpperCase()+key.split('_')[0].slice(1)
    results.push name: category, items: data[key]
  results = results.sort (a, b) -> b.items.length - a.items.length

router.post '/', (req, res) ->
  entityExtraction formatText(req.body.text), hpKey, (data) ->
    console.log data
    res.json formatData data

module.exports = router