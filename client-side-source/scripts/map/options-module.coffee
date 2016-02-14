mapOptions =
  center: new (google.maps.LatLng)(51.5068, -0.1225)
  zoom: 3
  maxZoom: 20
  streetViewControl : false
  panControl: false
  mapTypeControlOptions:
    style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
    position: google.maps.ControlPosition.LEFT_TOP
    mapTypeIds: [
      'map_style'
      google.maps.MapTypeId.SATELLITE
    ]
  zoomControlOptions: {
    style: google.maps.ZoomControlStyle.LARGE
    position: google.maps.ControlPosition.LEFT_CENTER
  }

module.exports.mapOptions = mapOptions