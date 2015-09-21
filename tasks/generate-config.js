/* Include the necessary modules */
var gulp    = require('gulp');
var fs = require('fs');

/* If configuration files don't exist, create them
    (they'll still need populating with keys and credentials)  */
gulp.task('generate-config',  function(){
    fs.open('config/src/keys.coffee','r',function(err){
        if (err && err.code==='ENOENT') {
            fs.createReadStream('config/src/sample-keys.coffee')
                .pipe(fs.createWriteStream('config/src/keys.coffee'));
        }
    });
});