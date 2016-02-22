


drawRadarChart = (toneResults) ->
  radarData = []
  axes = []
  for tr in toneResults then axes.push {axis: tr.name, value: tr.score }
  radarData.push {className: 'Overall Tone', axes: axes}

  chart = RadarChart.chart()
  chart.config({w: 300, h: 300})
  svg = d3.select('#radar').append('svg').attr('width', 300).attr('height', 300)
  svg.append('g').classed('focus', 1).datum(radarData).call chart



requestWatsonData = (tweetBody) ->

  # Generates the HTML for each progress bar with label, value and tooltip
  makeHtmlProgress = (label, value) ->
    percent = Math.round(value*100)
    html = ""
    html += "<label>#{label}</label>"
    html += "<div class='progress horizontal-bar tooltipped' data-position='right' data-tooltip='#{percent}%'>"
    html += "<div class='determinate' style='width: #{percent}%'>"
    html += "</div></div>"
    html

  # Called after results are returned, initiates the rendering process
  renderResults = (results) ->
    for tCat, i in results.document_tone.tone_categories
      i += 1
      $('#toneResults'+i).append(
        "<h5 class='flow-text font-size1'>#{tCat.category_name}</h5>"
      )
      for tone in tCat.tones
        $('#toneResults'+i).append(makeHtmlProgress(tone.tone_name, tone.score))
    # Show containers now they have data in, and hide the loader
    $('#toneLoader').fadeOut('fast')
    j = 1
    while j <= 3 then $('#toneResults'+j).slideDown('slow'); j++
    $('.tooltipped').tooltip({delay: 50}) # Initialise the tooltip


  # Hide empty containers to start with
  j = 1
  while j <= 3 then $('#toneResults'+j).hide(); j++

  # Make the actual request
  $.post('/api/tone', tweetBody, (results) -> renderResults results)

$(document).ready ->
  if st? and st != '' then requestWatsonData {'searchTerm': st }
  else if tweetBody?  then requestWatsonData {'text': tweetBody }


