var gulp    = require('gulp');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');
var jshint  = require('gulp-jshint');
var concat  = require('gulp-concat');
var uglify  = require('gulp-uglify');
var coffee  = require('gulp-coffee');
var cofLint = require('gulp-coffeelint');
var changed = require('gulp-changed');
var footer  = require('gulp-footer');
var es      = require('event-stream');

var CONFIG  = require('../tasks/config').CONFIG;

/* JavaScript Tasks */
gulp.task('scripts',  function(){
    var jsSrcPath = CONFIG.SOURCE_ROOT + '/'+CONFIG.JS_SRC_DIR_NAME+'/**/*';
    var jsResPath = CONFIG.DEST_ROOT + '/'+CONFIG.JS_DEST_DIR_NAME;

    var jsFromCs = gulp.src(jsSrcPath+'.coffee')
        .pipe(cofLint())
        .pipe(cofLint.reporter())
        .pipe(coffee());

    var jsFromPlain = gulp.src(jsSrcPath+'.js');

    return es.merge(jsFromCs, jsFromPlain)
        .pipe(changed(jsResPath))
        .pipe(jshint())
        .pipe(jshint.reporter('jshint-stylish'))
        //.pipe(concat(CONFIG.JS_FILE_NAME,{newLine: ';'}))
        .pipe(uglify())
        .pipe(footer(CONFIG.FOOTER_TEXT))
        .pipe(gsize())
        .pipe(gulp.dest(jsResPath))
        .on('error', gutil.log);

});