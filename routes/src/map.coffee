express = require('express')
router = express.Router()

mapTweetFormatter = require '../utils/format-tweets-for-map'

# Main path for map page
router.get '/', (req, res) ->
  mapTweetFormatter.getDbData (data) ->
    res.render 'page_map', data: data, title: 'Map', pageNum: 1

# Path for map sub-page
router.get '/:query', (req, res, next) ->

  searchTerm = req.params.query # Get the search term from URL param

  if searchTerm != null
    mapTweetFormatter.getFreshData searchTerm, (mapData) ->
      res.render 'page_map', data: mapData, title: searchTerm+' Map', pageNum: 1
  else
    mapTweetFormatter.getDbData (data) ->
      res.render 'page_map', data: data, title: 'Map', pageNum: 1

module.exports = router