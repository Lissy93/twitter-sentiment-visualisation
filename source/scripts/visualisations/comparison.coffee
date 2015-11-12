
# Converts the raw Sentiment data into a format suitable for the scatter chart
generateChartData = (rawResults) ->
  chartData = []
  chartData.push(['Sentiment', 'Dictionary-Based SA', 'NLU SA', 'Human SA'])
  chartData.push([0, null, null, 0])
  rawResults.forEach (sentimentObject) ->
    tweetLen = sentimentObject.tweet.length
    chartData.push([tweetLen, null, sentimentObject.dictionary_sentiment, null])
    chartData.push([tweetLen, sentimentObject.nlu_sentiment, null, null])
    if(sentimentObject.human_sentiment)
      chartData.push([tweetLen, null, null, sentimentObject.human_sentiment])
  chartData

# Converts raw sentiment data into a format suitable for the bar chart
generateBarChartData = (rawResults) ->
  chartData = []
  chartData.push(['Tweet', 'Dictionary-Based SA', 'NLU SA', 'Human SA'])
  rawResults.forEach (sentimentObject) ->
    chartData.push([
      sentimentObject.tweet
      sentimentObject.nlu_sentiment
      sentimentObject.dictionary_sentiment
      sentimentObject.human_sentiment
    ])
  chartData

# Defines the chart data, options and calls draw method for both charts
drawChart = ->
  scatterData =
    google.visualization.arrayToDataTable generateChartData sentimentResults
  barData =
    google.visualization.arrayToDataTable generateBarChartData sentimentResults

  scatterOptions =
    title: 'Comparison of Different Sentiment Analysis Methods'
    width: 900
    height: 500
    backgroundColor: '#fff'
    hAxis:
      title: 'String Length'
      minValue: 0
      maxValue: 100
    vAxis:
      title: 'Sentiment'
      minValue: -1
      maxValue: 1
    legend: position: 'right'
    colors: ['#6ec9ee', '#3D7CDB', '#0B326C']
    dataOpacity: 1

  barOptions =
    chart:
      title: 'Comparison of different sentiment analysis methods '
      subtitle: 'Hover over bar for more details of Tweet'
    width: 1000
    height: 1500
    backgroundColor: '#fff'
    bars: 'horizontal'
    colors: ['#6ec9ee', '#3D7CDB', '#0B326C']
    axes: x: 0:
      side: 'top'
      label: 'Sentiment'


  table = new google.visualization.Table document.getElementById 'table_ch';
  table.draw(barData, {width: '100%', height: '100%'});

  scatterChart =
    new google.visualization.ScatterChart document.getElementById 'scatter_ch'
  scatterChart.draw scatterData, scatterOptions

  barChart = new google.charts.Bar document.getElementById 'bar_ch'
  barChart.draw barData, barOptions

google.load 'visualization', '1.1', packages: ['table', 'corechart', 'bar']

google.setOnLoadCallback drawChart


# Update the search button when the textfield changes
btnSearch = document.getElementById('btnCalculate')
txtKeyword = document.getElementById('txtKeyword')
txtKeyword.onchange = txtKeyword.onkeyup = ->
  btnSearch.setAttribute('href', '/sa-comparison/'+encodeURIComponent(txtKeyword.value))
