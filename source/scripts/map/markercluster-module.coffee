
class MarkerClusterSetup

  constructor: (map) -> @map = map

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
        infowindow.setContent @get('title')
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