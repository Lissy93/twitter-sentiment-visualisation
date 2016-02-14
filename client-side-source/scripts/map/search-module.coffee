
initiateSearch = (map) ->

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

module.exports.initiatePlaceSearch = initiateSearch