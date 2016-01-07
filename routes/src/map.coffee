express = require('express')
router = express.Router()

mapTweetFormatter = require '../utils/format-tweets-for-map'

# Render to page
render = (res, data, title) ->
  res.render 'page_map', # Call res.render for the map page
    data: data    # The map data
    summary_text: mapTweetFormatter.getSentence # Summary of results
    title: title  # The title of the rendered map
    pageNum: 1    # The position in the application

# Call render with search term
renderSearchTerm = (res, searchTerm) ->
  mapTweetFormatter.getFreshData searchTerm, (mapData) ->
    render res, mapData, searchTerm+' Map'

# Call render for database data
renderAllData = (res) ->
  mapTweetFormatter.getDbData (data) -> render res, data, 'Map'

# Path for main map root page
router.get '/', (req, res) -> renderAllData res

# Path for map sub-page
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  if searchTerm != null then renderSearchTerm res, searchTerm
  else renderAllData res

module.exports = router