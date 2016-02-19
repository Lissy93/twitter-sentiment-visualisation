
requestDbData = (tweetBody) ->

  makePieData = (tweetArr) ->
    res = {searchTerm: '', pieChart: {}}
    pieChart = {positive: 0, neutral: 0, negative: 0}
    for tweet in tweetArr
      if tweet.sentiment > 0 then pieChart.positive += 1
      else if tweet.sentiment < 0 then pieChart.negative += 1
      else pieChart.neutral += 1
    res.pieChart = pieChart
    res


  # Called after results are returned, initiates the rendering process
  renderResults = (dbRes) ->
    window.drawDonuts([makePieData(results), makePieData(dbRes)])

  # Make the actual request
  $.post('/api/db', {}, (results) -> renderResults results)

$(document).ready ->
  requestDbData tweetBody


