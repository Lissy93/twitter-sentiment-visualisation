

# Color Scale
scaleColors = ["#a50026", "#a50026","#d73027","#d73027","#f46d43","#f46d43",
                "#fdae61","#fdae61","#fee08b","#B4B4B4","#B4B4B4","#d9ef8b",
                "#d9ef8b","#a6d96a","#a6d96a","#66bd63","#66bd63","#1a9850",
                "#1a9850","#006837","#006837"]

# Global Variables
chart = 0
chartData = 0
rawData = []
sentimentToIndex = {}

# Generate the structure for the initial data object
makeData = ->
  data = []
  groups = []
  p = -1
  i = 0
  while p < 1
    q =  Math.round(p*10)/10
    groups.push q
    data.push {key: "#{groups[i]*100}%", values: []}
    sentimentToIndex[q]=i
    p += 0.1
    i++
  data

# Generate NVd3 Graph with options
nv.addGraph ->
  # Basic chart options
  chart = nv.models.scatterChart()
    .showDistX(true)
    .showDistY(true)
    .transitionDuration(350)
    .color(scaleColors)
    .showLegend(false)
    .tooltipContent (key, y, e, graph) -> " <h5> #{graph.point.label} </h5> "

  # Chart axis
  chart.xAxis
    .axisLabel('Time')
    .tickFormat (d) -> d3.time.format('%I:%M') new Date(d)
  chart.yAxis.axisLabel('Sentiment').tickFormat d3.format('.02f')

  # Specify data and render
  rawData = makeData()
  chartData = d3.select('#real-time-scatter svg').datum(rawData)
  chartData.call chart
  nv.utils.windowResize chart.update

  chart

# Dynamically add a new point to the graph
window.addPoint = (time, sentiment, label) ->
  size = Math.round(label.length/10) + (sentiment * 10)
  rawData[sentimentToIndex[Math.round(sentiment*10)/10]].values.push {
    x: time, y: sentiment * 100, size: size, label: label
  }
  chartData.datum(rawData).transition().duration(500).call(chart)
  nv.utils.windowResize(chart.update)

