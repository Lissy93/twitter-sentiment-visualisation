express = require('express')
router = express.Router()

router.get '/', (req, res) ->
  res.render 'page_now',
    title: 'The world right now | Sentiment Sweep'
    pageNum: 15

module.exports = router