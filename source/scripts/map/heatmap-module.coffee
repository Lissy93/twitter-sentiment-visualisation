
positiveLocationData = []
negativeLocationData = []

makeHeatData = () ->
  sentimentResults.forEach (sentObj) ->
    if sentObj.sentiment > 0
      positiveLocationData.push({
        location: new (google.maps.LatLng)(sentObj.location.lat, sentObj.location.lng)
        weight: 8
      })
    else if sentObj.sentiment < 0
      negativeLocationData.push({
        location: new (google.maps.LatLng)(sentObj.location.lat, sentObj.location.lng)
        weight: 8
      })

makeHeatData()

# Apply heat map to map
PositivePointArray = new (google.maps.MVCArray)(positiveLocationData)
positiveHeatmap = new (google.maps.visualization.HeatmapLayer)(data: PositivePointArray)

negativePointArray = new (google.maps.MVCArray)(negativeLocationData)
negativeHeatmap = new (google.maps.visualization.HeatmapLayer)(data: negativePointArray)

#Set gradient
positiveGradient = [
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
  'rgba(63, 0, 91, 1)'
  'rgba(127, 0, 63, 1)'
  'rgba(191, 0, 31, 1)'
  'rgba(255, 0, 0, 1)'
]
positiveHeatmap.set 'gradient', positiveGradient

module.exports.positiveHeatmap = positiveHeatmap
module.exports.negativeHeatmap = negativeHeatmap