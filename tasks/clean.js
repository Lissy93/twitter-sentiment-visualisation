var gulp    = require('gulp');
var del     = require('del');
var CONFIG  = require('../tasks/config').CONFIG;

/* Clean the work space */
gulp.task('clean', function (cb) {
    del([
        CONFIG.DEST_ROOT+'/'+CONFIG.JS_DEST_DIR_NAME+'/**/*',
        CONFIG.DEST_ROOT+'/'+CONFIG.CSS_DEST_DIR_NAME+'/**/*'
    ], cb);
});