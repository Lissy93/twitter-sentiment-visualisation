express = require('express')
router = express.Router()

findRegion =  require 'find-region-from-location'

mapTweetFormatter = require '../utils/format-tweets-for-map'

makeRegionMapData = (tweets) ->
  results = [['Country', 'Sentiment']]
  for tweet in tweets
    region = findRegion.country(tweet.location.lat, tweet.location.lng)
    results.push([region, tweet.sentiment])
  results


# Render to page
render = (res, data, title, summaryTxt) ->
  res.render 'page_regions', # Call res.render for the map page
    data: data    # The map data
    summary_text: summaryTxt # Summary of results
    title: title  # The title of the rendered map
    pageNum: 1    # The position in the application

# Call render with search term
renderSearchTerm = (res, searchTerm) ->
  mapTweetFormatter.getFreshData searchTerm, (twitterData, summaryTxt) ->
    regionData = makeRegionMapData twitterData
    render res, regionData, searchTerm+' Region Map', summaryTxt

# Call render for database data
renderAllData = (res) ->
  mapTweetFormatter.getDbData (data, txt) ->
    render res, makeRegionMapData(data), 'Map', txt

# Path for main map root page
router.get '/', (req, res) -> renderAllData res

# Path for map sub-page
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  if searchTerm != null then renderSearchTerm res, searchTerm
  else renderAllData res

module.exports = router