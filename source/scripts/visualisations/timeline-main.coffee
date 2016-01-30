


sinAndCos = ->
  sin = []
  cos = []
  #Data is represented as an array of {x,y} pairs.
  i = 0
  while i < 100
    sin.push
      x: i
      y: Math.sin(i / 10)
    cos.push
      x: i
      y: .5 * Math.cos(i / 10)
    i++

  #Line chart data should be sent as an array of series objects.
  [
    { values: sin, key: 'Positive', color: '#74DF00', area: true }
    { values: cos, key: 'Negative', color: '#FA5858', area: true }
  ]

nv.addGraph ->
  chart = nv.models.lineChart()
    .margin(left: 100)
    .useInteractiveGuideline(true)
    .showLegend(true)
    .showYAxis(true)
    .showXAxis(true)

  chart.xAxis.axisLabel('Time of Day').tickFormat d3.format(',r')
  chart.yAxis.axisLabel('Sentiment').tickFormat d3.format('.02f')

  myData = sinAndCos()
  d3.select('#chart svg').datum(myData).call chart

  #Update the chart when window resizes.
  nv.utils.windowResize -> chart.update(); chart
