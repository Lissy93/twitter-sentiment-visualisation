var express = require('express');
var router = express.Router();
var React = require('react');
var TweetsApp = React.createFactory(require('../components/TweetsApp'));
var Tweet = require('../models/Tweet');

router.get('/', function(req, res) {
    Tweet.getTweets(0,0, function(tweets) {

        var reactHtml = React.renderToString(TweetsApp({tweets: tweets}));

        res.render('page_livemap', {
            title: 'Live Sentiment Map',
            pageNum: 2,
            markup: reactHtml,
            state: JSON.stringify(tweets)
        });
    });

});

module.exports = router;