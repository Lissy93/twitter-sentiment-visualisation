initialize = ->
  # Create an array of styles.
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
  # as well as the name to be displayed on the map type control.
  styledMap = new (google.maps.StyledMapType)(styles, name: 'Styled Map')
  mapOptions =
    center: new (google.maps.LatLng)(51.5309, -0.1225)
    zoom: 13
    mapTypeControlOptions: mapTypeIds: [
      google.maps.MapTypeId.ROADMAP
      'map_style'
    ]
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
  map.mapTypes.set 'map_style', styledMap
  map.setMapTypeId 'map_style'
  input = document.getElementById('txtLocation')
  autocomplete = new (google.maps.places.Autocomplete)(input)
  infowindow = new (google.maps.InfoWindow)
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
    # If the place has a geometry, then present it on a map.
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
      address = [
        place.address_components[0] and place.address_components[0].short_name or ''
        place.address_components[1] and place.address_components[1].short_name or ''
        place.address_components[2] and place.address_components[2].short_name or ''
      ].join(' ')
    infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
    infowindow.open map, marker
    return
  return

google.maps.event.addDomListener window, 'load', initialize