
if searchTerm == ''
  socket = io.connect()

  socket.on 'tweet', (tweetObj) ->
    heatMapItem =
      sentiment: tweetObj.sentiment
      location:
        lat: tweetObj.location.location.lat
        lng: tweetObj.location.location.lng

    window.addHeatToMap(heatMapItem)