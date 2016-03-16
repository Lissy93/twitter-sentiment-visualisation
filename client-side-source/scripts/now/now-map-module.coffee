
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

# Render region map
drawRegionsMap = ->
  data = google.visualization.arrayToDataTable(regionData)
  geoChart =
    new (google.visualization.GeoChart)(document.getElementById('geo-chart'))
  geoChart.draw data, geoOptions

# Add tweet to map
addTweetToMap = (tweet) ->
  if regionData.length > 300 then regionData.splice(1,1)
  regionData.push [tweet.location.location.lat, tweet.location.location.lng, tweet.sentiment, Math.abs(tweet.sentiment), tweet.body]
  if google.visualization?
    newMapData = google.visualization.arrayToDataTable(regionData)
    geoChart.draw newMapData, geoOptions
  if regionData.length > 5 && regionData.length < 10
    $('#geo-chart-loader').fadeOut('slow')
    $('#geo-chart').slideDown('slow')


startDraw = () ->
  google.charts.load 'current', 'packages': [ 'geochart' ]
  google.charts.setOnLoadCallback drawRegionsMap


module.exports.addTweetToMap = addTweetToMap
module.exports.startDraw = startDraw