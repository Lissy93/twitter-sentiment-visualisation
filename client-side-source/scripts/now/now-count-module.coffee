
# Keep count of tweets
numPositiveTweets = 0
numNegativeTweets = 0
numTotal = 0

# Declare vars for objects
svg = null
chart = null

# Template for bullet data
bulletData = [{
  title:'Sentiment'
  subtitle:'Proportion of tweets'
  ranges:[0,1,2]
  measures:[1,2]
  markers:[1]
}]


drawBulletChart = () ->
  margin = top: 5, right: 40, bottom: 20, left: 120
  width = $('#bullet-container').width() - (margin.left) - (margin.right)
  height = 50 - (margin.top) - (margin.bottom)
  chart = d3.bullet().width(width).height(height)

  svg = d3.select('#bullet-chart')
    .selectAll('svg')
    .data(bulletData)
    .enter()
    .append('svg')
    .attr('class', 'bullet')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
    .append('g')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
    .call(chart)

  title = svg.append('g')
    .style('text-anchor', 'end')
    .attr('transform', 'translate(-6,' + height / 2 + ')')
  title.append('text')
    .attr('class', 'title')
    .text (d) -> d.title
  title.append('text')
    .attr('class', 'subtitle')
    .attr('dy', '1em')
    .text (d) -> d.subtitle


addDataToBullet = () ->
  bulletData.ranges   = [numTotal * 0.33, numTotal * 0.66, numTotal]
  bulletData.measures = [numPositiveTweets, numPositiveTweets+numNegativeTweets]
  bulletData.markers  = [(numPositiveTweets + numNegativeTweets)/2]
  svg.datum(bulletData).call chart.duration(1000)

newTweetArrived = (tweet) ->
  numTotal += 1
  if tweet.sentiment > 0
    numPositiveTweets += 1
    $('#countPos').html(numPositiveTweets)
  else if tweet.sentiment < 0
    numNegativeTweets += 1
    $('#countNeg').html(numNegativeTweets)

  if (numTotal % 15) == 0
    addDataToBullet()


module.exports.startCountCharts = drawBulletChart
module.exports.newTweetArrived  = newTweetArrived