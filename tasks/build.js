var gulp    = require('gulp');
var runSequence = require('run-sequence');
var CONFIG  = require('../tasks/config');

/* Clean the work space */
gulp.task('build',  function (cb) {
    runSequence('clean',
        ['scripts', 'browserify', 'styles', 'images'],
        cb);
});