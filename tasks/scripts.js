var gulp    = require('gulp');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');
var jshint  = require('gulp-jshint');
var uglify  = require('gulp-uglify');
var coffee  = require('gulp-coffee');
var cofLint = require('gulp-coffeelint');
var footer  = require('gulp-footer');
var filter  = require('gulp-filter');

var CONFIG  = require('../tasks/config').CONFIG;

/* JavaScript Tasks */
gulp.task('scripts',  function(){

    /* A list of file sources and destinations */
    var paths = CONFIG.SCRIPT_PATHS;

    /* For each file path, run all script tasks */
    var tasks = [];
    paths.forEach(function(path) {
        tasks.push(awsesomeizeScripts(path.src, path.dest));
    });

    return (tasks); // Return all results as array of multiple streams

    /* Function applies all the tasks on the script files and returns a pipe dest */
    function awsesomeizeScripts(srcPath, resPath){

        /* Filters to be applied (so that different operations can be done on different files) */
        var bundleFilter = filter(['*', '!**/*-main.{js,coffee}', '!**/*-main.{js,coffee}']);
        var coffeeFilter = filter('**/*.coffee', {restore: true}); // MUST be declared here in order to RESET correctly!

        return gulp.src(srcPath)
            .pipe(bundleFilter) // Ignore browserify files

            /* CoffeeScript tasks */
            .pipe(coffeeFilter)
            .pipe(cofLint())
            .pipe(cofLint.reporter())
            .pipe(coffee())
            .pipe(coffeeFilter.restore)

            .pipe(jshint())
            .pipe(jshint.reporter('jshint-stylish'))
            //.pipe(uglify()) // Uncomment line to minify output JavaScript
            .pipe(footer(CONFIG.FOOTER_TEXT))
            .pipe(gsize())
            .pipe(gulp.dest(resPath));
    }
});