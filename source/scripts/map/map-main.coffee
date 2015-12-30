initialize = ->

  # Include all map components
  themeModule   = require('../map/theme-module.coffee')
  optionsModule = require('../map/options-module.coffee')
  heatmapModule = require('../map/heatmap-module.coffee')
  searchModule  = require('../map/search-module.coffee')
  autocompleteModule  = require('../map/autocomplete-module.coffee')

  # Get the map, and set the map options
  map = new (google.maps.Map)(document.getElementById('map-canvas'),\
    optionsModule.mapOptions)

  # Apply map theme
  map.mapTypes.set 'map_style', themeModule.styledMap
  map.setMapTypeId 'map_style'

  # Apply heat map
  heatmapModule.positiveHeatmap.setMap map
  heatmapModule.negativeHeatmap.setMap map

  # Cluster map
  markers = []
  infowindow = new google.maps.InfoWindow()


  pathToNothing = '/images/nothing.png'

  image =
    url: pathToNothing
    size: new (google.maps.Size)(25, 25)
    origin: new (google.maps.Point)(0, 0)
    anchor: new (google.maps.Point)(12, 12)

  shape =
    coords: [1, 1, 1, 20, 18, 20, 18, 1]
    type: 'poly'

  sentimentResults.forEach (sentObj) ->
    latLng = new google.maps.LatLng(sentObj.location.lat,sentObj.location.lng)
    marker = new google.maps.Marker({
      position: latLng
      map: map
      icon: image
      shape: shape
      title : sentObj.tweet
    })

    google.maps.event.addListener marker, 'click', (evt) ->
      infowindow.setContent @get('title')
      infowindow.open map, this

    markers.push(marker)

  styles = [
    {
      url: pathToNothing
      height: 35
      width: 35
      anchor: [16, 0]
      textColor: 'transparent'
      textSize: 10
    }
    {
      url: pathToNothing
      height: 45
      width: 45
      anchor: [24, 0]
      textColor: 'transparent'
      textSize: 11
    }
    {
      url: pathToNothing
      height: 55
      width: 55
      anchor: [32, 0]
      textColor: 'transparent'
      textSize: 12
    }
  ]



  style =
    maxZoom: 100
    gridSize: 40
    styles: styles


  mc = new MarkerClusterer(map, markers, style)


  # Initiate the places auto-complete and map search
  searchModule.initiatePlaceSearch map

  # Call autocomplete constructor
  data = [
    {
      'value': '11'
      'label': 'one'
    }
    {
      'value': '2'
      'label': 'two'
    }
    {
      'value': '3'
      'label': 'three'
    }
  ]
  $(document).ready ->
    $('input#txtKeyword').autocompleter source: data

google.maps.event.addDomListener window, 'load', initialize

