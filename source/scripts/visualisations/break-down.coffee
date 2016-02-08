
margin = { top: 40, right: 10, bottom: 10, left: 10 }
width = 960 - (margin.left) - (margin.right)
height = 500 - (margin.top) - (margin.bottom)

scaleColors = ["#a50026","#d73027","#f46d43","#fdae61","#fee08b","#B4B4B4",
  "#d9ef8b","#a6d96a","#66bd63","#1a9850","#006837"]

color = d3.scale.linear()
  .domain([-1,-0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])
  .range(scaleColors)

treemap = d3.layout.treemap()
  .size([width, height])
  .sticky(true).value((d) -> d.size )

div = d3.select('div#tree')
  .append('div')
  .style('position', 'relative')
  .style('width', width + margin.left + margin.right + 'px')
  .style('height', height + margin.top + margin.bottom + 'px')
  .style('left', margin.left + 'px')
  .style('top', margin.top + 'px')

position = ->
  @style('left', (d) -> d.x + 'px')
  .style('top', (d) -> d.y + 'px')
  .style('width', (d) -> Math.max(0, d.dx - 1) + 'px' )
  .style 'height', (d) -> Math.max(0, d.dy - 1) + 'px'

root = data
node = div.datum(root)
  .selectAll('.tree-node')
  .data(treemap.nodes)
  .enter()
  .append('div')
  .attr('class', (d) -> 'tree-node ' + if d.topic? then 'tooltipped')
  .call(position)
  .attr('data-position', 'top')
  .attr('data-tooltip', (d) -> if d.topic != '' then d.topic else '[no topic]')
  .style('background', (d) -> if d.children then color(d.name) else null)
  .text((d) -> if d.children then null else d.name )

d3.selectAll('input').on 'change', ->
  value = if @value == 'count' then (-> 1) else ((d) -> d.size)
  node.data(treemap.value(value).nodes)
    .transition()
    .duration(1500)
    .call position

$(document).ready ->
  $('.tooltipped').tooltip delay: 50

$('#txtKeyword').keyup (e) -> if e.keyCode == 13
  showLoader()
  window.location = '/break-down/'+$('#txtKeyword').val()