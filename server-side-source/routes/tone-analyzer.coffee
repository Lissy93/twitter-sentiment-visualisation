express = require('express')
router = express.Router()
router.get '/', (req, res, next) ->
  res.render 'page_tones',
    title: 'Tone Analyzer'
    pageNum: 9
module.exports = router