
#Heat map data
locationData1 = [
  {
    location: new (google.maps.LatLng)(51.511461, -0.0822538)
    weight: 8
  }
  {
    location: new (google.maps.LatLng)(51.511645, -0.081428)
    weight: 2
  }
  {
    location: new (google.maps.LatLng)(51.512086, -0.080687)
    weight: 4
  }
  {
    location: new (google.maps.LatLng)(51.512480, -0.078906)
    weight: 0.8
  }
  {
    location: new (google.maps.LatLng)(51.513060, -0.078349)
    weight: 1
  }
]

locationData2 = [
  {
    location: new (google.maps.LatLng)(51.514362, -0.079676)
    weight: 8
  }
  {
    location: new (google.maps.LatLng)(51.513895, -0.079462)
    weight: 2
  }
  {
    location: new (google.maps.LatLng)(51.513841, -0.078775)
    weight: 4
  }
  {
    location: new (google.maps.LatLng)(51.513547, -0.077337)
    weight: 0.8
  }
  {
    location: new (google.maps.LatLng)(51.514068, -0.078067)
    weight: 1
  }
]



# Apply heat map to map
pointArray = new (google.maps.MVCArray)(locationData1)
heatmap = new (google.maps.visualization.HeatmapLayer)(data: pointArray)

pointArray2 = new (google.maps.MVCArray)(locationData2)
heatmap2 = new (google.maps.visualization.HeatmapLayer)(data: pointArray2)

#Set gradient
gradient = [
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
heatmap.set 'gradient', gradient


module.exports.positiveHeatmap = heatmap
module.exports.negativeHeatmap = heatmap2