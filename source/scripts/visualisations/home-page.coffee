
homePage = true # Show different hexagons for the homepage


# Socket.io
socket = io.connect('http://localhost:8080');

socket.on 'anyTweet', (tweetObj) ->
  if tweetObj.sentiment != 0
    tweet = sentiment: tweetObj.sentiment, body: tweetObj.body
    window.updateHexData(tweet)

# Submit search field when enter is pressed
$('#txtKeyword').keyup (e) ->
  if e.keyCode == 13
    showLoader()
    window.location = '/search/' + $('#txtKeyword').val()
  return

$(document).ready ->

  # Set the size of the chart to fit the window
  $('#part-1').css 'height', $(window).height()
  $('#chart').find('svg').attr
    'height': $(window).height() + 20
    'width': $(window).width()

  # Pull down the blocks on the front page
  $('.home-row').animate { 'margin-top': $(window).height() / 5 },
    duration: 600
    step: (now) -> $(this).attr 'margin-top', now

  # Scroll to positions
  $('a.scroll-down#scroll-1').click ->
    $('html, body').animate { scrollTop: $('#part-2').offset().top }, 850

  # Parallax scroll
  parallaxScroll = ->
    scrolledY = $(window).scrollTop()
    $('#part-1').css 'margin-top', scrolledY * 0.5 + 'px'
    $('#scroll-1').css 'bottom', scrolledY * 0.3 + 10 + 'px'
    $('#hex-details').css 'bottom', scrolledY * 0.3 + 10 + 'px'

  $(window).bind 'scroll', (e) -> parallaxScroll()

