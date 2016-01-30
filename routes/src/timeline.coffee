express = require('express')
router = express.Router()

tweetTimeFormatter = require '../utils/make-timeline-data'

router.get '/', (req, res, next) ->
  tweetTimeFormatter.getDbData (data, txt) ->
    res.render 'page_timeline',
      title: 'Time Line'
      pageNum: 3
      data: data

router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  tweetTimeFormatter.getFreshData searchTerm, (data, txt) ->
    res.render 'page_timeline',
      title: 'Time Line'
      pageNum: 3
      data: data

module.exports = router