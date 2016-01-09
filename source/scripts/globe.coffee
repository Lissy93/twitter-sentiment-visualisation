# Where to put the globe?
container = document.getElementById('container')
# Make the globe
globe = new (DAT.Globe)(container)

data = [
  [
    'seriesA', [ 51.2, -1.2, 5]
  ]
];

# Tell the globe about your JSON data
i = 0
while i < data.length
  globe.addData data[i][1],
    format: 'magnitude'
    name: data[i][0]
  i++
# Create the geometry
globe.createPoints()
# Begin animation
globe.animate()

