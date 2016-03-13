$ ->


  # Initialise Count Variables
  numPositiveOfTweets = 0
  numNegativeOfTweets = 0
  totalPositiveScore = 0
  totalNegativeScore = 0
  totalNumTweets = 0

  # Initialise geo config
  geoChart = null
  regionData = [
    ['Lat', 'Long', 'Sentiment', 'Size', {role: 'tooltip', p:{html:true}}]
    [51.2, -2.54, 0.1, 0.1,'']
  ]
  geoOptions = {
    colorAxis: {colors: ['#DF0101', '#BDBDBD', '#04B404']}
    backgroundColor: '#2C2C2C'
    datalessRegionColor: '#D8D8D8'
    defaultColor: '#f5f5f5'
    showZoomOut: true
  }

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
    geoChart =
        new (google.visualization.GeoChart)(document.getElementById('geo-chart'))
    geoChart.draw data, geoOptions


  addTweetToMap = (tweet) ->
    regionData.push [tweet.location.location.lat, tweet.location.location.lng, tweet.sentiment, Math.abs(tweet.sentiment), tweet.body]
    newMapData = google.visualization.arrayToDataTable(regionData)
    geoChart.draw newMapData, geoOptions


  addToStats = (tweet) ->
    # Update attributes and make calculations
    s = tweet.sentiment # Get the sentiment
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



  # When a new tweet arrives
  newTweetArrived = (tweet) ->
    addTweetToMap tweet
    addToStats tweet

  google.charts.load 'current', 'packages': [ 'geochart' ]
  google.charts.setOnLoadCallback drawRegionsMap


  # Socket.io
  if io?
    socket = io.connect();
    socket.on 'tweet', (tweetObj) ->
      if tweetObj.sentiment != 0
        newTweetArrived(tweetObj)

