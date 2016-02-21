
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

  if !results.trends?
    alert 'That location couldn\'t be recognised'
    window.location.href = '/trending'
    return


  $('#trending-text').hide()

  for t in results.trends then $('#trending-text').append(makeHtmlTrend(t))

  $('#trending-text-loader').fadeOut('fast')

  $(' #trending-text').slideDown('slow');

  $('#titleLocation').html(results.location)

$(document).ready ->
  urlPage = window.location.href.split('/').pop().toLowerCase()
  if urlPage != 'trending'
    $.post('/api/trending/'+urlPage, {}, (results) -> renderResults results)
  else
    $.post('/api/trending/', {}, (results) -> renderResults results)




$('#txtLocation').bind 'enter', () ->
  window.location.href = '/trending/'+$('#txtLocation').val()
$('#txtLocation').keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'
$('#btnSearch').click () ->
  window.location.href = '/trending/'+$('#txtLocation').val()