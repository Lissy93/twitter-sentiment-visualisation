$(window).load ->
  $('#loading-graphic').fadeOut 'slow'


root = exports ? this
root.showLoader = () -> $('#loading-graphic').fadeIn 'slow'
root.hideLoader = () -> $('#loading-graphic').fadeOut 'slow'

$(document).ready () ->
  $(".button-collapse").sideNav()
  if ($(window).width() <= 699)
    if window.location.pathname.indexOf('mobile') == -1
      document.location = '/mobile'

  $('.nav-wrapper ul').click( () -> root.showLoader())

  # Open external links in a new tab
  $("a[href^='http://']").attr("target","_blank");
  $("a[href^='https://']").attr("target","_blank");
