
sentiment = (average * 100)/2 + 50


chart = c3.generate(
  bindto: '#gaugeChart'
  data:
    columns: [ ['sentiment', sentiment] ]
    type: 'gauge'
  gauge: {}
  color:
    pattern: ["#C80000", "#EB3443","#F85353","#FF5A80","#EF7B96","#B1B1B1",
      "#8CD087","#7CE974","#62EC59","#42F735","#4AF43E"]
    threshold: values: [0,10,20,30,40, 50, 60, 70, 80, 90, 100]
  size: height: 180)

#setTimeout (-> chart.load columns: [ ['data', average*100+20] ]), 500
#setTimeout (-> chart.load columns: [ ['data', average*100-20] ]), 500
#setTimeout (-> chart.load columns: [ ['data', average*100] ]), 500
