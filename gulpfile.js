/**
 * @author Alicia Sykes <alicia@aliciasykes.com> June 2015
 * To run script run "gulp" in the command line
 * My super amazing gulp setup, does EVERYTHING cool
 * possible to do to turns already awesome code into
 * even more awesomely efficient code
 *
 * The Gulp tasks are divided into the files in the './tasks/' directory
 * Read the build documentation at './docs/building.md'
 */

// Include gulp and require directory module
var gulp    = require('gulp');
var reqdir  = require('require-dir');

reqdir('./tasks'); // Include the folders containing ALL gulp tasks

gulp.task('default', ['start']); // Default task