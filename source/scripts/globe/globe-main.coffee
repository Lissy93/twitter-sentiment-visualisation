
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

# Sample data
data = [
  [
    'seriesA', [ 51.2, -1.2, 1, 0,
                 51.0, -1.0, 2, 1,
                 50.2, -0.6, 3, 2]
  ]
];

# Add data to the globe
for d in data then globe.addData(d[1], {format: 'legend', name: d[0]})

globe.createPoints() # Create the geometry

globe.animate() # Begin animation

