var gulp    = require('gulp');
var mocha   = require('gulp-mocha');
var istanbul = require('gulp-istanbul');
var gulpIf  = require('gulp-if');
var argv    = require('yargs').argv;

var CONFIG  = require('../tasks/config');
var devMode = argv.dev ? true : CONFIG.SHOW_OUTPUT;
var reportMode = devMode ? 'spec' : 'nyan';

require('coffee-script/register');

/* Run all tests and produce coverage report */
gulp.task('test', function (cb) {
    gulp.src(['source/**/*.js', 'main.js'])
        .pipe(istanbul()) // Covering files
        .pipe(istanbul.hookRequire()) // Force `require` to return covered files
        .on('finish', function () {
            gulp.src(['test/*.{js,coffee}'])
                .pipe(mocha({reporter: reportMode}))

                .pipe(gulpIf(devMode, istanbul.writeReports({dir: './reports/coverage-reports'})))
                .pipe(istanbul.enforceThresholds({ thresholds: { global: 90 } })) // Enforce a coverage of at least 90%
                .on('end', cb);
        });
});

/* Run Mocha tests */
gulp.task('mocha', function () {
    return gulp.src('test/*.{js,coffee}')
        .pipe(mocha({reporter: 'list'}));
});