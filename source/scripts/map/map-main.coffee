

initialize = ->

  # Include all map components
  themeModule   = require('../map/theme-module.coffee')
  optionsModule = require('../map/options-module.coffee')
  heatmapModule = require('../map/heatmap-module.coffee')
  searchModule  = require('../map/search-module.coffee')

  # Get the map, and set the map options
  map = new (google.maps.Map)(document.getElementById('map-canvas'),\
    optionsModule.mapOptions)

  # Apply map theme
  map.mapTypes.set 'map_style', themeModule.styledMap
  map.setMapTypeId 'map_style'

  # Apply heat map
  heatmapModule.positiveHeatmap.setMap map
  heatmapModule.negativeHeatmap.setMap map


  # Places autocomplete, and map search
  searchModule.initiatePlaceSearch map

  return

google.maps.event.addDomListener window, 'load', initialize

