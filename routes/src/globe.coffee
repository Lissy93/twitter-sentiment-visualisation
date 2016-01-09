express = require('express')
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'page_globe',
    title: 'Sentiment Globe'
    pageNum: 4
module.exports = router