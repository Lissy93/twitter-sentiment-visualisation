
# Initialise Count Variables
numPositiveOfTweets = 0
numNegativeOfTweets = 0
totalPositiveScore = 0
totalNegativeScore = 0
totalNumTweets = 0

colChart = null

# Generate Initial Bar Chart
generateBars = () ->
  colChart = c3.generate(
    bindto: '#mini-bar-charts'
    data:
      columns: [ ['Positive', 0], ['Negative', 0] ]
      type: 'bar'
      colors:
        Positive: '#82FA58'
        Negative: '#F79F81'
    bar: width: ratio: 0.5
    axis:
      y:
        label: text: 'Weighted Proportions', position: 'outer-center'
        tick:  format: -> return '';
  )




addToStats = (tweet) ->
# Update attributes and make calculations
  s = tweet.sentiment # Get the sentiment
  totalNumTweets += 1
  if s > 0 # Positive Tweet!
    numPositiveOfTweets +=1
    totalPositiveScore += s
  else if s < 0 # Negative Tweet!
    numNegativeOfTweets +=1
    totalNegativeScore += Math.abs s

  # Update data visualizations
  if s > 0 # Positive
    colChart.load columns: [['Positive', totalPositiveScore]]
  else if s < 0 # Negative
    colChart.load columns: [['Negative', totalNegativeScore]]


module.exports.addToStats   = addToStats
module.exports.generateBars = generateBars
