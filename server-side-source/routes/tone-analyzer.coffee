express = require('express')
router = express.Router()
router.get '/', (req, res, next) ->
  res.render 'page_tones',
    title: 'Tone Analyzer'
    searchTerm: ''
    pageNum: 9

router.get '/:query', (req, res, next) ->
  res.render 'page_tones',
    title: 'Tone Analyzer'
    searchTerm: req.params.query
    pageNum: 9
module.exports = router