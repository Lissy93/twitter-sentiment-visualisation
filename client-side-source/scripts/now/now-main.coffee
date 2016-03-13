$ ->

  # Include browserify modules
  mapModule   = require('../now/now-map-module.coffee')
  barsModule  = require('../now/now-bars-module.coffee')
  countModule = require('../now/now-count-module.coffee')

  # Initial render of each chart
  mapModule.startDraw()
  barsModule.generateBars()
  countModule.startCountCharts()

  # Call relevant stuff when a new tweet arrives
  newTweetArrived = (tweet) ->
    mapModule.addTweetToMap tweet
    barsModule.addToStats tweet
    #countModule.newTweetArrived tweet

  # Socket.io
  socket = io.connect();
  socket.on 'tweet', (tweetObj) ->
    if tweetObj.sentiment != 0
      newTweetArrived(tweetObj)
  socket.on 'anyTweet', (tweetObj) ->
    if tweetObj.sentiment != 0
      countModule.newTweetArrived tweetObj

