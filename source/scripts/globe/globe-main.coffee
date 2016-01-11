
container = document.getElementById('container')

# Colors for the bars
negCol  = 'rgb(255,0,0)'
neutCol = 'rgb(150,150,150)'
posCol  = 'rgb(0,255,0)'

# Create new instance of globe, passing in options
globe = new (DAT.Globe)(container, {
  imgDir: '/images/',
  colorFn: (label) -> new THREE.Color([negCol, neutCol, posCol][label])
})

console.log sentimentResults

series = []

for tweetObject in sentimentResults
  series.push tweetObject.location.lat
  series.push tweetObject.location.lng
  series.push 3 # Sentiment (0-8)
  series.push 0 # Colour (1|2|3)

# Sample data
data = [ [ 'seriesA', series ] ];

# Add data to the globe
for d in data then globe.addData(d[1], {format: 'legend', name: d[0]})

globe.createPoints() # Create the geometry

globe.animate() # Begin animation

