

# Array of styles.
styles = [
  {
    'featureType': 'administrative.country'
    'elementType': 'geometry.stroke'
    'stylers': [ { 'color': '#DCE7EB' } ]
  }
  {
    'featureType': 'administrative.province'
    'elementType': 'geometry.stroke'
    'stylers': [ { 'color': '#DCE7EB' } ]
  }
  {
    'featureType': 'landscape'
    'elementType': 'geometry'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'poi'
    'elementType': 'all'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'road'
    'elementType': 'all'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'road'
    'elementType': 'labels'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'transit'
    'elementType': 'labels.icon'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'transit.line'
    'elementType': 'geometry'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'transit.line'
    'elementType': 'labels.text'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'transit.station.airport'
    'elementType': 'geometry'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'transit.station.airport'
    'elementType': 'labels'
    'stylers': [ { 'visibility': 'off' } ]
  }
  {
    'featureType': 'water'
    'elementType': 'geometry'
    'stylers': [ { 'color': '#83888B' } ]
  }
  {
    'featureType': 'water'
    'elementType': 'labels'
    'stylers': [ { 'visibility': 'off' } ]
  }
]


module.exports.styledMap = new (google.maps.StyledMapType)(styles,
  name: 'Sentiment Map'
)