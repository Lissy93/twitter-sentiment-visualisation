
for result, index in results
  chart = c3.generate(
    bindto: '#chart-'+index
    data:
      columns: [
          ['Positive', result.pieChart.positive ]
#          ['Neutral', result.pieChart.neutral ]
          ['Negative',  result.pieChart.negative ]
      ]
      type: 'donut'
      colors: {
        Positive: '#01DF01',
        Neutral: '#848484',
        Negative: '#DF0101'
      }
    donut: title: result.searchTerm)