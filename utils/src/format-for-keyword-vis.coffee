Tweet = require '../models/Tweet' # The Tweet model
CompleteTweets = require '../utils/get-complete-tweets' # Fetches & formats data
MakeSummarySentences = require '../utils/make-summary-sentences'
removeWords = require 'remove-words'
sentimentAnalysis = require 'sentiment-analysis'
FetchTweets = require 'fetch-tweets'

# API keys
twitterKey = require('../config/keys').twitter
googlePlacesKey = require('../config/keys').googlePlaces

fetchTweets = new FetchTweets twitterKey

class FormatWordsForCloud

  # Converts ordinary Tweet array to suitable form for word cloud
  formatResultsForCloud = (twitterResults, allWords = false) ->
    results = []
    tweetWords = makeTweetWords twitterResults
    for word in tweetWords
      sent = sentimentAnalysis word
      if allWords or sent != 0
        f = results.filter((item) -> item.text == word)
        if f.length == 0 then results.push(text: word, sentiment: sent, freq: 1)
        else for res in results then  if res.text == word then res.freq++
    results

  findTopWords = (cloudWords) ->
    posData = cloudWords.filter (cw) -> cw.sentiment > 0
    negData = cloudWords.filter (cw) -> cw.sentiment < 0

    posData.sort (a, b) -> parseFloat(a.freq) - parseFloat(b.freq)
    posData = posData.reverse().slice(0,5)
    negData.sort (a, b) -> parseFloat(a.freq) - parseFloat(b.freq)
    negData = negData.reverse().slice(0,5)

    {topPositive: posData, topNegative: negData}


  # Make a paragraph of keywords
  makeTweetWords = (twitterResults) ->
    para = ''
    for tweet in twitterResults then para += tweet.body + ' '
    removeWords para, false

  # Merge two sets of results
  mergeResults = (res1, res2) -> res1.concat res2

  # Make sentence description for map
  makeSentence = (data, searchTerm) ->
    (new MakeSummarySentences data, searchTerm).makeMapSentences()

  # Calls methods to fetch and format Tweets from the database
  renderWithDatabaseResults: (cb) ->
    Tweet.getAllTweets (tweets) ->
      cloudData = formatResultsForCloud(tweets)
      sentence =  makeSentence(tweets, null)
      sentence.topWords = findTopWords cloudData
      cb cloudData, sentence

# Calls methods to fetch fresh Twitter, sentiment, and place data
  renderWithFreshData: (searchTerm, cb) ->
    fetchTweets.byTopic searchTerm, (webTweets) ->
      Tweet.searchTweets searchTerm, (dbTweets) -> # Fetch matching db results
        data = mergeResults webTweets, dbTweets
        cloudData = formatResultsForCloud(data, true)
        sentence =  makeSentence(data, searchTerm)
        sentence.topWords = findTopWords cloudData
        cb cloudData, sentence

fwfc = new FormatWordsForCloud()
module.exports.getFreshData = fwfc.renderWithFreshData
module.exports.getDbData = fwfc.renderWithDatabaseResults
