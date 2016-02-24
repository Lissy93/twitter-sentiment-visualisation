socket = io.connect();

socket.on 'tweet', (tweetObj) ->
  globeItem =
    sentiment: tweetObj.sentiment
    location:
      lat: tweetObj.location.location.lat
      lng: tweetObj.location.location.lng

  window.addSentiment(globeItem)

  $('span#numRes').text(Number($('span#numRes').text())+1) # Increment counter
