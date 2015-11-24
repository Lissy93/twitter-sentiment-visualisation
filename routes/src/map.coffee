express = require('express')
router = express.Router()

router.get '/', (req, res, next) ->

  sampleData = [
    {
      sentiment: 0.8
      location:
        lat: 51.528735
        lng: -0.381783
    },
    {
      sentiment: 0.5
      location:
        lat: 51.522265
        lng: -0.388324
    },
    {
      sentiment: 0.2
      location:
        lat: 51.524735
        lng: -0.384753
    },
    {
      sentiment: -0.2
      location:
        lat: 51.594735
        lng: -0.314753
    },
    {
      sentiment: -0.4
      location:
        lat: 51.924735
        lng: -0.314753
    },
  ]

  res.render 'page_map', data: sampleData, title: 'Map', pageNum: 1
module.exports = router