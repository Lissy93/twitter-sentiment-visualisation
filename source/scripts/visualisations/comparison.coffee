
generateChartData = (rawResults) ->
  chartData = []
  chartData.push(['Sentiment', 'Dictionary-Based SA', 'NLU SA', 'Human SA'])
  chartData.push([0, null, null, 0])

  rawResults.forEach (sentimentObject, index) ->
    tweetLen = sentimentObject['tweet'].length
    chartData.push([tweetLen, null, sentimentObject['dictionary_sentiment'], null])
    chartData.push([tweetLen, sentimentObject['nlu_sentiment'], null, null])
    if(sentimentObject['human_sentiment'])
      chartData.push([tweetLen, null, null, sentimentObject['human_sentiment']])
  chartData


drawChart = ->

  console.log(generateChartData(sentimentResults))

  data = google.visualization.arrayToDataTable(generateChartData(sentimentResults))

  options =
    title: 'Comparison of different sentiment analysis methods'
    hAxis:
      title: 'String Length'
      minValue: 0
      maxValue: 100
    vAxis:
      title: 'Sentiment'
      minValue: -1
      maxValue: 1
    legend: 'none'

    width: 900
    height: 500
    title: 'Comparison of Different Sentiment Analysis Methods',
    backgroundColor: '#efefef'
    legend: position: 'right'
    colors: ['#6ec9ee', '#3D7CDB', '#0B326C']

  chart = new (google.visualization.ScatterChart)(document.getElementById('sentiment_diff'))
  chart.draw data, options

google.load 'visualization', '1', packages: [ 'corechart' ]
google.setOnLoadCallback drawChart


