/* Include the necessary modules */
var gulp    = require('gulp');

/* Moves Manifest into public dir */
gulp.task('file-mover',  function(){
    return[
        gulp.src('client-side-source/manifest.json').pipe(gulp.dest('public')),
        gulp.src('client-side-source/data/regions.csv').pipe(gulp.dest('public/data')),
        gulp.src('client-side-source/data/all_sentiment_results_edwardsnowdon.json').pipe(gulp.dest('public/data'))
    ];
});
