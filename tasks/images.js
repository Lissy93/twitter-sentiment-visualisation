/* Include the necessary modules */
var gulp    = require('gulp');

/* CSS and Less Tasks */
gulp.task('images',  function(){
    return[
        gulp.src('client-side-source/graphics/favicon.ico').pipe(gulp.dest('public')),
        gulp.src('client-side-source/graphics/**/*.{png,gif,jpg}').pipe(gulp.dest('public/images'))
    ];
});