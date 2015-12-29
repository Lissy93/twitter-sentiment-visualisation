
positiveLocationData = []
negativeLocationData = []


makeLocationObject = (locationObj) ->
  new (google.maps.LatLng)(locationObj.lat, locationObj.lng)

makeHeatData = () ->
  sentimentResults.forEach (sentObj) ->
    if sentObj.sentiment > 0
      positiveLocationData.push({
        location: new (google.maps.LatLng)(sentObj.location.lat, sentObj.location.lng)
        weight: sentObj.sentiment * 10
      })
    else if sentObj.sentiment < 0
      negativeLocationData.push({
        location: new (google.maps.LatLng)(sentObj.location.lat, sentObj.location.lng)
        weight: Math.abs sentObj.sentiment * 10
      })

makeHeatData()

# Apply heat map to map
PositivePointArray = new (google.maps.MVCArray)(positiveLocationData)
positiveHeatmap = new (google.maps.visualization.HeatmapLayer)(data: PositivePointArray)

negativePointArray = new (google.maps.MVCArray)(negativeLocationData)
negativeHeatmap = new (google.maps.visualization.HeatmapLayer)(data: negativePointArray)

#Set gradients
positiveGradient = [
  'rgba(0, 255, 0, 0)'
  'rgba(0, 255, 0, 1)'
  'rgba(0, 255, 0, 1)'
  'rgba(25, 255, 0, 1)'
  'rgba(51, 255, 0, 1)'
  'rgba(76, 255, 0, 1)'
  'rgba(102, 255, 0, 1)'
  'rgba(127, 255, 0, 1)'
  'rgba(153, 255, 0, 1)'
  'rgba(178, 255, 0, 1)'
  'rgba(204, 255, 0, 1)'
  'rgba(229, 255, 0, 1)'
  'rgba(255, 255, 0, 1)'
]
positiveHeatmap.set 'gradient', positiveGradient

negativeGradient = [
  'rgba(0, 255, 255, 0)'
  'rgba(0, 255, 255, 1)'
  'rgba(0, 191, 255, 1)'
  'rgba(0, 127, 255, 1)'
  'rgba(0, 63, 255, 1)'
  'rgba(0, 0, 255, 1)'
  'rgba(0, 0, 223, 1)'
  'rgba(0, 0, 191, 1)'
  'rgba(0, 0, 159, 1)'
  'rgba(0, 0, 127, 1)'
  'rgba(0, 0, 100, 1)'
  'rgba(0, 0, 90, 1)'
  'rgba(0, 0, 40, 1)'
]
negativeHeatmap.set 'gradient', negativeGradient

module.exports.positiveHeatmap = positiveHeatmap
module.exports.negativeHeatmap = negativeHeatmap