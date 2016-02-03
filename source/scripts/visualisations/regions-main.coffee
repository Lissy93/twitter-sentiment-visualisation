
#console.log sentimentResults

drawRegionsMap = ->
  data = google.visualization.arrayToDataTable(sentimentResults)
  options = {
    colorAxis: {colors: ['#FA5858', '#BDBDBD', '#58FA58']}
    backgroundColor: '#81d4fa'
    datalessRegionColor: '#D8D8D8'
    defaultColor: '#f5f5f5'
  }
  chart = new (google.visualization.GeoChart)(document.getElementById('regions_div'))
  chart.draw data, options


google.charts.load 'current', 'packages': [ 'geochart' ]
google.charts.setOnLoadCallback drawRegionsMap
