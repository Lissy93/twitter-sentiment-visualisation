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
    mapTypeControlOptions: mapTypeIds: [
      google.maps.MapTypeId.ROADMAP
      'map_style'
    ]

  # Get map then set style
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
  map.mapTypes.set 'map_style', styledMap
  map.setMapTypeId 'map_style'

  #Heat map
  taxiData = [
    new (google.maps.LatLng)(51.511461, -0.0822538)
    new (google.maps.LatLng)(51.511645, -0.081428)
    new (google.maps.LatLng)(51.512086, -0.080687)
    new (google.maps.LatLng)(51.512480, -0.078906)
    new (google.maps.LatLng)(51.513060, -0.078349)
  ]
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