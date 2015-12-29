express = require('express')
router = express.Router()
React = require('react')
TweetsApp = React.createFactory(require('../components/TweetsApp'))
Tweet = require('../models/Tweet')
streamTweets  = require('stream-tweets')
streamHandler = require('../utils/stream-handler')

module.exports = (server)->

  router.get '/', (req, res) ->

    io = require('socket.io').listen(server)

    credentials = require('../config/keys').twitter

    twit = new streamTweets(credentials)

    keyword = 'oxford'

    twit.stream(keyword, (stream)->
      streamHandler(stream,io)
    )

    Tweet.getTweets 0, 0, (tweets) ->
      reactHtml = React.renderToString(TweetsApp(tweets: tweets))
      res.render 'page_livemap',
        title: 'Live Sentiment Map'
        pageNum: 2
        markup: reactHtml
        state: JSON.stringify(tweets)
  router