
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
      if (sentimentObject.human_sentiment!= null) then sentimentObject.human_sentiment else 0
    ])

  console.log chartData
  chartData

generateSummaryChartData = (rawResults) ->
  chartData = []
  chartData.push ['', 'Dictionary', 'NLU', 'Human']
  dictionaryTotal = 0
  nluTotal = 0
  humanTotal = 0
  rawResults.forEach (sentimentObject) ->
    dictionaryTotal += sentimentObject.dictionary_sentiment
    nluTotal += sentimentObject.nlu_sentiment
    humanTotal += sentimentObject.human_sentiment
  chartData.push([
    'Sentiment Analysis Results'
    dictionaryTotal/rawResults.length
    nluTotal/rawResults.length
    humanTotal/rawResults.length
  ])
  chartData




# Defines the chart data, options and calls draw method for both charts
drawChart = ->
  scatterData =
    google.visualization.arrayToDataTable generateChartData sentimentResults
  barData =
    google.visualization.arrayToDataTable generateBarChartData sentimentResults
  summaryData =
    google.visualization.arrayToDataTable generateSummaryChartData sentimentResults


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

  summaryOptions =
    chart:
      title: 'Summary of Sentiment Analysis Results'
      subtitle: 'Comparing Dictionary and NLU based results'
    bars: 'vertical'
    vAxis:
      format: 'decimal'
      viewWindowMode: 'explicit'
      viewWindow:
        min: -1
        max: 1
    height: 400
    colors: ['#6ec9ee', '#3D7CDB', '#0B326C']


  chart = new  google.charts.Bar document.getElementById 'summarry_bar_ch'
  chart.draw summaryData,  google.charts.Bar.convertOptions summaryOptions


  table = new google.visualization.Table document.getElementById 'table_ch'
  table.draw barData, {width: '100%', height: '100%'}

  scatterChart =
    new google.visualization.ScatterChart document.getElementById 'scatter_ch'
  scatterChart.draw scatterData, scatterOptions

  barChart = new google.visualization.BarChart document.getElementById 'bar_ch'
  barChart.draw barData, barOptions

google.load 'visualization', '1.1', packages: ['table', 'corechart', 'bar']

google.setOnLoadCallback drawChart


# Update the search button when the textfield changes
btnSearch = document.getElementById('btnCalculate')
txtKeyword = document.getElementById('txtKeyword')
txtKeyword.onchange = txtKeyword.onkeyup = ->
  btnSearch.setAttribute('href', '/sa-comparison/'+encodeURIComponent(txtKeyword.value))
