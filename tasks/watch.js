
var gulp    = require('gulp');
var CONFIG  = require('../tasks/config').CONFIG;


/* Configure files to watch for changes - NOT USED AS BY DEFAULT */
gulp.task('watch', function() {
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{js,coffee}', ['scripts']);
    gulp.watch(CONFIG.SOURCE_ROOT+'/**/*.{css,less}',  ['styles']);
});