fs = require 'fs'
express = require('express')
router = express.Router()

findRegion =  require 'find-region-from-location'

mapTweetFormatter = require '../utils/format-tweets-for-map'

makeRegionMapData = (tweets) ->

  # Finds the average value for an array of numbers
  findAv = (arr) ->
    t = 0
    for i in arr then t += i
    Math.round(t/arr.length*100)/100

  # Group together the sentiments to their regions
  prelimResults = {}
  for tweet in tweets
    region = findRegion.country(tweet.location.lat, tweet.location.lng)
    if prelimResults[region] then prelimResults[region].sentiments.push(tweet.sentiment)
    else prelimResults[region] = {region: region, sentiments: [tweet.sentiment]}

  # Make the results array, by finding the average sentiment for each region
  results = []
  for regionKey of prelimResults
    if prelimResults.hasOwnProperty regionKey
      results.push([regionKey, findAv(prelimResults[regionKey].sentiments)])


  # Order results by sentiment, then append colounm headings and min/max values
  sortFunc = (a, b) -> if a[1] == b[1] then 0 else if a[1] < b[1] then -1 else 1
  results.sort sortFunc
  results.unshift ['Country', 'Sentiment'], ['',-0.8], ['',0.8]
  results

getRegions = () ->
  fs.readFileSync(__dirname+'../../public/data/regions.csv','utf8').split('\r\n')


# Render to page
render = (res, data, title, summaryTxt, location = '') ->
  summaryTxt.searchRegion = location
  res.render 'page_regions', # Call res.render for the map page
    data: data    # The map data
    summary_text: summaryTxt # Summary of results
    title: title  # The title of the rendered map
    pageNum: 6    # The position in the application
    csvRegions: getRegions() # List of all regions

# Call render with search term
renderSearchTerm = (res, searchTerm, location= '') ->
  mapTweetFormatter.getFreshData searchTerm, (twitterData, summaryTxt) ->
    regionData = makeRegionMapData twitterData
    render res, regionData, searchTerm+' Region Map', summaryTxt, location

# Call render for database data
renderAllData = (res, location= '') ->
  mapTweetFormatter.getDbData (data, txt) ->
    render res, makeRegionMapData(data), 'Map', txt, location

# Path for main map root page
router.get '/', (req, res) -> renderAllData res

# Path for map sub-page
router.get '/:query', (req, res) ->
  searchTerm = req.params.query # Get the search term from URL param
  if searchTerm != null then renderSearchTerm res, searchTerm
  else renderAllData res

# Path for map location sub-page
router.get '/location/:query', (req, res) ->
  location = req.params.query # Get the location from URL param
  renderAllData res, location

module.exports = router