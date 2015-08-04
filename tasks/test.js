var gulp    = require('gulp');
var mocha   = require('gulp-mocha');
require('coffee-script/register')

/* Run Mocha tests */
gulp.task('test', function () {
    return gulp.src('test/*.{js,coffee}')
        .pipe(mocha({compiler: 'nyan'}));
});