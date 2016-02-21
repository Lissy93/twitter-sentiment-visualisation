
makeHtmlTrend = (trend) ->
  html = ""
  col =
    if trend.sentiment > 0 then 'green'
    else if trend.sentiment < 0 then 'darkred'
    else 'gray'
  html += "<a href='/search/#{trend.topic.replace(/[\W_]+/g, '')}'>"
  html += "<p class='flow-text center' style='color: #{col}; font-weight: 600'>"
  html += "#{trend.topic}"
  html += "</p></a>"
  html


renderResults = (results) ->
  console.log results

  $('#trending-text').hide()

  for t in results then $('#trending-text').append(makeHtmlTrend(t))

  $('#trending-text-loader').fadeOut('fast')

  $(' #trending-text').slideDown('slow');

$(document).ready ->
  $.post('/api/trending', {'woid': 1 }, (results) -> renderResults results)