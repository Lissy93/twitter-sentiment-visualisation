initialize = ->
  # Array of styles.
  styles = [
    { stylers: [
      { hue: '#00ffe6' }
      { saturation: -20 }
    ] }
    {
      featureType: 'road'
      elementType: 'geometry'
      stylers: [
        { lightness: 100 }
        { visibility: 'simplified' }
      ]
    }
    {
      featureType: 'road'
      elementType: 'labels'
      stylers: [ { visibility: 'off' } ]
    }
  ]

  # Create a new StyledMapType object, passing it the array of styles,
  styledMap = new (google.maps.StyledMapType)(styles, name: 'Sentiment Map')
  mapOptions =
    center: new (google.maps.LatLng)(51.5068, -0.1225)
    zoom: 13
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

  # Get map then set style
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
  map.mapTypes.set 'map_style', styledMap
  map.setMapTypeId 'map_style'

  #Heat map data
  taxiData = [
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

  #Heat map options
  toggleHeatmap = ->
    heatmap.setMap if heatmap.getMap() then null else map
    return

  changeGradient = ->
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
    heatmap.set 'gradient', if heatmap.get('gradient') then null else gradient
    return

  changeRadius = ->
    heatmap.set 'radius', if heatmap.get('radius') then null else 20
    return

  changeOpacity = ->
    heatmap.set 'opacity', if heatmap.get('opacity') then null else 0.2
    return


  # Apply heat map to map
  pointArray = new (google.maps.MVCArray)(taxiData)
  heatmap = new (google.maps.visualization.HeatmapLayer)(data: pointArray)
  heatmap.setMap map

  # Configure autocomplete and map search
  input = document.getElementById('txtLocation')
  autocomplete = new (google.maps.places.Autocomplete)(input)
  infowindow = new (google.maps.InfoWindow)

  # Prepare for putting markers on map
  marker = new (google.maps.Marker)(
    map: map
    anchorPoint: new (google.maps.Point)(0, -29))
  google.maps.event.addListener autocomplete, 'place_changed', ->
    infowindow.close()
    marker.setVisible false
    place = autocomplete.getPlace()
    if !place.geometry
      window.alert 'Autocomplete\'s returned place contains no geometry'
      return

    # If the place has a geometry, then display marker on the map.
    if place.geometry.viewport
      map.fitBounds place.geometry.viewport
    else
      map.setCenter place.geometry.location
      map.setZoom 17 # Why 17? Because it looks good.
    marker.setIcon
      url: place.icon
      size: new (google.maps.Size)(71, 71)
      origin: new (google.maps.Point)(0, 0)
      anchor: new (google.maps.Point)(17, 34)
      scaledSize: new (google.maps.Size)(35, 35)
    marker.setPosition place.geometry.location
    marker.setVisible true
    address = ''
    if place.address_components
      address_parts = place.address_components
      address = [
        address_parts[1] and address_parts[1].short_name or ''
        address_parts[0] and address_parts[0].short_name or ''
        address_parts[2] and address_parts[2].short_name or ''
      ].join(' ')
    infowindow.setContent "<div><strong>#{place.name}</strong><br>" + address
    infowindow.open map, marker
    return
  return

google.maps.event.addDomListener window, 'load', initialize

