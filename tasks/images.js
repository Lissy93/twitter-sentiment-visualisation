/* Include the necessary modules */
var gulp    = require('gulp');

/* CSS and Less Tasks */
gulp.task('images',  function(){
    return[
        gulp.src('source/graphics/favicon.ico').pipe(gulp.dest('public')),
        gulp.src('source/graphics/*.{png,gif}').pipe(gulp.dest('public/images'))
    ];
});