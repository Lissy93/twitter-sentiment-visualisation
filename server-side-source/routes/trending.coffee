express = require('express')
router = express.Router()


router.get '/', (req, res, next) ->
  res.render 'page_trending',
    title: 'Trending Now'
    pageNum: 10
    location: ''

router.get '/:query', (req, res) ->
  location = req.params.query # Get the search term from URL param
  res.render 'page_trending',
    title: 'Trending in '+location
    pageNum: 10
    location: location

module.exports = router