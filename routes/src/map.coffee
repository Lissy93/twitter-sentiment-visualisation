express = require('express')
router = express.Router()

CompleteTweets = require '../utils/get-complete-tweets'

sampleData = [
  {
    sentiment: 0.8
    location:
      lat: 51.528735
      lng: -0.381783
  },
  {
    sentiment: 0.5
    location:
      lat: 51.522265
      lng: -0.388324
  },
  {
    sentiment: 0.2
    location:
      lat: 51.524735
      lng: -0.384753
  },
  {
    sentiment: -0.2
    location:
      lat: 51.594735
      lng: -0.314753
  },
  {
    sentiment: -0.4
    location:
      lat: 51.924735
      lng: -0.314753
  }
]

router.get '/', (req, res, next) ->
  res.render 'page_map', data: sampleData, title: 'Map', pageNum: 1


router.get '/:query', (req, res, next) ->

  # Keys and instance variables
  twitterKey = require('../config/keys').twitter
  googlePlacesKey = require('../config/keys').googlePlaces
  searchTerm = req.params.query # Get the search term from URL param

  # Method will generate an object with all calculated sentiments for tweet
  calculateResults = (searchTerm) ->
    completeTweets = new CompleteTweets(twitterKey, googlePlacesKey)
    completeTweets.go searchTerm, (results) ->
      mapData = []
      for tweet in results
        if !tweet.location.error?
          mapData.push
            sentiment: tweet.sentiment
            location:
              lat: tweet.location.location.lat
              lng: tweet.location.location.lng

      res.render 'page_map', data: mapData, title: searchTerm+' Map', pageNum: 1

  if searchTerm != null
    calculateResults searchTerm
  else
    res.render 'page_map', data: sampleData, title: 'Map', pageNum: 1

module.exports = router