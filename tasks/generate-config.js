/* Include the necessary modules */
var gulp    = require('gulp');
var fs = require('fs');

/* If configuration files don't exist, create them
    (they'll still need populating with keys and credentials)  */
gulp.task('generate-config',  function(){
    fs.open('server-side-source/config/keys.coffee','r',function(err){
        if (err && err.code==='ENOENT') {
            fs.createReadStream('server-side-source/config/sample-keys.coffee')
                .pipe(fs.createWriteStream('server-side-source/config/keys.coffee'));
        }
    });
});
