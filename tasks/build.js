var gulp    = require('gulp');
var runSequence = require('run-sequence');

/* Clean the work space */
gulp.task('build',  function (cb) {
    runSequence('clean',
        ['scripts', 'browserify', 'styles', 'images', 'manifest-move'],
        cb);
});