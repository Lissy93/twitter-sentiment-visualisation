express = require('express')
router = express.Router()

mapTweetFormatter = require '../utils/format-tweets-for-map'

# Render to page
render = (res, data, title, summaryTxt) ->
  res.render 'page_regions', # Call res.render for the map page
    data: data    # The map data
    summary_text: summaryTxt # Summary of results
    title: title  # The title of the rendered map
    pageNum: 1    # The position in the application

# Call render with search term
renderSearchTerm = (res, searchTerm) ->
  mapTweetFormatter.getFreshData searchTerm, (mapData, summaryTxt) ->
    render res, mapData, searchTerm+' Region Map', summaryTxt

# Call render for database data
renderAllData = (res) ->
  mapTweetFormatter.getDbData (data, txt) ->  render res, data, 'Map', txt

# Path for main map root page
router.get '/', (req, res) -> renderAllData res

# Path for map sub-page
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  if searchTerm != null then renderSearchTerm res, searchTerm
  else renderAllData res

module.exports = router