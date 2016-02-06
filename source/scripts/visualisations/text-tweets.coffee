
makeClickWords = (clickWords, body) ->
  clWord = (word) -> (''+word).toLowerCase().replace /\W/g, ''
  htmlTweet = ''
  aStyle = 'style="color: black; font-weight: bold;" ' # style for hyperlinks
  for word in body.split " "
    if clWord(word) in clickWords
      htmlTweet += "<a #{aStyle} href='/text-tweets/#{clWord word}'>#{word}</a> "
    else htmlTweet += "#{word} "
  htmlTweet

makeDiv = (tweet) ->
  col = if tweet.sentiment > 0 then 'green' else 'darkred'
  html = "<div class='card-panel'>"
  html += "<div class='pull-right'>"
  html += "<b style='color: #{col}'>#{tweet.sentiment*100}%</b>"
  html += "</div>"
  html += "#{makeClickWords tweet.keywords, tweet.body}"
  if tweet.location.place_name != null
    html += "<br><i class='tiny material-icons small-grey'>location_on</i>"
    html += "<p class='small-grey inline'>#{tweet.location.place_name}</p>"
  html += "</div>"
  html

socket = io.connect('http://localhost:8080');

socket.on 'anyTweet', (tweetObj) ->

  searchTerm = $('#txtKeyword').val()

  if (searchTerm == '' or
    (tweetObj.body and tweetObj.body.indexOf(searchTerm) > -1)) and
    $('#showLive').is(':checked')

      if tweetObj.sentiment > 0
        $("#positiveContainer").prepend(makeDiv tweetObj)
        if $('#positiveContainer .card-panel').length > 100
          $('#positiveContainer .card-panel:last').remove()

      else if tweetObj.sentiment < 0
        $("#negativeContainer").prepend(makeDiv tweetObj)
        if $('#negativeContainer .card-panel').length > 100
          $('#negativeContainer .card-panel:last').remove()

