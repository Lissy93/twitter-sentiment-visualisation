Tweet = require '../models/Tweet' # The Tweet model
CompleteTweets = require '../utils/get-complete-tweets' # Fetches & formats data
MakeSummarySentences = require '../utils/make-summary-sentences'

# API keys
twitterKey = require('../config/keys').twitter
googlePlacesKey = require('../config/keys').googlePlaces


class FormatWordsForCloud

  # Converts ordinary Tweet array to suitable form for word cloud
  formatResultsForCloud = (twitterResults) ->
#    mapData = []
#    for tweet in twitterResults
#      if !tweet.location.error?
#        mapData.push
#          text: ''
#          sentiment
#          sentiment: tweet.sentiment
#          location:
#            lat: blurLocationData tweet.location.location.lat
#            lng: blurLocationData tweet.location.location.lng
#          tweet: tweet.body
#    mapData
    [
      {text: 'Wheatley', sentiment: -1, freq: 28}
      {text: 'tuna', sentiment: -0.6, freq: 12}
      {text: 'brown', sentiment: -0.4, freq: 20}
      {text: 'rain', sentiment: -0.2, freq: 15}
      {text: 'neutral', sentiment: 0, freq: 8}
      {text: 'coke', sentiment: 0.2, freq: 10}
      {text: 'corn flakes', sentiment: 0.4, freq: 25}
      {text: 'JavaScript', sentiment: 0.6, freq: 10}
      {text: 'Lucozade', sentiment: 0.8, freq: 20}
      {text: 'Nothing!!', sentiment: 1, freq: 50}
      {text: 'Lorem', sentiment: -0.7, freq: 18}
      {text: 'Ipsum', sentiment: -0.2, freq: 32}
      {text: 'Dolor', sentiment: 0.6, freq: 38}
      {text: 'Siet', sentiment: 0.5, freq: 28}
      {text: 'Ammet', sentiment: 1, freq: 15}
    ]



  # Inserts an array of valid Tweets into the database, if not already
  insertTweetsIntoDatabase = (twitterResults) ->
    for tweet in twitterResults
      tweetData =
        body:     tweet.body
        dateTime: tweet.date
        keywords  : tweet.keywords
        sentiment : tweet.sentiment
        location  : tweet.location
      if isSuitableForDb tweetData
        Tweet.findOneAndUpdate
          body: tweetData.body,
          tweetData,
          upsert: true,
          (err) -> if err then console.log 'ERROR UPDATING TWEET - '+err

  # Determines if a Tweet object is complete & if it should be saved in the db
  isSuitableForDb = (tweetData) ->
    if tweetData.sentiment == 0 then return false
    if tweetData.location.error? then return false
    if !tweetData.location.location.lat? then return false
    if !tweetData.location.location.lng? then return false
    return true

  # Merge two sets of results
  mergeResults = (res1, res2) -> res1.concat res2

  # Make sentence description for map
  makeSentence = (data, searchTerm) ->
    (new MakeSummarySentences data, searchTerm).makeMapSentences()

  # Calls methods to fetch and format Tweets from the database
  renderWithDatabaseResults: (cb) ->
    Tweet.getAllTweets (tweets) ->
      cb formatResultsForCloud(tweets), makeSentence(tweets, null)

# Calls methods to fetch fresh Twitter, sentiment, and place data
  renderWithFreshData: (searchTerm, cb) ->
    completeTweets = new CompleteTweets(twitterKey, googlePlacesKey)
    completeTweets.go searchTerm, (webTweets) ->
      insertTweetsIntoDatabase(webTweets) # Add new Tweets to the db
      Tweet.searchTweets searchTerm, (dbTweets) -> # Fetch matching db results
        data = mergeResults webTweets, dbTweets
        cb formatResultsForCloud(data), makeSentence(data, searchTerm)

fwfc = new FormatWordsForCloud()
module.exports.getFreshData = fwfc.renderWithFreshData
module.exports.getDbData = fwfc.renderWithDatabaseResults
