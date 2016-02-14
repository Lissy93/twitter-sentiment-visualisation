
removeWords = require 'remove-words'

class MarkerClusterSetup

  constructor: (map) -> @map = map


  # Creates the HTML for the info window displayed when a maker is clicked
  makeInfoWindowContent = (markerData) ->

    uniformWord = (word) -> (''+word).toLowerCase().replace /\W/g, ''

    # Make the coloured score string (e.g. '30% Positive')
    scoreString =
      if markerData.sentiment > 0
        "<b style='color: green'>#{markerData.sentiment*100}% Positive</b>"
      else if markerData.sentiment < 0
        "<b style='color: darkred'>#{markerData.sentiment*-100}% Negative</b>"
      else "<b style='color: grey'>Neutral</b>"

    # Make clickable Tweet text
    clickWords = removeWords markerData.tweet # Array of keywords
    htmlTweet = ''
    aStyle = 'style="color: black; font-weight: bold;" ' # style for hyperlinks
    for word in markerData.tweet.split " "
      if uniformWord(word) in clickWords
        htmlTweet += "<a #{aStyle} href='/map/#{uniformWord word}'>#{word}</a> "
      else htmlTweet += "#{word} "

    # Put everything together to return
    "<div style='max-width: 25em'><p>#{htmlTweet}</p>#{scoreString}</div>"


  makeShape = () ->
    coords: [1, 1, 1, 20, 18, 20, 18, 1]
    type: 'poly'

  makeImage = (path) ->
      url: path
      size: new (google.maps.Size)(25, 25)
      origin: new (google.maps.Point)(0, 0)
      anchor: new (google.maps.Point)(12, 12)

  makeMarkers = (image, shape) ->
    infowindow = new google.maps.InfoWindow() # the pop-up thingy
    markers = [] # List of markers to be populated and returned

    # For each sentiment result, create a marker and push it to the array
    sentimentResults.forEach (sentObj) ->
      latLng = new google.maps.LatLng(sentObj.location.lat,sentObj.location.lng)
      marker = new google.maps.Marker({
        position: latLng
        map: @map
        icon: image
        shape: shape
        title : sentObj.tweet
      })
      # Action listener to show window when user presses marker
      google.maps.event.addListener marker, 'click', (evt) ->
        infowindow.setContent makeInfoWindowContent sentObj
        infowindow.open @map, this

      markers.push(marker)

    markers

  makeStyles = (path) ->
    maxZoom: 100
    gridSize: 40
    styles: [
      {
        url: path
        height: 35
        width: 35
        anchor: [16, 0]
        textColor: 'transparent'
        textSize: 10
      }
      {
        url: path
        height: 45
        width: 45
        anchor: [24, 0]
        textColor: 'transparent'
        textSize: 11
      }
      {
        url: path
        height: 55
        width: 55
        anchor: [32, 0]
        textColor: 'transparent'
        textSize: 12
      }
    ]

  start: ->
    pathToNothing = '/images/nothing.png'
    shape = makeShape()
    image = makeImage pathToNothing
    markers = makeMarkers image, shape
    styles = makeStyles pathToNothing

    new MarkerClusterer @map, markers, styles

# Export the stuff
module.exports = (map) -> (new MarkerClusterSetup map).start()