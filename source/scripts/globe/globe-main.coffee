
class ConfigureGlobe

  constructor = () -> go()

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



  go: () ->

  # Configure new globe
  globe = createGlobe()

  # Make globe data array
  data = makeGlobeData sentimentResults

  # Add data to the globe
  for d in data then globe.addData(d[1], {format: 'legend', name: d[0]})

  globe.createPoints() # Create the geometry

  globe.animate() # Begin animation

configureGlobe = new ConfigureGlobe()


vis = false


$(document).ready ->
  goToUrl = (url) -> window.location = url # Navigate to a URL
  keywordSel = 'input#txtKeyword' # Selector for the keyword search box

  showDetails = () ->
    $('#theContent').slideDown()
    $('#btnHide').text 'Hide'
    true

  hideDetails = () ->
    $('#theContent').slideUp()
    $('#btnHide').text 'Show Details'
    false

  # Submit search term, when the user presses enter
  $(keywordSel).bind 'enter', () -> goToUrl('/globe/'+$(keywordSel).val())
  $(keywordSel).keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'
  $('#btnSearch').click () -> goToUrl('/globe/'+$(keywordSel).val())

  $('#btnHide').click () ->
    if vis == true then vis = hideDetails() else vis = showDetails()



