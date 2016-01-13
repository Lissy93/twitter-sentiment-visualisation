class MakeSummarySentences

  constructor: (@tweetObjects, @searchTerm = null) ->

  # Finds the average value for an array of numbers
  findAv = (arr) ->
    t = 0
    for i in arr then t += i
    t/arr.length

  # Finds average positive, negative and overall sentiment from list of tweets
  getAverageSentiments = (tweetObjects) ->
    posSent = []
    negSent = []
    neuSent = []

    for item in tweetObjects
      if item.sentiment > 0 then posSent.push item.sentiment
      else if item.sentiment < 0 then negSent.push item.sentiment
      else neuSent.push(0)

    avPositive:  Math.round(findAv(posSent) * 100)
    avNegative:  Math.round(findAv(negSent) * -100)
    avSentiment: Math.round(findAv(posSent.concat(negSent).concat(neuSent))*100)

  # Determines if the overall sentiment is "Positive", "Negative" or "Neutral"
  getOverallSentimentName = (avSentiment) ->
    if avSentiment > 0 then "Positive"
    else if avSentiment < 0 then "Negative"
    else "Neutral"

  makeTxtStyle = (sentiment) ->
    col =
      if sentiment > 0 or sentiment == 'Positive' then 'green'
      else if sentiment < 0 or sentiment == 'Negative' then 'darkred'
      else 'gray'
    " style='font-weight: bold; color: #{col}' "

  # Makes the sentences for the map
  makeMapSentences: () ->
    averages = getAverageSentiments(@tweetObjects)
    overallSent = getOverallSentimentName(averages.avSentiment)
    relatingTo = if @searchTerm? then "relating to <b>#{@searchTerm}</b>" else ""
    resSource = "the latest Twitter results"

    mapShowing = "Map showing <b>#{@tweetObjects.length}</b> "
    mapShowing += "of #{resSource} #{relatingTo}<br>"
    mapShowing += "Overall sentiment is: "
    mapShowing += "<span #{makeTxtStyle overallSent} >#{overallSent} "
    mapShowing += "(#{averages.avSentiment}%)</span>"

    sentimentSummary =  "Average positive: <b>#{averages.avPositive}%</b>. "
    sentimentSummary += "Average negative: <b>#{averages.avNegative}%</b>.<br>"

    mapShowing: mapShowing
    sentimentSummary: sentimentSummary
    searchTerm: if @searchTerm then @searchTerm else ''

module.exports = MakeSummarySentences