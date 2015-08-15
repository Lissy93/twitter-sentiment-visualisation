var gulp    = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var coffeeify = require('coffeeify');
var buffer = require('vinyl-buffer');
var sourcemaps = require('gulp-sourcemaps');
var glob = require('glob');
var es = require('event-stream');
var rename = require('gulp-rename');
var footer = require('gulp-footer');
var gutil   = require('gulp-util');
var gsize   = require('gulp-filesize');

var CONFIG  = require('../tasks/config').CONFIG;

gulp.task('browserify', function (cb) {
    glob('./'+CONFIG.SOURCE_ROOT+'/'+CONFIG.JS_SRC_DIR_NAME+'/**/main-**.{js,coffee}', function(err, files) {
        var tasks = files.map(function(entry) {
            return browserify({ entries:    [entry], debug: true })
                .transform(coffeeify)
                .bundle()
                .pipe(source(entry))
                .pipe(rename(function(filepath) {
                    filepath.basename = filepath.basename.replace("main-","");
                    filepath.dirname = "";
                    filepath.extname = ".bundle.js";

                }))
                .pipe(buffer())
                /* Uncomment the next two lines for source maps for debugging */
                //.pipe(sourcemaps.init({loadMaps: true}))
                //.pipe(sourcemaps.write('./'))
                .pipe(footer(CONFIG.FOOTER_TEXT))
                .pipe(gsize())
                .pipe(gulp.dest('./public/javascripts'))
                .on('error', gutil.log);
        });
        es.merge(tasks);
    });
});