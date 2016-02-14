
pageControls = require '../page-controls-module.coffee'
pageControls.setMainPage 'region-map'


# Takes the raw CSV string and returns a nice list of JSON region objects
convertCsvToJson = (csvRegions) ->
  regions = []
  for r in csvRegions.splice 1,csvRegions.length # For each line in CSV file
    r = r.match(/(".*?"|[^",\s]+)(?=\s*,|\s*$)/g) # Break into array
    for e, i in r then r[i] = r[i].replace(/['"]+/g, '').trim() # Neaten
    regions.push { # Create a JSON object for region, and push to results
      country: r[0], alpha2_code: r[1], alpha3_code: r[2],
      numeric_code: r[3], latitude: Number(r[4]), longitude: Number(r[5])
    }
  regions # Done, return regions

# Convert regions to JSON
regions = convertCsvToJson csvRegions

# Make data array
data = []
for r in regions then data.push value: r.alpha2_code, label: r.country


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
    showZoomOut: true
  }

  if searchRegion != '' then options.region = searchRegion

  chart = new (google.visualization.GeoChart)(document.getElementById('regions_div'))
  chart.draw data, options


google.charts.load 'current', 'packages': [ 'geochart' ]
google.charts.setOnLoadCallback drawRegionsMap
