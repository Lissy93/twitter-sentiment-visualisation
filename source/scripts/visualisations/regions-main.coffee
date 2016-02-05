
pageControls = require '../page-controls-module.coffee'
pageControls.setMainPage 'region-map'


data = [
  {'value': 'GB', 'label': 'United Kingdom'}
  {'value': 'AQ', 'label': 'Antarctica'}
  {'value': 'FJ', 'label': 'Fiji' }
]

$(document).ready ->
  locSel = '#txtLocation'
  $(locSel).autocompleter(
    source: data
    focusOpen: false
    callback: (value) -> window.location = ('/region-map/location/'+value)
  )
  $(locSel).bind 'enter', () ->
    val = $(locSel).val()
    if val.length == 2 then window.location = ('/region-map/location/'+val)
    else alert("Invalid Country Code - select an option from the dropdown menu")
  $(locSel).keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'



drawRegionsMap = ->

  data = google.visualization.arrayToDataTable(sentimentResults)
  options = {
    colorAxis: {colors: ['#DF0101', '#BDBDBD', '#04B404']}
    backgroundColor: '#2C2C2C'
    datalessRegionColor: '#D8D8D8'
    defaultColor: '#f5f5f5'
  }

  if searchRegion != '' then options.region = searchRegion

  chart = new (google.visualization.GeoChart)(document.getElementById('regions_div'))
  chart.draw data, options


google.charts.load 'current', 'packages': [ 'geochart' ]
google.charts.setOnLoadCallback drawRegionsMap
