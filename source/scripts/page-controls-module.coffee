
vis = false

if !mainPage then mainPage = 'globe'

$(document).ready ->
  goToUrl = (url) -> window.location = url # Navigate to a URL
  keywordSel = 'input#txtKeyword' # Selector for the keyword search box

  showDetails = () ->
    $('#theContent').slideDown()
    $('#btnHide').text 'Hide'
    true

  hideDetails = () ->
    $('#theContent').slideUp()
    $('#btnHide').text 'Show Details'
    false

  # Submit search term, when the user presses enter
  $(keywordSel).bind 'enter', () -> goToUrl('/'+mainPage+'/'+$(keywordSel).val())
  $(keywordSel).keyup (e) -> if e.keyCode == 13 then $(this).trigger 'enter'
  $('#btnSearch').click () -> goToUrl('/'+mainPage+'/'+$(keywordSel).val())

  $('#btnHide').click () ->
    if vis == true then vis = hideDetails() else vis = showDetails()

module.exports.setMainPage = (val) -> mainPage = val