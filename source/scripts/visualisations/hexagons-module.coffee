


# Hexagon color scale
scaleColors = ["#C80000", "#EB3443","#F85353","#FF5A80","#EF7B96","#B1B1B1",
  "#8CD087","#7CE974","#62EC59","#42F735","#4AF43E"]
fillScale = d3.scale.linear()
.domain([-1,-0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])
.range(scaleColors)

# Initialise tooltip
tip = d3.tip().attr('class', 'd3-tip').html((d, i) ->
  s = results[i].sentiment
  col = if s > 0 then 'green' else if s < 0 then 'darkred' else 'grey'
  html = '<b>Sentiment:</b>'
  html += ' <span style=\'color:'+col+'\'>' + s + '</span> <br>'
  html += '<span>'+results[i].body+'</span>'
  html
)

#svg sizes and margins
margin = top: 30, right: 20, bottom: 20, left: 50

width = $(window).width() - margin.left - margin.right - 40
height = ($(window).height() - margin.top - margin.bottom - 80)/2
if hexPage? then if hexPage then height = height * 2

MapColumns  = Math.round(Math.sqrt(results.length*1.33))
MapRows     =  Math.round(Math.sqrt(results.length*0.66))

#The maximum radius the hexagons can have to still fit the screen
hexRadius = d3.min([
  width / ((MapColumns + 0.5) * Math.sqrt(3))
  height / ((MapRows + 1 / 3) * 1.5)
])

#Set the new height and width of the SVG
width = MapColumns * hexRadius * Math.sqrt(3)
heigth = MapRows * 1.5 * hexRadius + 0.5 * hexRadius

hexbin = d3.hexbin().radius(hexRadius)  #Set the hexagon radius

#Calculate the center positions of each hexagon
points = []
i = 0
while i < MapRows
  j = 0
  while j < MapColumns
    points.push [hexRadius * j * 1.75, hexRadius * i * 1.5]
    j++
  i++

#Create SVG element
svg = d3.select('#chart')
.append('svg')
.attr('width', width + margin.left + margin.right)
.attr('height', height + margin.top + margin.bottom)
.append('g')
.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

svg.call(tip) # call tool tip

#Start drawing the hexagons
svg.append('g')
.selectAll('.hexagon')
.data(hexbin(points))
.enter()
.append('path')
.attr('class', 'hexagon')
.attr('d', (d) -> 'M' + d.x + ',' + d.y + hexbin.hexagon())
.attr('stroke', (d, i) -> '#fff')
.attr('stroke-width', '1px')
.style('fill', (d, i) -> fillScale(results[i].sentiment))
.on 'mouseover', (d,i) ->
  tip.show(d, i)
  el = d3.select(this).transition().duration(10).style('fill-opacity', 0.3)
.on 'mouseout', (d, i) ->
  tip.hide(d, i)
  el = d3.select(this).transition().duration(1000).style('fill-opacity', 1)

