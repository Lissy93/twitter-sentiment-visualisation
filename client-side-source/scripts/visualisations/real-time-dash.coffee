

# Color Scale
scaleColors = ["#a50026", "#C11940","#d73027","#DC4139","#F04539","#F5504D",
                "#FD6060","#F87575","#DD8E8E","#B4B4B4","#B4B4B4","#BCF08C",
                "#d9ef8b","#92E16E","#a6d96a","#71C96E","#66bd63","#21B04C",
                "#1a9850","#027D35","#006837"]
fillScale = d3.scale.linear()
.domain([-1,-0.9, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, -0.1,
          0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1])
.range(scaleColors)


# Global Variables
chart = 0
chartData = 0
rawData = []

# Generate the structure for the initial data object
makeData = -> [{key: "Sentiment Data", values: []}]

# Generate NVd3 Graph with options
nv.addGraph ->
  # Basic chart options
  chart = nv.models.scatterChart()
    .showDistX(true)
    .showDistY(true)
    .transitionDuration(350)
#    .color(scaleColors)
    .showLegend(false)
    .tooltipContent (key, y, e, graph) -> "<b style='max-width: 100ch'> #{graph.point.label} </b> "

  # Chart axis
  chart.xAxis
    .axisLabel('Time (HH:MM)')
    .tickFormat (d) -> d3.time.format('%I:%M') new Date(d)
  chart.yAxis
    .axisLabel('Sentiment (+/-)')
    .tickFormat (d) -> Math.round(d/10)*10 +'%'

  # Specify data and render
  rawData = makeData()
  chartData = d3.select('#real-time-scatter svg').datum(rawData)
  chartData.call chart
  nv.utils.windowResize chart.update

  chart

# Dynamically add a new point to the graph
window.addPoint = (time, sentiment, label) ->
  axisSent = sentiment + (Math.round(((Math.random()/10)-0.05) *10000)/10000)
  size = Math.round(label.length/10) + (Math.abs(sentiment) * 10)
  rawData[0].values.push {
    x: time, y: axisSent * 100, size: size, label: label, color: fillScale(sentiment)
  }
  chartData.datum(rawData).transition().duration(500).call(chart)
  nv.utils.windowResize(chart.update)

$ ->
  $('#real-time-scatter').hide()
  setTimeout(->
    $('#scatter-loader').fadeOut('slow')
    $('#real-time-scatter').slideDown('slow')
  , 1500)


# Socket.io
if io?
  socket = io.connect();
  socket.on 'anyTweet', (tweetObj) ->
    if tweetObj.sentiment != 0 && tweetObj.body.indexOf('http') == -1
      window.addPoint(new Date().getTime(), tweetObj.sentiment, tweetObj.body)