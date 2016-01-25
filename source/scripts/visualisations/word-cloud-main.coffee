
scaleColors = ["#a50026","#d73027","#f46d43","#fdae61","#fee08b","#ffffbf","#d9ef8b","#a6d96a","#66bd63","#1a9850","#006837"]


fill = d3.scale.linear()
.domain([-1,1])
.range(scaleColors)


draw = (words) ->
  d3.select('body')
    .append('svg')
    .attr('width', 300)
    .attr('height', 300)
    .append('g')
    .attr('transform', 'translate(150,150)')
    .selectAll('text')
    .data(words)
    .enter()
    .append('text')
    .style('font-size', (d) -> d.size + 'px')
    .style('font-family', 'Impact')
    .style('fill', (d, i) -> fill -0.5)
    .attr('text-anchor', 'middle')
    .attr('transform', (d) ->
      'translate(' + [
        d.x
        d.y
      ] + ')rotate(' + d.rotate + ')'
    )
    .text (d) -> d.text

d3.layout.cloud().size([300, 300]).words([
  '.NET'
  'Silverlight'
  'jQuery'
  'CSS3'
  'HTML5'
  'JavaScript'
  'SQL'
  'C#'
]
  .map((d) -> { text: d, size: 10 + Math.random() * 50 } ))
  .rotate(-> ~ ~(Math.random() * 2) * 90)
  .font('Impact').fontSize((d) -> d.size)
  .on('end', draw).start()
