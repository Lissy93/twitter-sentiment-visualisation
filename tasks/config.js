/* Define constants */
var footerText = "\n\/* (C) Alicia Sykes <alicia@aliciasykes.com> 2015           " +
    "*\\\r\n\\* MIT License. Read full license at: https:\/\/goo.gl\/IL4lQJ *\/"

module.exports = {
    SOURCE_ROOT         : "client-side-source",  // Folder name for all js and css client-side-source
    DEST_ROOT           : "public",     // Folder name for the results root
    CSS_DEST_DIR_NAME   : "stylesheets",// Name of CSS directory
    CSS_SRC_DIR_NAME    : "styles",     // Name of CSS directory
    JS_FILE_NAME        : "all.min.js", // Name of output JavaScript file
    CSS_FILE_NAME       : "all.min.css",// Name of output CSS file
    FOOTER_TEXT         : footerText,   // Optional footer text for output files
    SCRIPT_PATHS        : [             // Paths for JavaScript files
        { src: 'client-side-source/scripts/**/*.{js,coffee}',   dest: 'public/javascripts' },
        { src: 'client-side-source/scripts/visualisations/*.coffee', dest: 'public/javascripts/charts' },
        { src: 'server-side-source/models/*.coffee',               dest: 'models' },
        { src: 'server-side-source/utils/*.coffee',                dest: 'utils' },
        { src: 'server-side-source/config/*.coffee',               dest: 'config' },
        { src: 'server-side-source/routes/*.coffee',               dest: 'routes' },
        { src: 'server-side-source/routes/api/*.coffee',           dest: 'routes' }
    ],
    SHOW_OUTPUT: true
};