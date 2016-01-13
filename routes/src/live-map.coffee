express = require('express')
router = express.Router()
React = require('react')
TweetsApp = React.createFactory(require('../components/TweetsApp'))
Tweet = require('../models/Tweet')

router.get '/', (req, res) ->

  Tweet.getAllTweets (tweets) ->
    reactHtml = React.renderToString(TweetsApp(tweets: tweets))
    res.render 'page_livemap',
      title: 'Live Sentiment Map'
      pageNum: 2
      markup: reactHtml
      state: JSON.stringify(tweets)
module.exports = router


