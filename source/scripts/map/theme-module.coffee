

# Array of styles.
styles = [
  { stylers: [
    { hue: '#00ffe6' }
    { saturation: -20 }
  ] }
  {
    featureType: 'road'
    elementType: 'geometry'
    stylers: [
      { lightness: 100 }
      { visibility: 'simplified' }
    ]
  }
  {
    featureType: 'road'
    elementType: 'labels'
    stylers: [ { visibility: 'off' } ]
  }
]

module.exports.styledMap = new (google.maps.StyledMapType)(styles, name: 'Sentiment Map')