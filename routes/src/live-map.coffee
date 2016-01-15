#express = require('express')
#router = express.Router()
React = require('react')
TweetsApp = React.createFactory(require('../components/TweetsApp'))
Tweet = require('../models/Tweet')

express = require('express')
router = express.Router()

mapTweetFormatter = require '../utils/format-tweets-for-map'

router.get '/', (req, res) ->
  mapTweetFormatter.getDbData (data, txt) ->

    res.render 'page_livemap',          # Call res.render for the map page
      data: data                        # The map data
      summary_text: txt                 # Summary of results
      title: 'Real-time sentiment map'  # The title of the rendered map
      pageNum: 1                        # The position in the application


module.exports = router
