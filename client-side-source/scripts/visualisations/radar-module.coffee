
renderChart = (toneResults) ->

  $('#radarLoader').slideUp('slow')

  scaleColors = ['rgb(15, 160, 255)', 'rgb(60, 230, 255)', 'rgb(60, 255, 181)'
    'rgb(70, 255, 99)', 'rgb(174, 255, 99)', 'rgb(217, 255, 99)'
    'rgb(251, 255, 99)', 'rgb(255, 230, 99)', 'rgb(255, 182, 99)'
    'rgb(255, 142, 99)', 'rgb(250, 125, 100)', 'rgb(255, 117, 99)'
    'rgb(255, 99, 100)', 'rgb(255, 55, 55)', 'rgb(240,240,240)'
  ].reverse()
  color = d3.scale.linear()
  .domain([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,18])
  .range(scaleColors)

  width = 600
  height = 500
  radius = Math.min(width, height) / 2 - 10
  formatNumber = d3.format(',d')
  x = d3.scale.linear().range([0,2 * Math.PI])
  y = d3.scale.sqrt().range([0, radius])
  partition = d3.layout.partition().value((d) -> d.size)
  arc = d3.svg.arc().startAngle((d) -> Math.max 0, Math.min(2 * Math.PI, x(d.x)))
    .endAngle((d) ->Math.max 0, Math.min(2 * Math.PI, x(d.x + d.dx)))
    .innerRadius((d) -> Math.max 0, y(d.y))
    .outerRadius((d) -> Math.max 0, y(d.y + d.dy))

  svg = d3.select('#tone-radar')
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', 'translate(' + width / 2 + ',' + height / 2 + ')')


  click = (d) ->
    svg.transition().duration(750).tween('scale', ->
      xd = d3.interpolate(x.domain(), [ d.x, d.x + d.dx ])
      yd = d3.interpolate(y.domain(), [ d.y, 1 ])
      yr = d3.interpolate(y.range(), [ (if d.y then 20 else 0), radius ])
      (t) ->
        x.domain xd(t)
        y.domain(yd(t)).range yr(t)
    ).selectAll('path').attrTween 'd', (d) -> -> arc d


  root = {name: 'Tones', children: []}
  for category, i in toneResults.document_tone.tone_categories
    root.children[i] = name: category.category_name, children: []
    for tone, j in category.tones
      root.children[i].children[j] = {name: tone.tone_name, size: tone.score}

  svg.selectAll('path')
    .data(partition.nodes(root))
    .enter()
    .append('path')
    .attr('d', arc)
    .attr('class', 'tt')
    .attr('data-tooltip', (d) -> d.name)
    .style('fill', (d, i) -> color i)
    .on('click', click)
    .append('title')
    .text (d) -> d.name + '\n' + formatNumber(d.value)

  d3.select(self.frameElement).style 'height', height + 'px'

  $('.tt').tooltip({delay: 50}) # Initialise the tooltip


module.exports = renderChart