
homePage = true # Show different hexagons for the homepage

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

  # Homepage fancy tile fading magic
  $(window).bind 'scroll', (e) -> parallaxScroll()
  fade = (pageLoad) ->
    windowTop = $(window).scrollTop()
    windowBottom = windowTop + $(window).innerHeight()
    min = 0.6
    max = 1
    threshold = 0.3
    $('.home-tile, .mobile-home-card').each ->
      objectHeight = $(this).outerHeight()
      objectTop = $(this).offset().top
      objectBottom = $(this).offset().top + objectHeight
      if objectTop < windowTop
        if objectBottom > windowTop
          $(this).fadeTo 0, min + (max - min) * (objectBottom - windowTop) / objectHeight
        else if $(this).css('opacity') >= min + threshold or pageLoad
          $(this).fadeTo 0, min
      else if objectBottom > windowBottom
        if objectTop < windowBottom
          $(this).fadeTo 0, min + (max - min) * (windowBottom - objectTop) / objectHeight
        else if $(this).css('opacity') >= min + threshold or pageLoad
          $(this).fadeTo 0, min
      else if $(this).css('opacity') <= max - threshold or pageLoad
        $(this).fadeTo 0, max
  fade true

  # Sharing stuff
  $("#share").jsSocials({
    shares: ["email", "twitter", "facebook", "googleplus", "linkedin", "pinterest", "stumbleupon", "whatsapp"]
  });

  $(window).scroll ->
    threshold = 5
    op = ($(document).height() - $(window).height() - $(window).scrollTop()) / threshold
    if op <= 0
      window.setTimeout( (()-> $('#scroll-3').slideDown(100)), 2000)

    fade false
    return

  $('#scroll-3').click(()->
    $(this).fadeOut('fast', (()-> $(this).remove() )) # Get rid of more info button
    $('#more-info-section').slideDown(200, ()-> $('html, body').animate { scrollTop: $('#more-info-section').offset().top }, 850)
  )

