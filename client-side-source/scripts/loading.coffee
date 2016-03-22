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

  # Show toast telling the user they r stupid if on a mobile device
  compatStr = "<p><span style='color: #F78181;'>Incompatible Device. </span><br>"
  compatStr += "Use a PC or tablet to access full functionality</p>"
  if $( window ).width() < 600 then Materialize.toast(compatStr, 4000)