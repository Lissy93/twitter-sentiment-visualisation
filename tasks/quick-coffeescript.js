var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var CONFIG  = require('../tasks/config');

gulp.task('quick-coffeescript-watch', function(){
    gulp.watch('./**/*.coffee', ['quick-coffeescript']);
});

gulp.task('quick-coffeescript',  function(){

    /* A list of file sources and destinations */
    var paths = CONFIG.SCRIPT_PATHS;

    /* For each file path, run all script tasks */
    var tasks = [];
    paths.forEach(function(path) { tasks.push(coffeeify(path.src, path.dest))});
    return (tasks); // Return all results as array of multiple streams

    /* Function applies all the tasks on the script files and returns a pipe dest */
    function coffeeify(srcPath, resPath){
        return gulp.src(srcPath).pipe(coffee()).pipe(gulp.dest(resPath));
    }
});