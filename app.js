
/* Include necessary node modules */
var express       = require('express');
var path          = require('path');
var favicon       = require('serve-favicon');
var logger        = require('morgan');
var cookieParser  = require('cookie-parser');
var bodyParser    = require('body-parser');
var mongoose      = require('mongoose');
var http          = require('http');
//var streamTweets  = require('stream-tweets'); //TODO fix package and re-add it
var JSX           = require('node-jsx').install({extension: '.jsx'});

var twitter       = require('ntwitter');

/* Include the files defining the routes */
var routes    = require('./routes/index');
var map       = require('./routes/map');
var liveMap   = require('./routes/live-map');
var timeline  = require('./routes/timeline');
var about     = require('./routes/about');
var streamHandler = require('./utils/stream-handler');

/* Create Express server and configure socket.io*/
var app = express();
var port = process.env.PORT || 8080;
var server = http.createServer(app);
var io = require('socket.io').listen(server);
server.listen(port, function(){
    console.log('Express server listening on port ' + port);
});

/* view engine setup */
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

/* Set up other Express bits and bobs */
app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/bower_components',  express.static(__dirname + '/bower_components'));

/* Connect to MongoDB */
mongoose.connect('mongodb://localhost/twitter-sentiment-visualisations');

/* Specify which route files to use */
app.use('/', routes);
app.use('/map', map);
app.use('/real-time-map', liveMap);
app.use('/timeline', timeline);
app.use('/about', about);


/* Set a stream listener for tweets matching tracking keywords */
var credentials = require('./config/keys').twitter;

//var st = new streamTweets(credentials); //TODO add this back in once module is fixed
var twit = new twitter(credentials);

twit.stream('statuses/filter',{ track: 'hello'}, function(stream){
    streamHandler(stream,io);
});


/* catch 404 and forward to error handler */
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

/*-- error handlers -- */

/* development error handler (will print stacktrace) */
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

/* production error handler (no stacktraces leaked to user) */
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});



module.exports = app;
