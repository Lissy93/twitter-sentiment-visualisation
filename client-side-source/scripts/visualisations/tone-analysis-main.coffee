
renderToneBars = require '../visualisations/render-tone-bars-module.coffee'
renderRadarChart = require '../visualisations/radar-module.coffee'

# Press enter to search
require('../page-controls-module.coffee').setMainPage 'tone-analyzer'

# Called when server returns results, calls functions to draw all charts
renderResults = (results) ->
  renderToneBars results
  if showAllCharts? && showAllCharts then renderRadarChart results

# Called when page has loaded, initiates the request
makeRequest = (params) ->
  $.post('/api/tone', params, (results) -> renderResults results)


$(document).ready ->
  # Hide empty containers to start with
  j = 1; while j <= 3 then $('#toneResults'+j).hide(); j++

  # Call function which makes actual request
  if st? and st != '' then makeRequest {'searchTerm': st }
  else if tweetBody?  then makeRequest {'text': tweetBody }
