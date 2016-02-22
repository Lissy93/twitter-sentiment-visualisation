

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


module.exports = renderResults