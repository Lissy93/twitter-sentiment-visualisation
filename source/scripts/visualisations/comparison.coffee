
# Converts the raw Sentiment data into a format suitable for the scatter chart
generateScatterData = (rawResults) ->
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
generateBarData = (rawResults) ->
  chartData = []
  chartData.push(['Tweet', 'Dictionary-Based SA', 'NLU SA', 'Human SA'])
  rawResults.forEach (so) ->
    chartData.push([
      so.tweet
      so.nlu_sentiment
      so.dictionary_sentiment
      if so.human_sentiment? then so.human_sentiment else 0
    ])
  chartData

# Converts raw sentiment data into a format suitable for the column chart
generateSummaryData = (rawResults) ->
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

# Finds range of sentiment
getSummaryRange = (chartData) ->
  chartData[1].splice 0,1
  for d, i in chartData[1] then chartData[1][i] = Math.abs(d)
  Math.max.apply(Math, chartData[1])*2

# Defines the chart data, options and calls draw method for both charts
drawChart = ->
  scatterData =
    google.visualization.arrayToDataTable generateScatterData sentimentResults
  barData =
    google.visualization.arrayToDataTable generateBarData sentimentResults
  summaryData =
    google.visualization.arrayToDataTable generateSummaryData sentimentResults

  # Define chart options for all charts
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
    chartArea:
      width: '50%'
      height: '100%'
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
        min: - getSummaryRange generateSummaryData sentimentResults
        max: getSummaryRange generateSummaryData sentimentResults
    height: 400
    colors: ['#6ec9ee', '#3D7CDB', '#0B326C']

  # Create all google charts with chart options
  chart = new  google.charts.Bar document.getElementById 'summarry_bar_ch'
  chart.draw summaryData,  google.charts.Bar.convertOptions summaryOptions

  scatterChart =
    new google.visualization.ScatterChart document.getElementById 'scatter_ch'
  scatterChart.draw scatterData, scatterOptions

  barChart = new google.visualization.BarChart document.getElementById 'bar_ch'
  barChart.draw barData, barOptions

  # Create a HTML table for the raw results
  drawTableChart = () ->
    data = generateBarData sentimentResults
    myTable = ''
    myTable += '<thead><tr>'
    myTable += '<th style="width: 30em">Tweet</th>'
    myTable += '<th>'+item+'</th>' for item in data[0].splice(1,3)
    myTable += '</tr></thead>'
    myTable += '<tbody>'
    i = 1
    while i < data.length
      myTable += '<tr>'
      myTable += '<td>'+cell+'</td>' for cell in data[i]
      myTable += '</tr>'
      i++

    myTable += '</tbody>'

  document.getElementById('table_ch').innerHTML = drawTableChart()

# Load the google visualisations packages and call the draw method
google.load 'visualization', '1.1', packages: ['table', 'corechart', 'bar']
google.setOnLoadCallback drawChart


# Update the search button when the textfield changes
btnSearch = document.getElementById('btnCalculate')
txtKeyword = document.getElementById('txtKeyword')
txtKeyword.onchange = txtKeyword.onkeyup = ->
  keyWord = encodeURIComponent(txtKeyword.value)
  btnSearch.setAttribute('href', '/sa-comparison/'+keyWord)
