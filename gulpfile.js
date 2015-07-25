/**
 * @author Alicia Sykes <alicia@aliciasykes.com> June 2015
 * To run script run "gulp" in the command line
 * My super amazing gulp setup, does EVERYTHING cool
 * possible to do to turns already awesome code into
 * even more awesomely efficient code
 * View very commented version at https://goo.gl/3K2sFb
 */

/* Include the necessary modules */
var gulp    = require('gulp');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');
var jshint  = require('gulp-jshint');
var concat  = require('gulp-concat');
var uglify  = require('gulp-uglify');
var coffee  = require('gulp-coffee');
var cofLint = require('gulp-coffeelint');
var less    = require('gulp-less');
var cssLint = require('gulp-csslint');
var minCss  = require('gulp-minify-css');
var uncss   = require('gulp-uncss');
var changed = require('gulp-changed');
var footer  = require('gulp-footer');
var nodemon = require('gulp-nodemon');
var bSync   = require('browser-sync');
var es      = require('event-stream');
var del     = require('del');

/* Define constants */
var CONFIG = {
    SOURCE_ROOT         : "source",     // Folder name for all js and css source
    DEST_ROOT           : "public",     // Folder name for the results root
    JS_DEST_DIR_NAME    : "scripts",    // Name of JavaScript directory
    JS_SRC_DIR_NAME     : "scripts",    // Name of JavaScript directory
    CSS_DEST_DIR_NAME   : "stylesheets",// Name of CSS directory
    CSS_SRC_DIR_NAME    : "styles",     // Name of CSS directory
    JS_FILE_NAME        : "all.min.js", // Name of output JavaScript file
    CSS_FILE_NAME       : "all.min.css",// Name of output CSS file
    FOOTER_TEXT         : ""            // Optional footer text for output files
};


/* Clean the work space */
gulp.task('clean', function (cb) {
    del([
        CONFIG.DEST_ROOT+'/'+CONFIG.JS_DEST_DIR_NAME+'/**/*',
        CONFIG.DEST_ROOT+'/'+CONFIG.CSS_DEST_DIR_NAME+'/**/*'
    ], cb);
});

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
        .pipe(concat(CONFIG.JS_FILE_NAME,{newLine: ';'}))
        .pipe(uglify())
        .pipe(footer(CONFIG.FOOTER_TEXT))
        .pipe(gsize())
        .pipe(gulp.dest(jsResPath))
        .on('error', gutil.log);

});

/* CSS Tasks */
gulp.task('styles',  function(){
    var cssSrcPath = CONFIG.SOURCE_ROOT + '/'+CONFIG.CSS_SRC_DIR_NAME+'/**/*';
    var cssResPath = CONFIG.DEST_ROOT + '/'+CONFIG.CSS_DEST_DIR_NAME;

    var cssFromLess = gulp.src(cssSrcPath+'.less')
        .pipe(less());

    var cssFromVanilla = gulp.src(cssSrcPath+'.css');

    return es.merge(cssFromLess, cssFromVanilla)
        .pipe(changed(cssResPath))
        .pipe(cssLint())
        .pipe(cssLint.reporter())
        .pipe(concat(CONFIG.CSS_FILE_NAME))
        .pipe(minCss({compatibility: 'ie8'}))
        .pipe(gsize())
        .pipe(gulp.dest(cssResPath))
        .on('error', gutil.log);

});


/* Configure files to watch for changes */
gulp.task('watch', function() {
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{js,coffee}', ['scripts']);
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']);
});

/* Start Nodemon */
gulp.task('demon', function () {
    gulp.start('scripts', 'styles');
    nodemon({
        script: './bin/www',
        ext: 'js coffee css less html',
        ignore: ['public/**/*'],
        env: { 'NODE_ENV': 'development'}
    })
        .on('start', function(){
            gulp.start('scripts', 'styles');
        })
        .on('change', ['watch'])
        .on('restart', function () {
            console.log('restarted!');
        });
});



/* Nodemon task for monitory for changes with live restarting */
gulp.task('nodemon', function (cb) {
    var called = false;
    return nodemon({
        script: './bin/www',
        watch: ['source/**/*']
    })
        .on('start', function onStart() {
            if (!called) { cb(); }
            called = true;
        })
        .on('restart', function onRestart() {
            setTimeout(function reload() {
                bSync.reload({
                    stream: false
                });
            }, 500);
        });
});

gulp.task('browser-sync', ['nodemon', 'scripts', 'styles'], function () {
    bSync.init({
        files: [CONFIG.SOURCE_ROOT+'/**/*.*'],
        proxy: 'http://localhost:3000',
        port: 4000,
        browser: ['google chrome']
    });
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{js,coffee}', ['scripts']);
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']);
    gulp.watch(CONFIG.SOURCE_ROOT+"/**/*").on('change', bSync.reload);
    gulp.watch("views/**/*.jade").on('change', bSync.reload);
});



/* Default Task */
gulp.task('default', ['clean', 'browser-sync']);