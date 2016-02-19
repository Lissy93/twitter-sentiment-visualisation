
requestEntityData = (tweetBody) ->

# Generates the HTML for each progress bar with label, value and tooltip
  makeHtmlProgress = (label, img, num) ->
    html = ""
    html += "<a href='/search/#{label}'>"
    html += "<div class='chip sml-margin tooltipped' data-tooltip='#{num} occurrences'>"
    if img? then if img != '' then html += "<img src='#{img}' />"
    html += "#{label}"
    html += "</div>"
    html += "</a>"
    html

  # Called after results are returned, initiates the rendering process
  renderResults = (results) ->
    i = 0
    for category in results
      i += 1
      $('#entityResults'+i).append(
        "<h5 class='flow-text'>#{category.name}</h5>"
      )
      for item in category.items
        img = item.additional_information.image
        $('#entityResults'+i).append(makeHtmlProgress(item.normalized_text, img, item.matches.length))
    # Show containers now they have data in, and hide the loader
    $('#entityLoader').fadeOut('fast')
    j = 1
    while j <= 8 then $('#entityResults'+j).slideDown('slow'); j++
    $('img').error -> $(this).hide() # Hide 404 not found images
    $('.tooltipped').tooltip({delay: 50}) # Initialise the tooltip


  # Hide empty containers to start with
  j = 1
  while j <= 8 then $('#entityResults'+j).hide(); j++

  # Make the actual request
  $.post('/api/entity', {text:tweetBody}, (results) -> renderResults results)

$(document).ready ->
  requestEntityData tweetBody


