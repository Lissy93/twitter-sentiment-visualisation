
if searchTerm == ''
  url = require('../client-scripts-config.coffee').uri

  socket = io.connect(url)

  socket.on 'tweet', (tweetObj) ->
    heatMapItem =
      sentiment: tweetObj.sentiment
      location:
        lat: tweetObj.location.location.lat
        lng: tweetObj.location.location.lng

    window.addHeatToMap(heatMapItem)