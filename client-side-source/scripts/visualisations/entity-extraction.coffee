
units = 'Widgets'
margin = top: 10, right: 10, bottom: 10, left: 10
width = 920 - (margin.left) - (margin.right)
height = 540 - (margin.top) - (margin.bottom)
formatNumber = d3.format(',.0f')

format = (d) -> formatNumber(d) + ' ' + units

color = d3.scale.category20()

# append the svg canvas to the page
svg = d3.select('#chart')
  .append('svg')
  .attr('width', width + margin.left + margin.right)
  .attr('height', height + margin.top + margin.bottom)
  .append('g')
  .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

# Set the sankey diagram properties
sankey = d3.sankey().nodeWidth(36).nodePadding(10).size([width, height])
path = sankey.link()

# load the data
graph = sankeyData
nodeMap = {}

# the function for moving the nodes
dragmove = (d) ->
  d3.select(this)
    .attr 'transform', 'translate(' + (
        d.x = Math.max(0, Math.min(width - (d.dx), d3.event.x))
        ) + ',' + (
        d.y = Math.max(0, Math.min(height - (d.dy), d3.event.y))) + ')'
  sankey.relayout()
  link.attr 'd', path

graph.nodes.forEach (x) -> nodeMap[x.name] = x

graph.links = graph.links.map((x) ->
  {
    source: nodeMap[x.source]
    target: nodeMap[x.target]
    value: x.value
  }
)

sankey.nodes(graph.nodes).links(graph.links).layout 32

# add in the links
link = svg.append('g')
  .selectAll('.sankey-link')
  .data(graph.links)
  .enter()
  .append('path')
  .attr('class', 'sankey-link')
  .attr('d', path)
  .style('stroke-width', (d) -> Math.max 1, d.dy)
  .sort((a, b) -> b.dy - (a.dy) )

# add the link titles
link.append('title').text (d) ->
  d.source.name + ' → ' + d.target.name + '\n' + format(d.value)

# add in the nodes
node = svg.append('g')
  .selectAll('.sankey-node')
  .data(graph.nodes)
  .enter()
  .append('g')
  .attr('class', 'sankey-node')
  .attr('transform', (d) ->'translate(' + d.x + ',' + d.y + ')')
  .call(d3.behavior.drag().origin((d) -> d)
  .on('dragstart', -> @parentNode.appendChild this)
  .on('drag', dragmove))

# add the rectangles for the nodes
node.append('rect').attr('height', (d) -> d.dy)
  .attr('width', sankey.nodeWidth())
  .style('fill', (d) -> d.color = color(d.name.replace(RegExp(' .*'), '')))
  .style('stroke', (d) -> d3.rgb(d.color).darker 2)
  .append('title').text (d) -> d.name + '\n' + format(d.value)

# add in the title for the nodes
node.append('text')
  .attr('x', -6)
  .attr('y', (d) -> d.dy / 2)
  .attr('dy', '.35em')
  .attr('text-anchor', 'end')
  .attr('transform', null).text((d) -> d.name)
  .filter((d) -> d.x < width / 2)
  .attr('x', 6 + sankey.nodeWidth())
  .attr 'text-anchor', 'start'


# Submit search term when enter is pressed
$('#txtKeyword').keyup (e) -> if e.keyCode == 13
  showLoader()
  window.location = '/entity-extraction/'+$('#txtKeyword').val()