initialize = ->

  # Include all map components
  themeModule   = require('../map/theme-module.coffee')
  optionsModule = require('../map/options-module.coffee')
  heatmapModule = require('../map/heatmap-module.coffee')
  searchModule  = require('../map/search-module.coffee')
  autocompleteModule  = require('../map/autocomplete-module.coffee')
  markerClusterModule  = require('../map/markercluster-module.coffee')

  # Get the map, and set the map options
  map = new (google.maps.Map)(document.getElementById('map-canvas'),\
    optionsModule.mapOptions)

  # Apply map theme
  map.mapTypes.set 'map_style', themeModule.styledMap
  map.setMapTypeId 'map_style'

  # Apply heat map
  heatmapModule.positiveHeatmap.setMap map
  heatmapModule.negativeHeatmap.setMap map
  heatmapModule.neutralHeatmap.setMap map

  # Apply invisible marker cluster to map, so user can click
  markerClusterModule map

  # Initiate the places auto-complete and map search
  searchModule.initiatePlaceSearch map

  # Call autocomplete constructor
  data = [
    {'value': '11', 'label': 'one'}
    {'value': '2',  'label': 'two'}
    {'value': '3',  'label': 'three' }
  ]

  $(document).ready ->
    goToUrl = (url) -> window.location = url # Navigate to a URL
    keywordSel = 'input#txtKeyword' # Selector for the keyword search box
    $(keywordSel).autocompleter source: data # Turn on auto complete search

    # Submit search term, when the user presses enter
    $(keywordSel).bind 'enter', () -> goToUrl('/map/'+$(keywordSel).val())
    $(keywordSel).keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'

google.maps.event.addDomListener window, 'load', initialize

