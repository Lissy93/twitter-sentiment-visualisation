express = require('express')
router = express.Router()
fetchSentimentTweets = require '../utils/fetch-sentiment-tweets'

router.post '/', (req, res) ->
  fetchSentimentTweets '', (data, average) ->
    res.json data

module.exports = router