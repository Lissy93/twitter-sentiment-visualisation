/* Include the necessary modules */
var gulp    = require('gulp');
var bSync   = require('browser-sync');
var CONFIG  = require('../tasks/config').CONFIG;

gulp.task('browser-sync', ['nodemon', 'browserify', 'scripts', 'styles', 'test'], function () {
    bSync.init({
        files: [CONFIG.SOURCE_ROOT+'/**/*.*'],
        proxy: 'http://localhost:3000',
        port: 4000,
        browser: ['google chrome']
    });
    gulp.watch([
        CONFIG.SOURCE_ROOT+'/**/*.{js,coffee}',
            '!'+CONFIG.SOURCE_ROOT+'/**/*-{main,module}.{js,coffee}'],
        ['scripts', 'test']);
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*-{main,module}.{js,coffee}', ['browserify']);
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']);
    gulp.watch(CONFIG.SOURCE_ROOT+"/**/*").on('change', bSync.reload);
    gulp.watch("views/**/*.jade").on('change', bSync.reload);
});