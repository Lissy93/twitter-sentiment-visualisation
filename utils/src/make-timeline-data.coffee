
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
sentimentAnalysis = require 'sentiment-analysis'
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey

class MakeTimeLineData

  # Converts ordinary Tweet array to suitable form for word cloud
  formatResultsForTimeLine = (twitterResults) ->
    # Create result structures
    results = {posData: [], negData: []}
    posTotals = {
      7:[],8:[],9:[],10:[],11:[],12:[],13:[],14:[],15:[],
      16:[],17:[],18:[],19:[],20:[],21:[],22:[],23:[]
    }
    negTotals = {
      7:[],8:[],9:[],10:[],11:[],12:[],13:[],14:[],15:[],
      16:[],17:[],18:[],19:[],20:[],21:[],22:[],23:[]
    }

    # Populate array of list of sentiments for each hour in pos and neg totals
    for tweetObj in twitterResults
      tweetHour = new Date(tweetObj.dateTime).getHours()
      if tweetObj.sentiment > 0
        if posTotals[tweetHour] then posTotals[tweetHour].push tweetObj.sentiment
      else if tweetObj.sentiment < 0
        if negTotals[tweetHour] then negTotals[tweetHour].push tweetObj.sentiment

    # Func to find the positive average of all number elements in a list
    findAv = (arr) ->
      total = 0
      for i in arr then total += i
      ans = if total != 0 then total / arr.length else 0
      Math.round(ans*100)/100


    # Find the average of pos and neg totals, and assign the value to results
    for key of posTotals
      if posTotals.hasOwnProperty key
        av = findAv posTotals[key]
        if av != 0 then results.posData.push {x: key, y: av}
    for key of negTotals
      if negTotals.hasOwnProperty key
        av = findAv negTotals[key]
        if av != 0 then results.negData.push {x: key, y: Math.abs av}

    # Done :) return populated results object
    results


  # Merge two sets of results
  mergeResults = (res1, res2) -> res1.concat res2

  # Calls methods to fetch and format Tweets from the database
  renderWithDatabaseResults: (cb) ->
    Tweet.getAllTweets (tweets) ->
      cb formatResultsForTimeLine(tweets)

  # Calls methods to fetch fresh Twitter, sentiment, and place data
  renderWithFreshData: (searchTerm, cb) ->
    fetchTweets.byTopic searchTerm, (webTweets) ->
      Tweet.searchTweets searchTerm, (dbTweets) -> # Fetch matching db results
        data = mergeResults webTweets, dbTweets
        cb formatResultsForTimeLine(data, true)

mtld = new MakeTimeLineData()
module.exports.getFreshData = mtld.renderWithFreshData
module.exports.getDbData = mtld.renderWithDatabaseResults
