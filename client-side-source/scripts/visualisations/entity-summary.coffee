


requestEntityData = (tweetBody) ->

# Generates the HTML for each progress bar with label, value and tooltip
  makeHtmlProgress = (label) ->
    html = ""
    html += "<label>#{label}</label>"
    html

  # Called after results are returned, initiates the rendering process
  renderResults = (results) ->
    i = 0
    console.log results
    for key in Object.keys results
      catName = key.charAt(0).toUpperCase()+key.split('_')[0].slice(1)
      console.log catName
      category = results[key]
      i += 1
      $('#entityResults'+i).append(
        "<h5 class='flow-text font-size1'>#{catName}</h5>"
      )
      for item in catName
        $('#entityResults'+i).append(makeHtmlProgress(item.normalized_text))
    # Show containers now they have data in, and hide the loader
    $('#entityLoader').fadeOut('fast')
    j = 1
    while j <= 6 then $('#entityResults'+j).slideDown('slow'); j++

  # Hide empty containers to start with
  j = 1
  while j <= 6 then $('#entityResults'+j).hide(); j++

  # Make the actual request
  $.post('/api/entity', {text:tweetBody}, (results) -> renderResults results)

$(document).ready ->
  requestEntityData tweetBody


