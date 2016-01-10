
# Where to put the globe?
container = document.getElementById('container')
# Make the globe
globe = new (DAT.Globe)(container, {imgDir: '/images/'})


data = [
  [
    'seriesA', [ 51.2, -1.2, 5]
  ]
];

i = 0
while i < data.length
  globe.addData data[i][1],
    format: 'magnitude'
    name: data[i][0]
  i++


globe.createPoints() # Create the geometry

globe.animate() # Begin animation

