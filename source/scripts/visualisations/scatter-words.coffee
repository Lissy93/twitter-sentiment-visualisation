# set the stage
margin = {t: 30, r: 20, b: 20, l: 40}
w = 600 - (margin.l) - (margin.r)
h = 500 - (margin.t) - (margin.b)
x = d3.scale.linear().range([0, w])
y = d3.scale.linear().range([h - 60, 0])

scaleColors = ["#a50026","#d73027","#f46d43","#fdae61","#fee08b","#B4B4B4",
               "#d9ef8b","#a6d96a","#66bd63","#1a9850","#006837"]

color = d3.scale.linear()
  .domain([-1,-0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])
  .range(scaleColors)

svg = d3.select('#scatter-words')
  .append('svg')
  .attr('width', w + margin.l + margin.r)
  .attr('height', h + margin.t + margin.b)

# set axes, as well as details on their ticks
xAxis = d3.svg.axis().scale(x)
  .ticks(20).tickSubdivide(true).tickSize(6, 3, 0).orient('bottom')
yAxis = d3.svg.axis().scale(y)
  .ticks(20).tickSubdivide(true).tickSize(6, 3, 0).orient('left')

# group that will contain all of the plots
groups = svg.append('g')
  .attr('transform', 'translate(' + margin.l + ',' + margin.t + ')')

# array of the sentiments, used for the legend
sentiments = ['Positive', 'Neutral', 'Negative' ]

data = [
  {text: 'Hello', freq: 30, sentiment: 0.2 }
]

x0 = Math.max(-d3.min(data, (d) -> d.freq
), d3.max(data, (d) -> d.freq )
)
x.domain [0, 100]
y.domain [-1, 1]

# style the circles, set their locations based on data
circles = groups.selectAll('circle')
  .data(data)
  .enter()
  .append('circle')
  .attr('class', 'circles')
  .attr(
    cx: (d) -> x +d.freq
    cy: (d) -> y +d.sentiment
    r: 8
    id: (d) -> d.text
  )
  .style('fill', (d) -> color d.sentiment )


# what to do when we mouse over a bubble
mouseOn = ->
  circle = d3.select(this)
  # transition to increase size/opacity of bubble
  circle.transition()
    .duration(800)
    .style('opacity', 1)
    .attr('r', 16).ease 'elastic'

  # append lines to bubbles that will be used to show the precise data points.
  # translate their location based on margins
  svg.append('g')
    .attr('class', 'guide')
    .append('line')
    .attr('x1', circle.attr('cx'))
    .attr('x2', circle.attr('cx'))
    .attr('y1', +circle.attr('cy') + 26)
    .attr('y2', h - (margin.t) - (margin.b))
    .attr('transform', 'translate(40,20)')
    .style('stroke', circle.style('fill'))
    .transition()
    .delay(200)
    .duration(400)
    .styleTween 'opacity', -> d3.interpolate 0, .5

  svg.append('g')
    .attr('class', 'guide')
    .append('line')
    .attr('x1', +circle.attr('cx') - 16)
    .attr('x2', 0)
    .attr('y1', circle.attr('cy'))
    .attr('y2', circle.attr('cy'))
    .attr('transform', 'translate(40,30)')
    .style('stroke', circle.style('fill'))
    .transition().delay(200).duration(400)
    .styleTween 'opacity', -> d3.interpolate 0, .5

  # function to move mouseover item to front of SVG stage, in case
  # another bubble overlaps it
  d3.selection::moveToFront = ->
    @each ->
      @parentNode.appendChild this


  circle.moveToFront()

# what happens when we leave a bubble?
mouseOff = ->
  circle = d3.select(this)

  # go back to original size and opacity
  circle.transition()
    .duration(800)
    .style('opacity', .5)
    .attr('r', 8)
    .ease 'elastic'

  # fade out guide lines, then remove them
  d3.selectAll('.guide').transition().duration(100).styleTween('opacity', ->
    d3.interpolate .5, 0
  ).remove()


# run the mouseon/out functions
circles.on 'mouseover', mouseOn
circles.on 'mouseout', mouseOff


# tooltips (using jQuery plugin tipsy)
circles.append('title')
  .text (d) -> d.text

$('.circles').tipsy gravity: 's'


circles
  .attr('class', 'tooltipped')
  .attr('data-position', 'bottom')
  .attr('data-delay', '50')
  .attr('data-tooltip', 'HELLO')


# the legend color guide
legend = svg.selectAll('rect')
  .data(sentiments)
  .enter()
  .append('rect')
  .attr(
    x: (d, i) -> 40 + i * 80
    y: h
    width: 25
    height: 12)
  .style('fill', (d) ->
    if d == 'Positive' then return color 1
    if d == 'Negative' then return color -1
    else return color 0
  )


# legend labels
svg.selectAll('text').data(sentiments).enter().append('text').attr(
  x: (d, i) -> 40 + i * 80
  y: h + 24).text (d) -> d


# draw axes and axis labels
svg.append('g')
  .attr('class', 'x axis')
  .attr('transform', "translate(#{margin.l}, #{(h - 60 + margin.t)})")
  .call xAxis

svg.append('g')
  .attr('class', 'y axis')
  .attr('transform', "translate(#{margin.l},#{margin.t})")
  .call yAxis

svg.append('text')
  .attr('class', 'x label')
  .attr('text-anchor', 'end')
  .attr('x', w + 50)
  .attr('y', h - (margin.t) - 5)
  .text 'Frequency'

svg.append('text')
  .attr('class', 'y label')
  .attr('text-anchor', 'end')
  .attr('x', -20)
  .attr('y', 45)
  .attr('dy', '.75em')
  .attr('transform', 'rotate(-90)')
  .text 'Sentiment'


$(document).ready ->
  $('.tooltipped').tooltip delay: 50