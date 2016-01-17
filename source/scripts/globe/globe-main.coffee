
ConfigureGlobe = require '../globe/configure-globe-module.coffee'
socketModule  = require('../globe/socket-module.coffee')


configureGlobe = new ConfigureGlobe()

configureGlobe.go()

window.addSentiment = (so) -> configureGlobe.addNewPoint(so)

require '../globe/page-controls-module.coffee'



