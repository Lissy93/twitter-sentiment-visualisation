
initTopTweets = () ->




addTopTweet = (tweet) ->

  limit = 8

  tweetHtml = "<div class='top-tweet' style='display: none'>#{tweet.body}</div>"
  if tweet.sentiment > 0
    $('#topPosLoader').slideUp('slow').remove()
    $('#topPositive').prepend(tweetHtml)
    $('#topPositive .top-tweet:first').slideDown('normal')
    if $('#topPositive .top-tweet').length >= limit
      $('#topPositive .top-tweet:last').slideUp('normal').remove()
  else if tweet.sentiment < 0
    $('#topNegLoader').slideUp('slow').remove()
    $('#topNegative').prepend(tweetHtml)
    $('#topNegative .top-tweet:first').slideDown('normal')
    if $('#topNegative .top-tweet').length >= limit
      $('#topNegative .top-tweet:last').slideUp('normal').remove()


module.exports.init     = initTopTweets
module.exports.addTweet = addTopTweet