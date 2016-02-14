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
    totalPositive: posSent.length
    totalNegative: negSent.length

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


  makeGlobeSentence = (tweetObjects, relTo, averages, overallSent) ->
    numRes = "<b><span id='numRes'>#{tweetObjects.length}</span></b>"
    overallSentTxt = "<span #{makeTxtStyle overallSent} >#{overallSent}"
    overallSentTxt += "(#{averages.avSentiment}%)</span>"
    positivePercent = "<span #{makeTxtStyle 1}>#{averages.avPositive}%</span>"
    negativePercent = "<span #{makeTxtStyle -1}>#{averages.avNegative}%</span>"
    s = "Globe displaying #{numRes} sentiment values calculated "
    s += "from Twitter results #{relTo} "
    s += "the overall sentiment is #{overallSentTxt}."
    s += "<br><br>"
    s += "#{averages.totalPositive} Tweets are positive "
    s += "with an average sentiment of #{positivePercent} "
    s += "and #{averages.totalNegative} Tweets are negative "
    s += "with an average sentiment of #{negativePercent}."
    s


  makeMapSentences = (tweetObjects, averages, overallSent, relTo) ->
    numRes = "<b><span id='numRes'>#{tweetObjects.length}</span></b>"
    mapShowing = "Map showing #{numRes} "
    mapShowing += "of the latest Twitter results #{relTo}<br>"
    mapShowing += "Overall sentiment is: "
    mapShowing += "<span #{makeTxtStyle overallSent} >#{overallSent} "
    mapShowing += "(#{averages.avSentiment}%)</span>"

    p = makeTxtStyle 1
    n = makeTxtStyle -1

    sentimentSummary="Average positive: <b #{p}>#{averages.avPositive}%</b>.<br>"
    sentimentSummary+="Average negative: <b #{n}>#{averages.avNegative}%</b>."

    mapShowing: mapShowing
    sentimentSummary: sentimentSummary


  # Makes the sentences for the map
  makeMapSentences: () ->
    averages = getAverageSentiments(@tweetObjects)
    overallSent = getOverallSentimentName(averages.avSentiment)
    relTo = if @searchTerm? then "relating to <b>#{@searchTerm}</b>" else ""

    mapSentences = makeMapSentences @tweetObjects, averages, overallSent, relTo
    mapShowing: mapSentences.mapShowing
    sentimentSummary: mapSentences.sentimentSummary
    globeSentence: makeGlobeSentence @tweetObjects, relTo, averages, overallSent
    searchTerm: if @searchTerm then @searchTerm else ''


module.exports = MakeSummarySentences