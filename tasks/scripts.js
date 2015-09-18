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

    var allScriptSelector = '**/*.{js,coffee}'; // Selects all CoffeeScript and JavaScript files in nested directories

    /* File path strings */
    var jsSrcPath = CONFIG.SOURCE_ROOT + '/'+CONFIG.JS_SRC_DIR_NAME+'/'+allScriptSelector;
    var jsResPath = CONFIG.DEST_ROOT + '/'+CONFIG.JS_DEST_DIR_NAME;

    /* A list of file sources and destinations */
    var paths = [
        { src: jsSrcPath, dest: jsResPath },
        { src: 'models/src/*.coffee', dest: 'models' },
        { src: 'utils/src/*.coffee', dest: 'utils' },
        { src: 'config/src/*.coffee', dest: 'config' }
    ];

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
        var coffeeFilter = filter('**/*.coffee', {restore: true}); // MUST be declared here in order to RESET correctly

        return gulp.src(srcPath)
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
            //.pipe(uglify())
            .pipe(footer(CONFIG.FOOTER_TEXT))
            .pipe(gsize())
            .pipe(gulp.dest(resPath));
    }

});