express = require('express')
router = express.Router()

router.get '/', (req, res) ->
  res.render 'page_realtime',
    title: 'Real-time Dashboard | Sentiment Sweep'
    pageNum: 13

module.exports = router