
document.getElementById('mobile-nav').style.display = 'none';

ConfigureGlobe = require '../globe/configure-globe-module.coffee'
socketModule  = require('../globe/socket-module.coffee')

configureGlobe = new ConfigureGlobe()

configureGlobe.go()

window.addSentiment = (so) -> configureGlobe.addNewPoint(so)

mainPage = 'globe'

require '../page-controls-module.coffee'



