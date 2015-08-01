var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
    res.render('page_about', { title: 'About', pageNum: 5 });
});

module.exports = router;
