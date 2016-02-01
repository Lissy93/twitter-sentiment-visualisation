
#console.log sentimentResults

drawRegionsMap = ->
  data = google.visualization.arrayToDataTable([
      ['Country', 'Popularity'],
      ['Germany', 200],
      ['United States', 300],
      ['Brazil', 400],
      ['Canada', 500],
      ['France', 600],
      ['RU', 700]
    ])
  options = {}
  chart = new (google.visualization.GeoChart)(document.getElementById('regions_div'))
  chart.draw data, options


google.charts.load 'current', 'packages': [ 'geochart' ]
google.charts.setOnLoadCallback drawRegionsMap
