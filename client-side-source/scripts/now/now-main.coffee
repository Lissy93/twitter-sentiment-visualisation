$ ->

  # Include browserify modules
  mapModule   = require '../now/now-map-module.coffee'
  barsModule  = require '../now/now-bars-module.coffee'
  countModule = require '../now/now-count-module.coffee'
  topTwModule = require '../now/now-top-tweets-module.coffee'

  # Initial render of each chart
  mapModule.startDraw()
  barsModule.generateBars()
  countModule.startCountCharts()
  topTwModule.init()

  # Call relevant stuff when a new tweet arrives
  newTweetArrived = (tweet) ->
    mapModule.addTweetToMap tweet
    barsModule.addToStats tweet

  # Socket.io
  socket = io.connect();
  socket.on 'tweet', (tweetObj) ->
    if tweetObj.sentiment != 0
      newTweetArrived(tweetObj)
  socket.on 'anyTweet', (tweetObj) ->
    if tweetObj.sentiment != 0
      countModule.newTweetArrived tweetObj
      if tweetObj.body.indexOf('http') == -1 and
        (tweetObj.sentiment > 0.6 or tweetObj.sentiment < -0.6)
          topTwModule.addTweet(tweetObj)

