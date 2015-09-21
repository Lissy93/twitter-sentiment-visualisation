express = require('express')
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'page_timeline',
    title: 'Time Line'
    pageNum: 3
module.exports = router