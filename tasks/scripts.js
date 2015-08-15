var gulp    = require('gulp');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');
var jshint  = require('gulp-jshint');
var uglify  = require('gulp-uglify');
var coffee  = require('gulp-coffee');
var cofLint = require('gulp-coffeelint');
var changed = require('gulp-changed');
var footer  = require('gulp-footer');
var filter  = require('gulp-filter');

var CONFIG  = require('../tasks/config').CONFIG;

/* JavaScript Tasks */
gulp.task('scripts',  function(){

    var coffeeFilter = filter('**/*.coffee', {restore: true});
    var bundleFilter = filter(['*', '!**/*-main.{js,coffee}', '!**/*-main.{js,coffee}']);

    var jsSrcPath = CONFIG.SOURCE_ROOT + '/'+CONFIG.JS_SRC_DIR_NAME+'/**/*.{coffee,js}';
    var jsResPath = CONFIG.DEST_ROOT + '/'+CONFIG.JS_DEST_DIR_NAME;

    return gulp.src(jsSrcPath)
        .pipe(bundleFilter) // Ignore browserify files

        /* CoffeeScript tasks */
        .pipe(coffeeFilter)
        .pipe(cofLint())
        .pipe(cofLint.reporter())
        .pipe(coffee())
        .pipe(coffeeFilter.restore)

        .pipe(changed(jsResPath))
        .pipe(jshint())
        .pipe(jshint.reporter('jshint-stylish'))
        .pipe(uglify())
        .pipe(footer(CONFIG.FOOTER_TEXT))
        .pipe(gsize())
        .pipe(gulp.dest(jsResPath))

});