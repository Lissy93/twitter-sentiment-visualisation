
initTopTweets = () ->


makeClickWords = (clickWords, body) ->
  clWord = (word) -> (''+word).toLowerCase().replace /\W/g, ''
  htmlTweet = ''
  aStyle = 'style="color: black; font-weight: bold;" ' # style for hyperlinks
  for word in body.split " "
    if clWord(word) in clickWords
      htmlTweet += "<a #{aStyle} href='/search/#{clWord word}'>#{word}</a> "
    else htmlTweet += "#{word} "
  htmlTweet

addTopTweet = (tweet) ->

  limit = 8

  tweetHtml = ""
  tweetHtml += "<div class='top-tweet' style='display: none'>"
  tweetHtml += "#{makeClickWords(tweet.keywords, tweet.body)}"
  tweetHtml += "<span class='small-grey'>"
  tweetHtml += "<i class='tiny material-icons small-grey'>location_on</i>"
  tweetHtml += "#{tweet.location.place_name}</span>"
  tweetHtml += "</div>"

  if tweet.sentiment > 0
    $('#topPosLoader').slideUp('slow').remove()
    $('#topPositive').prepend(tweetHtml)
    $('#topPositive .top-tweet:first').slideDown('normal')
      .css('border-color','#82FF79')
    if $('#topPositive .top-tweet').length >= $('#posLimit').val()
      $('#topPositive .top-tweet:last').slideUp('normal').remove()
  else if tweet.sentiment < 0
    $('#topNegLoader').slideUp('slow').remove()
    $('#topNegative').prepend(tweetHtml)
    $('#topNegative .top-tweet:first').slideDown('normal')
        .css('border-color','#FF8675')
    if $('#topNegative .top-tweet').length >= $('#negLimit').val()
      $('#topNegative .top-tweet:last').slideUp('normal').remove()

$(document).ready -> $('select').material_select()

module.exports.init     = initTopTweets
module.exports.addTweet = addTopTweet