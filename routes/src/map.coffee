express = require('express')
router = express.Router()

Tweet = require '../models/Tweet'
CompleteTweets = require '../utils/get-complete-tweets'

# API keys
twitterKey = require('../config/keys').twitter
googlePlacesKey = require('../config/keys').googlePlaces

# Converts ordinary Tweet array to lat + lng array for the heat map
formatResultsForMap = (twitterResults) ->
  mapData = []
  for tweet in twitterResults
    if !tweet.location.error?
      mapData.push
        sentiment: tweet.sentiment
        location:
          lat: tweet.location.location.lat
          lng: tweet.location.location.lng
        tweet: tweet.body
  mapData

# Inserts an array of valid Tweets into the database
insertTweetsIntoDatabase = (twitterResults) ->
  for tweet in twitterResults
    tweetData =
      body:     tweet.body
      dateTime: tweet.date
      keywords  : tweet.keywords
      sentiment : tweet.sentiment
      location  : tweet.location
    if isSuitableForDb tweetData
      tweetEntry = new Tweet(tweetData) # Create new model instance from object
      tweetEntry.save (err) ->
        if err then console.log 'Error saving Tweet - ' + err

# Determines if a Tweet object is complete, if it should be saved in the db
isSuitableForDb = (tweetData) ->
  if tweetData.sentiment == 0 then return false
  if tweetData.location.error? then return false
  if !tweetData.location.location.lat? then return false
  if !tweetData.location.location.lng? then return false
  return true

# Calls methods to fetch and format Tweets from the database
renderWithDatabaseResults = (cb) ->
  Tweet.getAllTweets (tweets) ->
    cb formatResultsForMap tweets

# Calls methods to fetch fresh Twitter, sentiment, and place data
renderWithFreshData = (searchTerm, cb) ->
  completeTweets = new CompleteTweets(twitterKey, googlePlacesKey)
  completeTweets.go searchTerm, (results) ->
    mapData = formatResultsForMap(results)
    insertTweetsIntoDatabase(results)
    cb mapData

# Main path for map page
router.get '/', (req, res) ->
  renderWithDatabaseResults (data) ->
    res.render 'page_map', data: data, title: 'Map', pageNum: 1

# Path for map sub-page
router.get '/:query', (req, res, next) ->

  searchTerm = req.params.query # Get the search term from URL param

  if searchTerm != null
    renderWithFreshData searchTerm, (mapData) ->
      res.render 'page_map', data: mapData, title: searchTerm+' Map', pageNum: 1
  else
    renderWithDatabaseResults (data) ->
      res.render 'page_map', data: data, title: 'Map', pageNum: 1

module.exports = router