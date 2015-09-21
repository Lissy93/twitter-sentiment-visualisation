express = require('express')
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'page_map', title: 'Map', pageNum: 1
module.exports = router