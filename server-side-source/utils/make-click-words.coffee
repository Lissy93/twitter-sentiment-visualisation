
removeWords = require 'remove-words'

# Makes keywords click-able hyperlinks, returns HTML
makeClickWords = (body) ->
  clWord = (word) -> (''+word).toLowerCase().replace /\W/g, ''
  clickWords = removeWords body # Array of keywords
  htmlTweet = ''
  aStyle = 'style="color: black; font-weight: bold;" ' # style for hyperlinks
  for word in body.split " "
    if clWord(word) in clickWords
      htmlTweet += "<a #{aStyle} href='/text-tweets/#{clWord word}'>#{word}</a> "
    else htmlTweet += "#{word} "
  htmlTweet

module.exports = makeClickWords