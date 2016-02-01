
pageControls = require '../page-controls-module.coffee'
pageControls.setMainPage 'timeline'


nv.addGraph ->

# Initiate NV chart
  chart = nv.models.lineChart()
  .margin(left: 100)
  .useInteractiveGuideline(true)
  .showLegend(true)
  .showYAxis(true)
  .showXAxis(true)
  .interpolate("basis")

  # Configure x-axis
  chart.xAxis
  .axisLabel('Time of Day')
  .tickFormat((d) -> d + ':00')

  chart.forceX([7,23])

  # Configure y-axis
  chart.yAxis
  .axisLabel('Sentiment')
  .tickFormat d3.format('.02f')

  # Specify data options
  chartData = [
    { values: results.posData, key: 'Positive', color: '#74DF00', area: true }
    { values: results.negData, key: 'Negative', color: '#FA5858', area: true }
  ]

  # Draw chart
  d3.select('#chart svg').datum(chartData).call chart

  #Update the chart when window re-sizes.
  nv.utils.windowResize -> chart.update(); chart
