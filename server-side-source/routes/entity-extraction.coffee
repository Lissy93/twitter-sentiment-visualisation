
# Require necessary modules, API keys and instantiate objects
Tweet = require '../models/Tweet' # The Tweet model
FetchTweets = require 'fetch-tweets'
twitterKey = require('../config/keys').twitter
fetchTweets = new FetchTweets twitterKey
entityExtraction =  require 'haven-entity-extraction'
hpKey = require('../config/keys').hp
express = require('express')
router = express.Router()


# Formats tweets into a massive tweet body
formatTweets = (twitterResults) ->
  results = ""
  for tweet in twitterResults then results += tweet.body + " "
  results = results.replace(/(?:https?|ftp):\/\/[\n\S]+/g, '')
  results =  results.replace(/[^A-Za-z0-9 ]/g, '')
  results = results.substring(0, 5000)


makeSankeyData = (startNode, data) ->
  results = {links: [], nodes: []}

  results.nodes.push {name: startNode}

  for key in Object.keys data
    nodeName = key.charAt(0).toUpperCase()+key.split('_')[0].slice(1)
    results.nodes.push {name: nodeName}
    results.links.push {
      source: startNode, target: nodeName, value: data[key].length}

    for entity in data[key]
      entityName = entity.normalized_text
      results.nodes.push {name: entityName}
      results.links.push {
        source: nodeName, target: entityName, value: entity.matches.length}

      for match in entity.matches
        canInsert = true
        for m in results.nodes then if m.name == match then canInsert = false
        if canInsert
          results.nodes.push {name: match}
          results.links.push {source: entityName, target: match, value:  0.5}
        else
          for l in results.links then if l.target == match then l.value += 0.5

  results

# Main route - no search term
router.get '/', (req, res, next) ->
  Tweet.getAllTweets (tweets) ->
    entityExtraction formatTweets(tweets), hpKey, (results) ->
      res.render 'page_entityExtraction',
        title: 'Entity Extraction'
        pageNum: 8
        data: results
        searchTerm: ''
        sankeyData: makeSankeyData 'Recent Tweets', results

# Route with search term
router.get '/:query', (req, res) ->
  searchTerm = req.params.query.toLowerCase() # Get the search term of URL param
  fetchTweets.byTopic searchTerm, (tweets) ->
    entityExtraction formatTweets(tweets), hpKey, (results) ->
      res.render 'page_entityExtraction',
        title: searchTerm+' | Entity Extraction'
        pageNum: 8
        data: results
        searchTerm: searchTerm
        sankeyData: makeSankeyData searchTerm, results

module.exports = router