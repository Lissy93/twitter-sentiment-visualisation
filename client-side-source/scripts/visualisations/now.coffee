

numPositiveOfTweets = 0
numNegativeOfTweets = 0

totalPositiveScore = 0
totalNegativeScore = 0

totalNumTweets = 0

regionData = [['Latitude', 'Longitude'],[51.2, -2.54]]

# Generate Initial Bar Chart
colChart = c3.generate(
  bindto: '#mini-bar-charts'
  data:
    columns: [ ['Positive', 0], ['Negative', 0] ]
    type: 'bar'
    colors:
      Positive: '#82FA58'
      Negative: '#F79F81'
  bar: width: ratio: 0.5
  axis:
    y:
      label: text: 'Weighted Proportions', position: 'outer-center'
      tick:  format: -> return '';
  )

# Render region map
drawRegionsMap = ->
  data = google.visualization.arrayToDataTable(regionData)
  options = {
    colorAxis: {colors: ['#DF0101', '#BDBDBD', '#04B404']}
    backgroundColor: '#2C2C2C'
    datalessRegionColor: '#D8D8D8'
    defaultColor: '#f5f5f5'
    showZoomOut: true
  }

  chart = new (google.visualization.GeoChart)(document.getElementById('geo-loacations'))
  chart.draw data, options


# When a new tweet arrives
window.newTweetArrived = (tweet) ->
  s = tweet.sentiment # Get the sentiment

  # Update attributes and make calculations
  totalNumTweets += 1
  if s > 0 # Positive Tweet!
    numPositiveOfTweets +=1
    totalPositiveScore += s
  else if s < 0 # Negative Tweet!
    numNegativeOfTweets +=1
    totalNegativeScore += Math.abs s

  # Update data visualizations
  if s > 0 # Positive
    colChart.load columns: [['Positive', totalPositiveScore]]
  else if s < 0 # Negative
    colChart.load columns: [['Negative', totalNegativeScore]]



google.charts.load 'current', 'packages': [ 'geochart' ]
google.charts.setOnLoadCallback drawRegionsMap


# Socket.io
if io?
  socket = io.connect();
  socket.on 'tweet', (tweetObj) ->
    if tweetObj.sentiment != 0 && tweetObj.body.indexOf('http') == -1
      window.newTweetArrived(tweetObj)

