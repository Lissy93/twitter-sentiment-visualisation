var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('page_timeline', { title: 'Time Line', pageNum: 2 });
});

module.exports = router;
