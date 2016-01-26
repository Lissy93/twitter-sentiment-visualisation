Tweet = require '../models/Tweet' # The Tweet model
CompleteTweets = require '../utils/get-complete-tweets' # Fetches & formats data
MakeSummarySentences = require '../utils/make-summary-sentences'
removeWords = require 'remove-words'
sentimentAnalysis = require 'sentiment-analysis'

# API keys
twitterKey = require('../config/keys').twitter
googlePlacesKey = require('../config/keys').googlePlaces


class FormatWordsForCloud

  # Converts ordinary Tweet array to suitable form for word cloud
  formatResultsForCloud = (twitterResults) ->
    results = []

    tweetWords = makeTweetWords twitterResults

    for word in tweetWords
      sent = sentimentAnalysis word
      if sent != 0
        results.push
            text: word
            sentiment: sent
            freq: 1
    results


  # Make a paragraph of keywords
  makeTweetWords = (twitterResults) ->
    para = ''
    for tweet in twitterResults then para += tweet.body + ' '
    removeWords para

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
