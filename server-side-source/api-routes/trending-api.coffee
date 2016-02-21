express = require('express')
router = express.Router()
FetchTweets = require 'fetch-tweets'
twitterKey  = require('../config/keys').twitter
asyncTweets = require '../utils/async-tweets'
placeLookup = require 'place-lookup'
placesKey   = require('../config/keys').googlePlaces

fetchTweets = new FetchTweets twitterKey



findAverageSentiment = (tweetArr) ->
  totalSentiment = 0
  for tweet in tweetArr.tweets then totalSentiment += tweet.sentiment
  totalSentiment / tweetArr.tweets.length

findOriginalTrend = (searchTerm, searchTerms, trends) ->
  for st, i in searchTerms then if st == searchTerm then return trends[i]
  {}


makeTrendRequest = (woeid, cb) ->
  fetchTweets.trending woeid, (trendingResults) ->

    # Make a list of searchTerms from the trending topics
    searchTerms = []
    originalTrends = []
    i = 0
    while searchTerms.length < 10
      trend = trendingResults[i].trend.replace(/[\W_]+/g, '')
      if trend.length > 0
        searchTerms.push trend
        originalTrends.push trendingResults[i]
      i++

    # Make the actual request
    asyncTweets searchTerms, (twitterResults) ->

    #Make the results array
      results = []
      for tweetArr in twitterResults
        t = findOriginalTrend(tweetArr.searchTerm, searchTerms, trendingResults)
        results.push
          topic: t.trend
          sentiment: findAverageSentiment tweetArr
          volume: t.volume
      cb results


router.post '/', (req, res) ->
  woeid = 1
  makeTrendRequest woeid, (results) -> res.json {trends: results}



router.post '/:location', (req, res) ->
  fuzzyLocation = req.params.location
  placeLookup fuzzyLocation, placesKey, (placeResults) ->
    if !placeResults.error?
      lat = placeResults.location.lat
      lng = placeResults.location.lng
      fetchTweets.closestTrendingWoeid lat, lng, (places) ->
        woeid = places[0].woeid
        makeTrendRequest woeid, (results) ->
          res.json {trends: results, location: placeResults.place_name}
    else res.json {}
module.exports = router