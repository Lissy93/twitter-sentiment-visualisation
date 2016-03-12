
# Generate Initial Bar Chart
chart = c3.generate(
  bindto: '#mini-bar-charts'
  data:
    columns: [ ['Positive', 50], ['Negative', 80] ]
    type: 'bar'
    colors:
      Positive: '#82FA58'
      Negative: '#F79F81'
  bar: width: ratio: 0.5
  axis:
    y:
      label: text: 'Average Sentiment (%)', position: 'outer-center'
      tick:  format: (d) -> return d + '%';
  )

# for testing
setTimeout (->
  chart.load columns: [['Negative', 45]]
), 7000
