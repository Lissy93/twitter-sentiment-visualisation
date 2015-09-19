express = require('express')
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index',
    title: 'Express'
    pageNum: 0
module.exports = router
