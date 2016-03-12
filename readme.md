# Twitter Sentiment Visualisations

[![Build Status](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation.svg?branch=dev)](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation)
[![Dependency Status](https://david-dm.org/lissy93/twitter-sentiment-visualisation.svg)](https://david-dm.org/lissy93/twitter-sentiment-visualisation)
[![devDependency Status](https://david-dm.org/lissy93/twitter-sentiment-visualisation/dev-status.svg)](https://david-dm.org/lissy93/twitter-sentiment-visualisation#info=devDependencies)
[![Code Climate](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/badges/gpa.svg)](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation)
[![Maintenance](https://img.shields.io/maintenance/yes/2016.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)
[![Test Coverage](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/badges/coverage.svg)](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/coverage)


[![node](https://img.shields.io/node/v/gh-badges.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)
[![npm](https://img.shields.io/npm/v/npm.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)
[![Bower](https://img.shields.io/bower/v/bootstrap.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)
[![trello](https://img.shields.io/badge/Methodology-Agile-blue.svg)](https://img.shields.io/badge/Methodology-Agile-blue.svg)
[![Stack Share](http://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](http://stackshare.io/Lissy93/sentiment-sweep)
[![npm](https://img.shields.io/npm/l/express.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)
[![Gitter](https://badges.gitter.im/Lissy93/twitter-sentiment-visualisation.svg)](https://gitter.im/Lissy93/twitter-sentiment-visualisation?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![GitHub commits](https://img.shields.io/github/commits-since/SubtitleEdit/subtitleedit/3.4.7.svg)](https://github.com/Lissy93/twitter-sentiment-visualisation)


> A web app that uses data from Twitter combined with sentiment analysis and
> emotion detection to create a series of data visualisations to illustrate
> the happy and less happy locations, topics and times.

## Modules 
Several open sauce node modules have been developed and published on npm as part of this project
- [sentiment-analysis] - useses the AFINN-111 word list to calculate overall sentiment of a sentence
- [fetch-tweets] - fetches tweets from Twitter based on topic, location, timeframe or combination
- [stream-tweets] - streams live Tweets in real-time
- [remove-words] - removes all non-key words from a string sentence
- [place-lookup] - finds the latitude and longitude for any fuzzy place name using the Google Places API 
- [hp-haven-sentiment-analysis] - A Node.js client library for HP Haven OnDemand Sentiment Analysis module
- [tweet-location] - calculates the location from geo-tagged Tweets using the Twitter Geo API
- [find-region-from-location] - given a latitude and longitude calculates which region that point belongs in

## Project Planning 
- A set of [user stories with acceptance criteria] have been drawn up outlining what features the finished solution should have. They are also managed on the [Trello Board]

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

To run the tests: ```npm test``` or see the more [test strategy]


## Automated Development Workflow
> TSV uses the Gulp streaming build tool to automate the development workflow.

The key tasks you need to run are:
- `gulp generate-config` - before first-time running of the project, run this command to generate configuration files for your API keys
- `gulp build` - This will build the project fully, this includes cleaning the working directory and then all tasks that must happen for CoffeeScript, JavaScript, CSS, images, HTML and Browserify tasks.
- `gulp nodemon` - Runs the application on the default port (probably 8080)
- `gulp test` - This will run all unit and coverage tests, printing a summary of the results to the console and generating more detailed reports into the reports directory.
- `gulp` - this is the default task, it will check the project is configured correctly, build ALL the files, run the server, watch for changes, recompile relevant files and reload browsers on change, and keep all browsers in sync, when a test condition changes it will also re-run tests - a lot going on!

To read more about the project setup and gulp process, see [build environment] in the docs


## Test Strategy 
> Twitter Sentiment Visualisation follows the TDD approach and is structured around it's unit tests.

To run tests: `npm test`


**Testing Tools**
- Framework - [Mocha](https://github.com/mochajs/mocha)
- Assertion Library - [Chai](https://github.com/chaijs/chai)
- Coverage Testing - [Istanbul](https://github.com/gotwarlost/istanbul)
- Stubs, Spies and Mocking - [Sinon.js](https://github.com/sinonjs/sinon)
- Continuous Integration Testing - [Travis CI](https://github.com/travis-ci/travis-ci)
- Dependency Checking - [David](https://github.com/alanshaw/david)
- Automated Code Review's - [Code Climate](https://github.com/codeclimate/codeclimate)
- Headless Browser Testing � [PhantomJS](https://github.com/ariya/phantomjs)
- Testing HTTP services - [SuperTest](https://github.com/visionmedia/supertest)

More details on each of the tools and how they will be implemented along 
with the pass and fail criteria can be found on the [test strategy] page 
of the documentation.

## Documentation
### Project Planning
[User Stories](docs/user-stories.md)

[High Level UML](docs/)

[Methodology](docs/)

[Test Strategy](docs/test-strategy.md)

### Development Documentation

[Installation Instructions](docs/installation-instructions.md)

[Build Environment](docs/build-environment.md)

[Testing](docs/test-strategy.md)

   [Trello Board]: <https://trello.com/b/jWBg1vd1/twitter-sentiment-visualisation>
   [Node.js]: <https://nodejs.org/en/>
   [MongoDB]: <https://www.mongodb.org/>
   [git]: <https://git-scm.com/>
   [Starting a MongoDB instance]: <http://docs.mongodb.org/master/tutorial/getting-started-with-the-mongo-shell/>
   [http://localhost:8080]: <http://localhost:8080>
   [detailed installation instructions]: <docs/installation-instructions.md>
   [test strategy]: <docs/test-strategy.md>
   [build environment]: <docs/build-environment.md>
   [user stories with acceptance criteria]: <docs/user-stories.md>
   
   [fetch-tweets]: <https://www.npmjs.com/package/fetch-tweets>
   [stream-tweets]: <https://www.npmjs.com/package/stream-tweets>
   [place-lookup]: <https://github.com/Lissy93/place-lookup>
   [tweet-location]: <https://www.npmjs.com/package/tweet-location>
   [remove-words]: <https://www.npmjs.com/package/remove-words>
   [sentiment-analysis]: <https://www.npmjs.com/package/sentiment-analysis>
   [hp-haven-sentiment-analysis]: <https://github.com/Lissy93/haven-sentiment-analysis>
   [find-region-from-location]: <https://github.com/Lissy93/find-region-from-location>

