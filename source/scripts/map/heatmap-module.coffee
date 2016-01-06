
positiveLocationData = []
negativeLocationData = []


makeLocationObject = (locationObj) ->
  new (google.maps.LatLng)(locationObj.lat, locationObj.lng)


# Make heatmap location data
sentimentResults.forEach (sentObj) ->
  if sentObj.sentiment > 0
    positiveLocationData.push({
      location: makeLocationObject(sentObj.location)
      weight: sentObj.sentiment * 10
    })
  else if sentObj.sentiment < 0
    negativeLocationData.push({
      location: makeLocationObject(sentObj.location)
      weight: Math.abs sentObj.sentiment * 10
    })


# Apply heat map to map
PositivePointArray = new (google.maps.MVCArray)(positiveLocationData)
positiveHeatmap =
  new (google.maps.visualization.HeatmapLayer)(data: PositivePointArray)

negativePointArray = new (google.maps.MVCArray)(negativeLocationData)
negativeHeatmap =
  new (google.maps.visualization.HeatmapLayer)(data: negativePointArray)


# Define gradients
positiveGradient = [
  'rgba(255,255,255,0)', 'rgba(17,178,219, 0.2)', 'rgba(18,186,186,0.4)'
  'rgba(18,194,152, 0.6)', 'rgba(19,202,119, 0.8)', 'rgb(20,210,85)'
  'rgb(20,214,68)', 'rgb(20,214,68)', 'rgb(20,214,68)', 'rgb(20,218,52)'
  'rgb(20,218,52)', 'rgb(20,218,52)', 'rgb(20,218,52)', 'rgb(21,222,35)'
  'rgb(21,222,35)', 'rgb(21,222,35)', 'rgb(21,222,35)', 'rgb(21,222,35)'
  'rgb(21,226,18)', 'rgb(21,226,18)', 'rgb(21,226,18)', 'rgb(21,226,18)'
  'rgb(21,226,18)', 'rgb(21,226,18)', 'rgb(20,220,20)', 'rgb(20,200,20)'
  'rgb(10,180,10)', 'rgb(10,160,10)', 'rgb(10,140,10)', 'rgb(10,140,10)'
  'rgb(10,140,10)'
]

negativeGradient = [
  'rgba(255,255,255,0)', 'rgba(255,229,0,0.2)', 'rgba(255,229,0,0.4)'
  'rgba(255,291,0,0.6)', 'rgba(255,291,0,0.8)', 'rgb(255,153,0)',
  'rgb(255,114,0)', 'rgb(255,76,0)', 'rgb(255,57,0)', 'rgb(255,57,0)',
  'rgb(255,38,0)', 'rgb(255,38,0)', 'rgb(255,38,0)', 'rgb(255,38,0)'
  'rgb(255,38,0)', 'rgb(255,19,0)', 'rgb(255,19,0)', 'rgb(255,19,0)'
  'rgb(255,19,0)', 'rgb(255,19,0)', 'rgb(255,0,0)', 'rgb(255,0,0)'
  'rgb(255,0,0)', 'rgb(255,0,0)', 'rgb(255,0,0)', 'rgb(255,0,0)'
  'rgb(240,0,0)', 'rgb(220,0,0)', 'rgb(210,0,0)', 'rgb(190,0,0)', 'rgb(170,0,0)'
]

# Set gradients
positiveHeatmap.set 'gradient', positiveGradient
negativeHeatmap.set 'gradient', negativeGradient

module.exports.positiveHeatmap = positiveHeatmap
module.exports.negativeHeatmap = negativeHeatmap