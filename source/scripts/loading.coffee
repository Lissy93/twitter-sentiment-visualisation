$(window).load ->
  $('#loading-graphic').fadeOut 'slow'


root = exports ? this
root.showLoader = () -> $('#loading-graphic').fadeIn 'slow'
root.hideLoader = () -> $('#loading-graphic').fadeOut 'slow'