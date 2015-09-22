# Building
> TSV uses the Gulp streaming build tool to automate the development workflow.


### JavaScript and CoffeeScript
> Run `gulp scripts`

This tasks will itterate through the list of JavaScript source and destination directories outlined in the `config.coffee` file, and for each of them it will carry out the following tasks:
- It will firstly ignore any Browserify files or components of a bundle to avoid unecissary work
- It will then look to see which files have changed, again would be pointless to dupplicate work
- All CoffeeScript files will be linted and any results printed to the console
- All CoffeeScript files will be compiled into JavaScript
- The JavaScript files will too be linted
- The JavaScript files will be minified 
- License text added in a comment as a footer of the JavaScript files
- Size calculated and logged, for development
- The final results will be piped to the appropriate destination folder


### Bundeling frontend dependancies 
> Run `gulp browserify`

The fontent JavaScript files need to bundled before they can be used, Browserify has been used to do this:
- Each main file is selected 
- A Coffee filter is applied to those written in CoffeeScript
- A JSX filter is applied to those written in JSX
- Each main file is then bundled with it's dependencies, renamed and saved to destination
- Sourcemaps are also generated for debugging
- The size of each bundle is outputed to the console


### Less and CSS
> Run `gulp styles`

The styles task selects all CSS and Less files in the source directory and carries out the following tasks:
- Lints the Less, printing out errors if necissary
- Lints the CSS in a similar way, again printing out results to the console
- Compiles Less into CSS
- Concatinates multiple CSS files together ONLY IF they were origionally in the same sub-directory
- Minifys CSS
- Adds footer
- Prints file size to console


### Preparing Graphics
> Run `gulp images`

All the graphics in the source directory are processes and saved to the relevant location in the public folder.


### Removing Obsolete Files
> Run `gulp clean`

Cleans the public directory, deleates all previously compiled files


### Building Entire Project
> Run `gulp build`

Runs the `clean` task once that is complete, it will run the `scripts`, `browserify`, `styles` and `images` tasks to generate all built files


### Recompiling Files on Change
> Run `gulp watch`

Will watch all files in working directories for changes. When a file is modified it will call the appropriate task to create new built version. e.g. when a .less file changes the `styles` task will be run.


### Running the Project
> Run `gulp nodemon`

Starts the server using Nodemon, should automatically restart on file change.


### Running on multiple browser or devices in sync
> Run `gulp browser-sync`

Uses Browser Sync to keep multiple different browsers potentially accross different devices fully in sync. Essential tool for quickly testing UI's accross many screensizes, platforms and environments.


### Run All Tests
> Run `gulp test`

This will run all the Mocha unit tests, and also the Istanbul coverage tests. The results of both will be printed to the console.


### Generating config files for first time use
> Run `gulp generate-config`

Only needs to be run once, before first time use. It will generate the .gitignore's json file for storing API keys. This file will then need to be populated and saved, but elmininates the file not found error.


### Default Task
> Run `gulp`

The default task pretty much combines all the above tasks in a nice order. It will first clean the working directory and then simultaniously run the `scripts`, `browserify`, `styles`, `images` tasks and also run the `test` task. After that it will start the server with the `nodemon` and `browser-sync` task. It will then continue to watch and re-compile code as it changes, keeping the browsers all perfectly in sync. Pretty awesome tool gulp is.


## Dev Mode
Any of the Gulp tasks can be run with the --dev flag after them go get the full output. (the desfault can be set in the task below)

## Modifying Configuration
All the configuration is stored in `config.coffee`


## Gulp Plugins 
> This gulp set up was made possible thanks to all the developers who created the following open source modules.

- [browser-sync](https://www.npmjs.com/package/browser-sync)
- [browserify](https://www.npmjs.com/package/browserify)
- [coffeeify](https://www.npmjs.com/package/coffeeify)
- [del](https://www.npmjs.com/package/del)
- [event-stream](https://www.npmjs.com/package/event-stream)
- [glob](https://www.npmjs.com/package/glob)
- [gulp](https://www.npmjs.com/package/gulp)
- [gulp-changed](https://www.npmjs.com/package/gulp-changed)
- [gulp-coffee](https://www.npmjs.com/package/gulp-coffee)
- [gulp-coffeelint](https://www.npmjs.com/package/gulp-coffeelint)
- [gulp-concat](https://www.npmjs.com/package/gulp-concat)
- [gulp-csslint](https://www.npmjs.com/package/gulp-csslint)
- [gulp-filesize](https://www.npmjs.com/package/gulp-filesize)
- [gulp-filter](https://www.npmjs.com/package/gulp-filter)
- [gulp-footer](https://www.npmjs.com/package/gulp-footer)
- [gulp-if](https://www.npmjs.com/package/gulp-if)
- [gulp-istanbul](https://www.npmjs.com/package/gulp-istanbul)
- [gulp-jshint](https://www.npmjs.com/package/gulp-jshint)
- [gulp-less](https://www.npmjs.com/package/gulp-less)
- [gulp-minify-css](https://www.npmjs.com/package/gulp-minify-css)
- [gulp-mocha](https://www.npmjs.com/package/gulp-mocha)
- [gulp-nodemon](https://www.npmjs.com/package/gulp-nodemon)
- [gulp-recess](https://www.npmjs.com/package/gulp-recess)
- [gulp-rename](https://www.npmjs.com/package/gulp-rename)
- [gulp-sourcemaps](https://www.npmjs.com/package/gulp-sourcemaps)
- [gulp-uglify](https://www.npmjs.com/package/gulp-uglify)
- [gulp-uncss](https://www.npmjs.com/package/gulp-uncss)
- [gulp-util](https://www.npmjs.com/package/gulp-util)
- [istanbul](https://www.npmjs.com/package/istanbul)
- [jshint-stylish](https://www.npmjs.com/package/jshint-stylish)
- [mocha](https://www.npmjs.com/package/mocha)
- [mochawesome](https://www.npmjs.com/package/mochawesome)
- [reactify](https://www.npmjs.com/package/reactify)
- [require-dir](https://www.npmjs.com/package/require-dir)
- [run-sequence](https://www.npmjs.com/package/run-sequence)
- [vinyl-buffer](https://www.npmjs.com/package/vinyl-buffer)
- [vinyl-source-stream](https://www.npmjs.com/package/vinyl-source-stream)
- [yargs](https://www.npmjs.com/package/yargs)
