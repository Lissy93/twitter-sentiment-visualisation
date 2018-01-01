/* Include the necessary modules */
var gulp    = require('gulp');

/* Moves Manifest into public dir */
gulp.task('manifest-move',  function(){
    return[
        gulp.src('client-side-source/manifest.json').pipe(gulp.dest('public')),
    ];
});