# Show Incompatible with Mobile Toast
compatStr = "<p><span style='color: #F78181;'>Incompatible Device. </span><br>"
compatStr += "Use a PC or tablet to access full functionality</p>"
if $( window ).width() < 600 then Materialize.toast(compatStr, 4000)

positiveLocationData = []
negativeLocationData = []
neutralLocationData  = []

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

  else
    neutralLocationData.push({
      location: makeLocationObject(sentObj.location)
      weight: 5
    })


# Apply heat map to map
PositivePointArray = new (google.maps.MVCArray)(positiveLocationData)
positiveHeatmap =
  new (google.maps.visualization.HeatmapLayer)(data: PositivePointArray)

negativePointArray = new (google.maps.MVCArray)(negativeLocationData)
negativeHeatmap =
  new (google.maps.visualization.HeatmapLayer)(data: negativePointArray)

neutralPointArray = new (google.maps.MVCArray)(neutralLocationData)
neutralHeatmap =
  new (google.maps.visualization.HeatmapLayer)(data: neutralPointArray)


# Define gradients
positiveGradient = [
  'rgba(255,255,255,0)', 'rgba(20,180,240, 0.2)', 'rgba(20,185,220,0.4)'
  'rgba(20,190,210, 0.6)', 'rgba(20,195,200, 0.8)', 'rgb(20,210,190)'
  'rgb(20,215,180)', 'rgb(20,220,170)', 'rgb(20,225,160)', 'rgb(20,230,150)'
  'rgb(20,235,140)', 'rgb(20,240,130)', 'rgb(20,245,120)', 'rgb(20,246,100)'
  'rgb(20,247,90)', 'rgb(20,248,85)', 'rgb(20,249,80)', 'rgb(21,250,75)'
  'rgb(21,251,70)', 'rgb(21,252,65)', 'rgb(21,253,60)', 'rgb(21,254,55)'
  'rgb(20,255,50)', 'rgb(20,255,45)', 'rgb(20,255,40)', 'rgb(20,255,35)'
  'rgb(19,255,30)', 'rgb(19,255,28)', 'rgb(19,255,25)', 'rgb(19,255,23)'
  'rgb(18,255,20)', 'rgb(17,255,19)', 'rgb(16,255,18)', 'rgb(15,255,17)'
  'rgb(14,255,16)', 'rgb(13,255,15)', 'rgb(12,255,14)', 'rgb(11,255,13)'
  'rgb(10,255,10)', 'rgb(9,255,5)', 'rgb(8,255,0)', 'rgb(7,255,0)'
  'rgb(6,255,0)', 'rgb(5,255,0)', 'rgb(4,250,0)', 'rgb(3,245,0)'
  'rgb(2,240,0)', 'rgb(1,235,0)', 'rgb(0,230,0)', 'rgb(0,225,0)'
  'rgb(0,220,0)', 'rgb(0,215,0)', 'rgb(0,210,0)', 'rgb(0,205,0)'
  'rgb(0,200,0)', 'rgb(0,195,0)', 'rgb(0,190,0)', 'rgb(0,185,0)'
]

negativeGradient = [
  'rgba(255,255,255,0)', 'rgba(255,255,0,0.2)', 'rgba(255,255,0,0.4)'
  'rgba(255,245,0,0.6)', 'rgba(255,235,0,0.8)', 'rgb(255,225,0)',
  'rgb(255,215,0)', 'rgb(255,200,0)', 'rgb(255,180,0)', 'rgb(255,160,0)',
  'rgb(255,150,0)', 'rgb(255,145,0)', 'rgb(255,140,0)', 'rgb(255,135,0)',
  'rgb(255,130,0)', 'rgb(255,125,0)', 'rgb(255,120,0)', 'rgb(255,115,0)',
  'rgb(255,110,0)', 'rgb(255,95,0)', 'rgb(255,90,0)', 'rgb(255,80,0)',
  'rgb(255,70,0)', 'rgb(255,60,0)', 'rgb(255,50,0)', 'rgb(255,45,0)',
  'rgb(255,40,0)', 'rgb(255,35,0)', 'rgb(255,30,0)', 'rgb(255,25,0)'
  'rgb(255,20,0)', 'rgb(255,19,0)', 'rgb(255,18,0)', 'rgb(255,17,0)'
  'rgb(255,16,0)', 'rgb(255,15,0)', 'rgb(255,14,0)', 'rgb(255,13,0)'
  'rgb(255,12,0)', 'rgb(255,11,0)', 'rgb(255,10,0)', 'rgb(255,9,0)'
  'rgb(255,6,0)', 'rgb(255,4,0)', 'rgb(255,2,0)', 'rgb(255,0,0)'
  'rgb(240,0,0)', 'rgb(220,0,0)', 'rgb(210,0,0)', 'rgb(190,0,0)', 'rgb(170,0,0)'
]

neutralGradient = [
  'rgba(160,160,160,0)', 'rgba(150,150,150,0.2)', 'rgba(140,140,140,0.5)',
  'rgba(130,130,130,0.7)', 'rgba(120,120,120,0.9)', 'rgb(100,100,100)',
  'rgb(90,90,90)', 'rgb(80,80,80)', 'rgb(70,70,70)', 'rgb(60,60,60)',
  'rgb(50,50,50)', 'rgb(40,40,40)', 'rgb(35,35,35)', 'rgb(30,30,30)'
]

# Set gradients
positiveHeatmap.set 'gradient', positiveGradient
negativeHeatmap.set 'gradient', negativeGradient
neutralHeatmap.set 'gradient', neutralGradient

# Set opacity
positiveHeatmap.set('opacity', 0.7);
negativeHeatmap.set('opacity', 0.7);

module.exports.positiveHeatmap = positiveHeatmap
module.exports.negativeHeatmap = negativeHeatmap
module.exports.neutralHeatmap = neutralHeatmap