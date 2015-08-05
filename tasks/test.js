var gulp    = require('gulp');
var mocha   = require('gulp-mocha');
var istanbul = require('gulp-istanbul');

require('coffee-script/register')

/* Run all tests and produce coverage report */
gulp.task('test', function (cb) {
    gulp.src(['source/**/*.js', 'main.js'])
        .pipe(istanbul()) // Covering files
        .pipe(istanbul.hookRequire()) // Force `require` to return covered files
        .on('finish', function () {
            gulp.src(['test/*.{js,coffee}'])
                .pipe(mocha())
                .pipe(istanbul.writeReports()) // Creating the reports after tests ran
                .pipe(istanbul.enforceThresholds({ thresholds: { global: 90 } })) // Enforce a coverage of at least 90%
                .on('end', cb);
        });
});

/* Run Mocha tests */
gulp.task('mocha', function () {
    return gulp.src('test/*.{js,coffee}')
        .pipe(mocha({compiler: 'nyan'}));
});