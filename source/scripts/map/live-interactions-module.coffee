
# Adds a sentiment object to the heatmap
addHeatToMap = (sentimentObject, heatmapModule) ->

  updateLayer = (heatmapLayer, newItem) ->
    if newItem.weight < 0 then newItem.weight = Math.abs(newItem.weight)
    newData = heatmapLayer.getData().j # Get old data
    newData.push(newItem) # Add new result to it
    heatmapLayer.setData(newData) # set the updated array


  location = new (google.maps.LatLng)(sentimentObject.location.lat,
    sentimentObject.location.lng)
  newItem =
    location: location
    weight: sentimentObject.sentiment * 10

  heatmapLayer =
    if sentimentObject.sentiment > 0 then heatmapModule.positiveHeatmap
    else if sentimentObject.sentiment < 0 then heatmapModule.negativeHeatmap
    else heatmapModule.neutralHeatmap

  updateLayer(heatmapLayer, newItem)

  $('span#numRes').text(Number($('span#numRes').text())+1) # Increment counter

oldPositiveHeatData = []
oldNegativeHeatData = []

# Removes all heatmap layers
clearMap = (heatmapModule) ->
  tempPos = oldPositiveHeatData
  tempNeg = oldNegativeHeatData

  oldPositiveHeatData = heatmapModule.positiveHeatmap.getData().j
  oldNegativeHeatData = heatmapModule.negativeHeatmap.getData().j

  heatmapModule.positiveHeatmap.setData(tempPos)
  heatmapModule.neutralHeatmap.setData([])
  heatmapModule.negativeHeatmap.setData(tempNeg)

toggleHeatMap = (heatmap) ->
  heatmap.setMap if heatmap.getMap() then null else map


module.exports.addToMap = addHeatToMap
module.exports.clearMap = clearMap
module.exports.toggleHeatMap = toggleHeatMap