
wordData = [
  {text: 'Wheatley', sentiment: -1, freq: 28}
  {text: 'library', sentiment: -0.8, freq: 22}
  {text: 'tuna', sentiment: -0.6, freq: 12}
  {text: 'brown', sentiment: -0.4, freq: 20}
  {text: 'rain', sentiment: -0.2, freq: 15}
  {text: 'neutral', sentiment: 0, freq: 8}
  {text: 'coke', sentiment: 0.2, freq: 10}
  {text: 'corn flakes', sentiment: 0.4, freq: 25}
  {text: 'JavaScript', sentiment: 0.6, freq: 10}
  {text: 'Lucozade', sentiment: 0.8, freq: 20}
  {text: 'Nothing!!', sentiment: 1, freq: 50}
  {text: 'Lorem', sentiment: -0.7, freq: 18}
  {text: 'Ipsum', sentiment: -0.2, freq: 32}
  {text: 'Dolor', sentiment: 0.6, freq: 38}
  {text: 'Siet', sentiment: 0.5, freq: 28}
  {text: 'Ammet', sentiment: 1, freq: 15}
  {text: 'Wheatley', sentiment: -1, freq: 28}
  {text: 'library', sentiment: -0.8, freq: 22}
  {text: 'tuna', sentiment: -0.6, freq: 12}
  {text: 'brown', sentiment: -0.4, freq: 20}
  {text: 'rain', sentiment: -0.2, freq: 15}
  {text: 'neutral', sentiment: 0, freq: 8}
  {text: 'coke', sentiment: 0.2, freq: 10}
  {text: 'corn flakes', sentiment: 0.4, freq: 25}
  {text: 'JavaScript', sentiment: 0.6, freq: 10}
  {text: 'Lucozade', sentiment: 0.8, freq: 20}
  {text: 'Nothing!!', sentiment: 1, freq: 50}
  {text: 'Lorem', sentiment: -0.7, freq: 18}
  {text: 'Ipsum', sentiment: -0.2, freq: 32}
  {text: 'Dolor', sentiment: 0.6, freq: 38}
  {text: 'Siet', sentiment: 0.5, freq: 28}
  {text: 'Ammet', sentiment: 1, freq: 15}
  {text: 'Wheatley', sentiment: -1, freq: 28}
  {text: 'library', sentiment: -0.8, freq: 22}
  {text: 'tuna', sentiment: -0.6, freq: 12}
  {text: 'brown', sentiment: -0.4, freq: 20}
  {text: 'rain', sentiment: -0.2, freq: 15}
  {text: 'neutral', sentiment: 0, freq: 8}
  {text: 'coke', sentiment: 0.2, freq: 10}
  {text: 'corn flakes', sentiment: 0.4, freq: 25}
  {text: 'JavaScript', sentiment: 0.6, freq: 10}
  {text: 'Lucozade', sentiment: 0.8, freq: 20}
  {text: 'Nothing!!', sentiment: 1, freq: 50}
  {text: 'Lorem', sentiment: -0.7, freq: 18}
  {text: 'Ipsum', sentiment: -0.2, freq: 32}
  {text: 'Dolor', sentiment: 0.6, freq: 38}
  {text: 'Siet', sentiment: 0.5, freq: 28}
  {text: 'Ammet', sentiment: 1, freq: 15}
  {text: 'Wheatley', sentiment: -1, freq: 28}
  {text: 'library', sentiment: -0.8, freq: 22}
  {text: 'tuna', sentiment: -0.6, freq: 12}
  {text: 'brown', sentiment: -0.4, freq: 20}
  {text: 'rain', sentiment: -0.2, freq: 15}
  {text: 'neutral', sentiment: 0, freq: 8}
  {text: 'coke', sentiment: 0.2, freq: 10}
  {text: 'corn flakes', sentiment: 0.4, freq: 25}
  {text: 'JavaScript', sentiment: 0.6, freq: 10}
  {text: 'Lucozade', sentiment: 0.8, freq: 20}
  {text: 'Nothing!!', sentiment: 1, freq: 50}
  {text: 'Lorem', sentiment: -0.7, freq: 18}
  {text: 'Ipsum', sentiment: -0.2, freq: 32}
  {text: 'Dolor', sentiment: 0.6, freq: 38}
  {text: 'Siet', sentiment: 0.5, freq: 28}
  {text: 'Ammet', sentiment: 1, freq: 15}

]

WIDTH = 500  # Width constant for canvas and chart
HEIGHT = 500 # Height constant for canvas and chart

getSentimentForWord = (word) ->
  for each in wordData then if each.text == word then return each.sentiment
  0 # if for some reason we can't find the word, then just return neutral.

scaleColors = ["#a50026","#d73027","#f46d43","#fdae61","#fee08b","#ffffbf",
               "#d9ef8b","#a6d96a","#66bd63","#1a9850","#006837"]

fillScale = d3.scale.linear()
.domain([-1,-0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])
.range(scaleColors)

sizeScale = d3.scale.linear()
.domain([0,80])
.range([10,80])



draw = (words) ->
  d3.select('svg#cloud')
    .attr('width', WIDTH+200)
    .attr('height', HEIGHT+100)
    .style('padding', '50px')
    .append('g')
    .attr('transform', 'translate(150,150)')
    .selectAll('text')
    .data(words)
    .enter()
    .append('text')
    .style('font-size', (d) -> d.size + 'px')
    .style('font-family', 'Impact')
    .style('fill', (d, i) -> fillScale getSentimentForWord d.text)
    .attr('text-anchor', 'middle')
    .attr('transform', (d) ->
      'translate(' + [d.x, d.y,] + ')rotate(' + d.rotate + ')')
    .text (d) -> d.text

d3.layout.cloud().size([WIDTH, HEIGHT])
  .words(wordData)
  .rotate(-> ~ ~(Math.random() * 2) * 90)
  .font('Impact').fontSize((d) -> sizeScale d.freq )
  .on('end', draw).start()