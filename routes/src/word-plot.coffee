express = require('express')
router = express.Router()

tweetWordFormatter = require '../utils/format-for-keyword-vis'

router.get '/', (req, res, next) ->
  tweetWordFormatter.getDbData (data, txt) ->
    res.render 'page_wordPlot',
      title: 'Word Scatter Plot'
      pageNum: 5
      summary_text: txt
      data: data

module.exports = router