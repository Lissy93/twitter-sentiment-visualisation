

#The color of each hexagon
color = ['#E9FF63', '#7DFF63', '#63F8FF', '#99FF63', '#CFFE63', '#FFC263',
    '#FFC763', '#FF8E63', '#FF6464', '#FF7563', '#FF6364', '#FF7F63', '#FFE963',
    '#E3FF63', '#FFD963', '#FFE263', '#BAFF63', '#6BFF63', '#64FF69', '#71FF63',
    '#63FF6C', '#63FFD8', '#64FF69', '#63FF9A', '#FDFC63', '#88FF63', '#66FF64',
    '#A6FF63', '#63FFDB', '#63D9FE', '#90FF63', '#FF9B63', '#FF7263', '#9DFF63',
    '#E5FF63', '#FF7F63', '#FF7463', '#FFAE63', '#F4FF63', '#FFEC63', '#FBFF63',
    '#FFE663', '#FFC263', '#9DFF63', '#AEFF63', '#6AFF63', '#65FF65', '#63FFC7',
    '#C5FF63', '#63FFBE', '#63FF93', '#63FFAC', '#62FF79', '#90FF63', '#6AFF63',
    '#63FFEF', '#63F7FF', '#63FFD1', '#6370FF', '#638DFF', '#63FFDF', '#C5FF63',
    '#63FF6A', '#64FF69', '#C7FE63', '#FDFC63', '#D0FE63', '#FFDC63', '#E3FF63',
    '#DCFF63', '#C9FE63', '#FBFF63', '#FFB663', '#D9FF63', '#9DFF63', '#69FF63',
    '#DCFF63', '#63FFD4', '#63FFB8', '#64FF67', '#74FF63', '#63FCFF', '#63FFF9',
    '#63FFE9', '#A6FF63', '#63FFCD', '#63CEFE', '#63FBFF', '#63FFFB', '#637CFF',
    '#6379FF', '#D2FE63', '#CFFE63', '#63FF6E', '#65FF65', '#EEFF63', '#DCFF63',
    '#9DFF63', '#AAFF63', '#B6FF63', '#D0FE63', '#AEFF63', '#CDFE63', '#64FF67',
    '#99FF63', '#66FF64', '#63FFC1', '#63FFD4', '#63FF90', '#63FFD1', '#63FFF4',
    '#63FFEC', '#63FFF9', '#71FF63', '#63FF93', '#63FFC4', '#63F7FF', '#638DFF',
    '#63E9FF', '#6375FF', '#88FF63', '#95FF63', '#63FFAF', '#63FF93', '#63FF9A',
    '#9DFF63', '#88FF63', '#EEFF63', '#BDFF63', '#71FF63', '#B6FF63', '#80FF63',
    '#62FF82', '#63FF6C', '#62FF76', '#63FF6E', '#63FFCD', '#63EFFF', '#63FFF6',
    '#63FFB5', '#63FFFC', '#63B4FF', '#63FFC1', '#63F5FF', '#63FFB5', '#63FFBB',
    '#63FFFC', '#6379FF', '#63B0FF', '#63FFBB', '#D5FE63', '#63FFB8', '#63FF6C',
    '#62FF7C', '#63FFBE', '#FFDF63', '#FFE263', '#FFE963', '#76FF63', '#67FF64',
    '#63FF90', '#65FF65', '#63FFA0', '#63FFA6', '#62FF73', '#63FFC1', '#63FFC4',
    '#63FFF9', '#63CEFE', '#63A4FF', '#6373FF', '#63C5FE', '#638DFF', '#63FF9D',
    '#6387FF', '#63FFBE', '#63FEFE', '#63FFEC', '#63FFF1', '#638DFF', '#FF6A64',
    '#FBFF63', '#FFEF63', '#63FFE9', '#62FF8C', '#BAFF63', '#FFAB63', '#FFCB63',
    '#62FF82', '#88FF63', '#63FFB2', '#63FFC1', '#63FFDF', '#63FFB5', '#63FFB5',
    '#62FF7F', '#63FFC4', '#63ECFF', '#63FFFC', '#63F3FF', '#63FFE5', '#63D2FE',
    '#63FFF6', '#63A8FF', '#63F8FF', '#63FFFB', '#63E4FF', '#636DFF', '#63FFC4',
    '#6387FF', '#FF8B63', '#EBFF63', '#C5FF63', '#BDFF63', '#62FF76', '#DCFF63',
    '#BDFF63', '#99FF63', '#62FF82', '#63FFA6', '#63C9FE', '#63FEFE', '#62FF89',
    '#63FFD8', '#63FFB8', '#63FFF1', '#63C1FE', '#63FCFF', '#63FFCA', '#63C9FE',
    '#63FFFC', '#6FFF63', '#63FFE5', '#63E9FF', '#63F7FF', '#63B0FF', '#636CFF',
    '#636CFF', '#63ACFF', '#63F1FF', '#FF8863', '#FF6864', '#FFB363', '#A2FF63',
    '#63FFD8', '#63FF96', '#99FF63', '#AEFF63', '#C7FE63', '#63FF93', '#63FFC1',
    '#63FFF9', '#63FFFB', '#67FF64', '#B2FF63', '#62FF76', '#62FF73', '#639CFF',
    '#63FFC1', '#63FFEF', '#66FF64', '#62FF76', '#63FFC4', '#63FFCA', '#63FFBE',
    '#63FFFC', '#6363FF', '#63ACFF', '#6375FF', '#63CEFE', '#FFB663', '#79FF63',
    '#BDFF63', '#63FF6C', '#66FF64', '#76FF63', '#FEF763', '#D7FE63', '#7DFF63',
    '#63FFB8', '#63F5FF', '#63F7FF', '#62FF7F', '#63FFA6', '#62FF76', '#63FFA6',
    '#63FFD1', '#63FEFE', '#63FFDF', '#63F8FF', '#63FF96', '#63FFA9', '#63FFA9',
    '#63C1FE', '#63FFC1', '#63D6FE', '#636EFF', '#6364FF', '#6370FF', '#6398FF',
    '#FFE663', '#C0FF63', '#EBFF63', '#C5FF63', '#D2FE63', '#69FF63', '#6FFF63',
    '#D4FE63', '#F4FF63', '#63FFC4', '#62FF89', '#63FFF4', '#63FFB8', '#63FFF4',
    '#63F8FF', '#62FF71', '#63FFBB', '#63FFEF', '#63FFF1', '#63FBFF', '#63C1FE',
    '#63FFDF', '#63FFD1', '#63FFE2', '#63ACFF', '#63F3FF', '#63DDFF', '#63FFF6',
    '#63D6FE', '#63CEFE', '#D4FE63', '#80FF63', '#FF8B63', '#D5FE63', '#63FFCA',
    '#90FF63', '#D7FE63', '#FBFF63', '#62FF7C', '#C9FE63', '#76FF63', '#69FF63',
    '#62FF7C', '#63FFD4', '#63FFA6', '#6BFF63', '#63FFC7', '#63E4FF', '#62FF7C',
    '#63FFF6', '#6379FF', '#63FFCD', '#63FFCA', '#63FFEF', '#63FFBE', '#63E9FF',
    '#63ECFF', '#63FFF9', '#63E0FF', '#63C5FE', '#FF6B63', '#FFD663', '#63FF6E',
    '#63FFB2', '#FFD663', '#62FF7F', '#63FFA6', '#9DFF63', '#F6FF63', '#95FF63',
    '#95FF63', '#FFD963', '#DCFF63', '#63FF90', '#63FFD1', '#63FFFC', '#63FFA3',
    '#63FFAF', '#63ECFF', '#63FFEF', '#63C5FE', '#63FDFF', '#63FF93', '#62FF76',
    '#69FF63', '#63EFFF', '#636DFF', '#6379FF', '#63E7FF', '#63E7FF', '#FF8E63',
    '#CDFE63', '#BDFF63', '#F9FF63', '#62FF7F', '#63FFE2', '#62FF86', '#67FF64',
    '#63FFA3', '#6DFF63', '#9DFF63', '#FFE963', '#FFBE63', '#6AFF63', '#62FF7F',
    '#63FFD4', '#79FF63', '#63D2FE', '#63DDFF', '#63FEFE', '#63BDFE', '#63FFDB',
    '#64FF69', '#62FF8C', '#63FFD8', '#63BDFE', '#63B8FF', '#6391FF', '#63FFDB',
    '#63FEFE', '#F8FF63', '#FFF263', '#C2FF63', '#FFDF63', '#D2FE63', '#64FF69',
    '#63FFE2', '#7DFF63', '#FDFC63', '#FF9763', '#6BFF63', '#F2FF63', '#FBFF63',
    '#AEFF63', '#80FF63', '#63D9FE', '#63FFBB', '#63FFD8', '#63FFEF', '#63C5FE',
    '#63FF90', '#62FF89', '#63D2FE', '#63FFC4', '#63FF93', '#63D2FE', '#63DDFF',
    '#63FDFF', '#6DFF63', '#62FF82', '#FF8363', '#DAFF63', '#74FF63', '#63FF6A',
    '#63FF6A', '#64FF69', '#FFDF63', '#FF7F63', '#FFEF63', '#EEFF63', '#CFFE63',
    '#6AFF63', '#95FF63', '#63FF6C', '#63FF90', '#6BFF63', '#63FF90', '#63FFCA',
    '#63E9FF', '#63FFEC', '#63FFAC', '#63FFD4', '#63FAFF', '#63FFCA', '#63ECFF',
    '#62FF8C', '#63FFE5', '#69FF63', '#FF7463', '#FF9463', '#E0FF63', '#FFCB63',
    '#A6FF63', '#63FF93', '#E0FF63', '#FEFA63', '#EBFF63', '#AAFF63', '#C2FF63',
    '#D4FE63', '#63FFAC', '#65FF65', '#62FF73', '#63FFE9', '#65FF66', '#95FF63',
    '#62FF7F', '#63FFB5', '#63D2FE', '#63FFAC', '#63FFFB', '#62FF8C', '#64FF69',
    '#99FF63', '#63FFB2', '#63FFDF', '#63FFB8', '#BAFF63', '#FFDC63', '#62FF76',
    '#BDFF63', '#C2FF63', '#95FF63', '#F6FF63', '#FFA163', '#CFFE63', '#63FFE9',
    '#84FF63', '#6BFF63', '#6DFF63', '#63FFC1', '#D0FE63', '#69FF63', '#63FFC1',
    '#62FF8C', '#63FFBB', '#63FF96', '#63FAFF', '#63FFEC', '#63FEFE', '#62FF76',
    '#63FF9A', '#FFC563', '#6FFF63', '#63FFAF', '#63F5FF', '#63F1FF', '#63FF6A',
    '#62FF7C', '#63F8FF', '#9DFF63', '#99FF63', '#AEFF63', '#FF8363', '#FFC963',
    '#62FF79', '#63FF90', '#63FF6A', '#63FCFF', '#63E9FF', '#63FFA0', '#64FF67',
    '#FFD463', '#A6FF63', '#CBFE63', '#63FF90', '#63FFC4', '#63C9FE', '#63FFE5',
    '#63FFDB', '#62FF89', '#63FFD8', '#79FF63', '#63FF9A', '#63FAFF', '#63E9FF',
    '#63FF6E', '#63F7FF', '#63E4FF', '#63F5FF', '#64FF67', '#C9FE63', '#FFBA63',
    '#D9FF63', '#63FFD1', '#63FFF6', '#63FF93', '#C0FF63', '#F6FF63', '#62FF82',
    '#AEFF63', '#CBFE63', '#FF8363', '#63FF6A', '#63FFCD', '#63F7FF', '#63FFF9',
    '#63FFC4', '#63FFC4', '#95FF63', '#63FFCD', '#A2FF63', '#EBFF63', '#63FFC1',
    '#63FFA0', '#63E4FF', '#63FFFB', '#63F3FF', '#63CEFE', '#63FBFF'];


mover = (d) ->
  el = d3.select(this).transition().duration(10).style('fill-opacity', 0.3)

mout = (d) ->
  el = d3.select(this).transition().duration(1000).style('fill-opacity', 1)

#svg sizes and margins
margin = top: 30, right: 20, bottom: 20, left: 50

#The next lines should be run, but this seems to go wrong on the first load in bl.ocks.org
width = $(window).width() - margin.left - margin.right - 40;
height = $(window).height() - margin.top - margin.bottom - 80;
#So I set it fixed to
#width = 850
#height = 350
#The number of columns and rows of the heatmap
MapColumns = 30
MapRows = 20
#The maximum radius the hexagons can have to still fit the screen
hexRadius = d3.min([
  width / ((MapColumns + 0.5) * Math.sqrt(3))
  height / ((MapRows + 1 / 3) * 1.5)
])
#Set the new height and width of the SVG based on the max possible
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
  .style('fill', (d, i) -> color[i])
  .on('mouseover', mover)
  .on 'mouseout', mout
