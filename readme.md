# Twitter Sentiment Visualisations

[![Build Status](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation.svg?branch=dev)](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation)
[![devDependency Status](https://david-dm.org/lissy93/twitter-sentiment-visualisation/dev-status.svg)](https://david-dm.org/lissy93/twitter-sentiment-visualisation#info=devDependencies)
[![Dependency Status](https://david-dm.org/lissy93/twitter-sentiment-visualisation.svg)](https://david-dm.org/lissy93/twitter-sentiment-visualisation)
[![Codacy Badge](https://api.codacy.com/project/badge/1caedd6623554c5cacb3cb450bc30a62)](https://www.codacy.com/app/lissy93/twitter-sentiment-visualisation)
[![Test Coverage](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/badges/coverage.svg)](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/coverage)

A web app that uses data from Twitter combined with sentiment analysis and
emotion detection to create a series of data visualisations to illustrate
the happy and less happy locations, topics and times.

## Running Locally
1. **Prerequisites** - You will need [Node.js], [MongoDB] and [git]  installed on 
your system. You will also need Gulp and Bower, which (once node is installed) 
you can install by running ```npm install gulp bower -g```.
2. **Get the files** - Run: ```git clone https://github.com/Lissy93/twitter-
sentiment-visualisation.git``` to clone the repo and then 
```cd twitter-sentiment-visualisation```  to navigate into the directory.
3. **Install dependencies** -  Run: ```npm install``` to populates the node
_modules, and then ```bower install``` which will download the bower_components.
4. **Set Config** Run: ```npm run config```  to generate ```config\src\keys.coffee``` 
which you will need to populate with your API keys and save.
 Also check that your happy with the app config in ```config/src/app-config.coffee```.
5. **Build Project** - Run ```npm run build``` to generate the compiled code from
 the source.
6. **Start MongoDB** - See instructions: [Starting a MongoDB instance]. You will 
need to run MongoDB in a separate terminal window.
7. **Run the project** - Run ```npm start``` then open your browser and navigate 
to [http://localhost:8080]

View [detailed installation instructions]

To run the tests: ```npm test``` or see the more [detailed testing plan]

To modify/ develop code see [about the build environment]

   [Node.js]: <https://nodejs.org/en/>
   [MongoDB]: <https://www.mongodb.org/>
   [git]: <https://git-scm.com/>
   [Starting a MongoDB instance] : <http://docs.mongodb.org/master/tutorial/getting-started-with-the-mongo-shell/>
   [http://localhost:8080]: <http://localhost:8080>
   [detailed installation instructions]: <docs/installation-instructions.md>
   [detailed testing plan]: <docs/methodology-testing.md>
   [about the build environment] : <docs/build-environment.md>


