window.incompatibleWithMobile = true

drawBubbleChart = (results) ->
  diameter = 450
  format = d3.format(',d')

  scaleColors = ["#C80000", "#EB3443","#B1B1B1","#42F735","#4AF43E"]
  color = d3.scale.linear()
  .domain([-0.8, -0.2, 0, 0.2, 0.8])
  .range(scaleColors)

  bubble = d3.layout.pack().sort(null).size([diameter, diameter]).padding(1.5)
  svg = d3.select('#bubble-trends')
    .append('svg')
    .attr('width', diameter)
    .attr('height', diameter)
    .attr('class', 'bubble')

  classes = (root) ->
    classes = []
    recurse = (name, node) ->
      if node.children
        node.children.forEach (child) ->
          recurse node.name, child
      else
        classes.push
          packageName: name
          className: node.name
          value: node.size
          col: node.col
    recurse null, root
    { children: classes }

  root = {name: 'trending', children:[
    {name: 'positive', children: []}
    {name: 'negative', children: []}
  ]}

  for trend in results
    if trend.sentiment > 0
      root.children[0].children.push {
        name: trend.topic, size: trend.volume, col: trend.sentiment }
    else if trend.sentiment < 0
      root.children[1].children.push {
        name: trend.topic, size: trend.volume, col: trend.sentiment }

  node = svg.selectAll('.node')
    .data(bubble.nodes(classes(root))
    .filter((d) -> !d.children))
    .enter()
    .append('g')
    .attr('class', 'node')
    .attr('transform', (d) -> 'translate(' + d.x + ',' + d.y + ')' )

  node.append('title').text (d) -> d.className + ': ' + format(d.value)

  node.append('circle')
    .attr('r', (d) -> d.r)
    .style 'fill', (d) -> color d.col

  node.append('text')
    .attr('dy', '.3em')
    .style('text-anchor', 'middle')
    .text (d) -> d.className.substring 0, d.r / 3

  d3.select(self.frameElement).style 'height', diameter + 'px'





makeHtmlTrend = (trend) ->
  html = ""
  col =
    if trend.sentiment > 0 then 'green'
    else if trend.sentiment < 0 then 'darkred'
    else 'gray'
  html += "<a href='/search/#{trend.topic.replace(/[\W_]+/g, '')}'>"
  html += "<p class='flow-text center' style='color: #{col}; font-weight: 600'>"
  html += "#{trend.topic}"
  html += "</p></a>"
  html


renderResults = (results) ->
  # If we have an error...
  if !results.trends? or results.trends.length < 1
    alert 'That location couldn\'t be recognised'
    window.location.href = '/trending'
    return

  if $.isEmptyObject(results.trends)
    $('#bubble-trends').append(
      "<h3>No results found for #{results.location}<br>Try another location</h3>")
    $('#trending-text-loader').fadeOut('slow')
    return


  # If everything is all cool then show text trends
  $('#trending-text').hide()
  for t in results.trends then $('#trending-text').append(makeHtmlTrend(t))
  $('#trending-text-loader').fadeOut('fast')
  $(' #trending-text').slideDown('slow');
  $('#titleLocation').html(results.location)

  drawBubbleChart(results.trends)

# Make actual data request
$(document).ready ->
  urlPage = window.location.href.split('/').pop().toLowerCase()
  urlEnd = if urlPage != 'trending' then  urlPage else ''
  $.post('/api/trending/'+urlEnd, {}, (results) -> renderResults results)


# Execute search query when enter is pressed or button is clicked
$('#txtLocation').bind 'enter', () ->
  window.location.href = '/trending/'+$('#txtLocation').val()
$('#txtLocation').keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'
$('#btnSearch').click () ->
  window.location.href = '/trending/'+$('#txtLocation').val()