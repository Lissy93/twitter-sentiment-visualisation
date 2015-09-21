/* Include the necessary modules */
var gulp    = require('gulp');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');
var concat  = require('gulp-concat');
var less    = require('gulp-less');
var cssLint = require('gulp-csslint');
var minCss  = require('gulp-minify-css');
var changed = require('gulp-changed');
var footer  = require('gulp-footer');
var es      = require('event-stream');
var gulpIf  = require('gulp-if');
var argv    = require('yargs').argv;

var CONFIG  = require('../tasks/config');

var devMode = argv.dev ? true : CONFIG.SHOW_OUTPUT;

/* CSS and Less Tasks */
gulp.task('styles',  function(){
    var cssSrcPath = CONFIG.SOURCE_ROOT + '/'+CONFIG.CSS_SRC_DIR_NAME;
    var cssResPath = CONFIG.DEST_ROOT + '/'+CONFIG.CSS_DEST_DIR_NAME;

    var cssFromLess = gulp.src([cssSrcPath+'/*.less'])
        .pipe(less());
    var cssFromVanilla = gulp.src([cssSrcPath+'/*.css']);

    var excludedCss = gulp.src(cssSrcPath+'/*/*.css');

    var excludedLess = gulp.src(cssSrcPath+'/*/*.less')
        .pipe(less());

    var concatinatedCss = es.merge(cssFromLess, cssFromVanilla)
        .pipe(concat(CONFIG.CSS_FILE_NAME));

    return es.merge(concatinatedCss, excludedCss, excludedLess)
        .pipe(changed(cssResPath))
        .pipe(cssLint())
        .pipe(gulpIf(devMode, cssLint.reporter()))
        .pipe(minCss({compatibility: 'ie8'}))
        .pipe(gulpIf(devMode, gsize()))
        .pipe(footer(CONFIG.FOOTER_TEXT))
        .pipe(gulp.dest(cssResPath))
        .on('error', gutil.log);
});