
class ConfigureGlobe


  constructor: -> @globe

  constants = {
    maxHeight: 4  # Maximum height of the bars on the globe
    neutralSentiment: 0.2 # The sentiment weighting to be assigned to neutral
    colors: [
      'rgb(240,40,40)'    # Negative Color (red)
      'rgb(180,180,180)'  # Neutral Color  (gray)
      'rgb(40,240,40)'    # Positive Color (green)
    ]
    containerId: 'container'  # The ID of the HTML container to place the globe
    imageDir: '/images/'       # The directory storing all globe-related images
  }

  makeBarHeight = (sentiment) ->
    if sentiment == 0 then sentiment = constants.neutralSentiment
    height = sentiment * constants.maxHeight
    if height >= 0 then height else Math.abs height # Always return positive


  makeBarColIndex = (sentiment) ->
    if sentiment > 0 then return 2
    else if sentiment < 0 then return 0
    else return 1

  makeGlobeData = (sentimentResults) ->
    series = []
    for tweetObject in sentimentResults
      series.push tweetObject.location.lat
      series.push tweetObject.location.lng
      series.push makeBarHeight tweetObject.sentiment
      series.push makeBarColIndex tweetObject.sentiment
    [ [ 'Sentiment', series ] ];

  createGlobe = () ->
    new (DAT.Globe)(document.getElementById(constants.containerId), {
      imgDir: constants.imageDir,
      colorFn: (label) -> new THREE.Color(constants.colors[label])
    })


  addNewPoint: (sentimentObj) ->
    data = [
      sentimentObj.location.lat
      sentimentObj.location.lng
      makeBarHeight sentimentObj.sentiment
      makeBarColIndex sentimentObj.sentiment
    ]
    @globe.addData(data, {format: 'legend', name: 'newData'})
    @globe.createPoints()


  go: () ->

    # Configure new globe
    @globe = createGlobe()

    # Make globe data array
    data = makeGlobeData sentimentResults

    # Add data to the globe
    for d in data then @globe.addData(d[1], {format: 'legend', name: d[0]})

    @globe.createPoints() # Create the geometry

    @globe.animate() # Begin animation


module.exports = ConfigureGlobe