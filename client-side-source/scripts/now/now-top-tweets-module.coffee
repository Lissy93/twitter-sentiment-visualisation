
initTopTweets = () ->




addTopTweet = (tweet) ->

  limit = 5

  tweetHtml = "<div class='top-tweet'>#{tweet.body}</div>"
  if tweet.sentiment > 0
    $('#topPosLoader').fadeOut('normal').remove()
    $('#topPositive').prepend(tweetHtml).slideDown('normal')
    if $('#topPositive .top-tweet').length >= limit
      $('#topPositive .top-tweet:last').slideUp('normal').remove()
  else if tweet.sentiment < 0
    $('#topNegLoader').fadeOut('normal').remove()
    $('#topNegative').prepend(tweetHtml).slideDown('normal')
    if $('#topNegative .top-tweet').length >= limit
      $('#topNegative .top-tweet:last').slideUp('normal').remove()


module.exports.init     = initTopTweets
module.exports.addTweet = addTopTweet