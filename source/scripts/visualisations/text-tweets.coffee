

makeDiv = (tweet) ->
  col = if tweet.sentiment > 0 then 'green' else 'darkred'
  html = "<div class='card-panel'>"
  html += "<div class='pull-right'>"
  html += "<b style='color: #{col}'>#{tweet.sentiment*100}%</b>"
  html += "</div>"
  html += "#{tweet.body}"
  if tweet.location.place_name != null
    html += "<br><i class='tiny material-icons small-grey'>location_on</i>"
    html += "<p class='small-grey inline'>#{tweet.location.place_name}</p>"
  html += "</div>"
  html

if searchTerm == ''

  socket = io.connect('http://localhost:8080');

  socket.on 'anyTweet', (tweetObj) ->
    if tweetObj.sentiment > 0
      $("#positiveContainer").prepend(makeDiv tweetObj)
      $('#positiveContainer .card-panel:last').remove()

    else if tweetObj.sentiment < 0
      $("#negativeContainer").prepend(makeDiv tweetObj)
      $('#negativeContainer .card-panel:last').remove()

