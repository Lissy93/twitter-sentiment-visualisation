
var gulp    = require('gulp');
var CONFIG  = require('../tasks/config').CONFIG;


/* Configure files to watch for changes - NOT USED BY DEFAULT TASK */
gulp.task('watch', function() {

    /* For each CoffeeScript directory, watch, compile and reload */
    CONFIG.SCRIPT_PATHS.forEach(function(path) {
        gulp.watch(path.src, ['scripts']);
    });

    /* Watch build and re-bundle browserify files */
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*-{main,module}.{js,coffee}', ['browserify']);

    /* Watch compile and reload LESS, SASS and CSS */
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']);

});