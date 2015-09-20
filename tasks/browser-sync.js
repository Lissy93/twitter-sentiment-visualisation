/* Include the necessary modules */
var gulp    = require('gulp');
var bSync   = require('browser-sync');
var runSequence = require('run-sequence');

var CONFIG  = require('../tasks/config').CONFIG;
//todo build before nodemon

gulp.task('start', function () {
    runSequence('build', 'test', 'nodemon', 'browser-sync');
});

gulp.task('browser-sync', function () {
    bSync.init({
        files: [CONFIG.SOURCE_ROOT+'/**/*.*'],
        proxy: 'http://localhost:3000',
        port: 4000,
        browser: ['google chrome'],
        open: false // Don't open browser automatically - it's annoying
    });

    /* For each CoffeeScript directory, watch, compile and reload */
    CONFIG.SCRIPT_PATHS.forEach(function(path) {
        gulp.watch(path.src, ['scripts']).on('change', bSync.reload);
    });

    /* Watch build and re-bundle browserify files */
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*-{main,module}.{js,coffee}', ['browserify'])
        .on('change', bSync.reload);

    /* Watch compile and reload LESS, SASS and CSS */
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']).on('change', bSync.reload);

    /* And reload browsers when the views change too */
    gulp.watch("views/**/*.jade").on('change', bSync.reload);

});