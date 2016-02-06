express = require('express')
router = express.Router()


router.get '/', (req, res, next) ->
#  tweetTimeFormatter.getDbData (data, txt) ->
  res.render 'page_textTweets',
    title: 'View Raw Tweets'
    pageNum: 7
    data: {}
    searchTerm: ''

router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
#  tweetTimeFormatter.getFreshData searchTerm, (data, txt) ->
  res.render 'page_textTweets',
    title: searchTerm+' raw tweets'
    pageNum: 7
    data: {}
    searchTerm: searchTerm

module.exports = router