$ ->

  # Include browserify modules
  mapModule   = require('../now/now-map-module.coffee')
  barsModule  = require('../now/now-bars-module.coffee')

  # Initial render of each chart
  mapModule.startDraw()
  barsModule.generateBars()

  # Call relevant stuff when a new tweet arrives
  newTweetArrived = (tweet) ->
    mapModule.addTweetToMap tweet
    barsModule.addToStats tweet

  # Socket.io
  socket = io.connect();
  socket.on 'tweet', (tweetObj) ->
    if tweetObj.sentiment != 0
      newTweetArrived(tweetObj)

