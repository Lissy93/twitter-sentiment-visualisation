express = require('express')
router = express.Router()

tweetWordFormatter = require '../utils/format-for-keyword-vis'

router.get '/', (req, res, next) ->
  tweetWordFormatter.getDbData (data, txt) ->
    res.render 'page_cloud',
      title: 'Word Cloud'
      pageNum: 5
      data: data
module.exports = router