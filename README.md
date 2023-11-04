<h1 align="center">🌍 Twitter Sentiment Visualisations</h1>
<p align="center">
 <i>Visualising sentiment trends from real-time social media data</i><br>
 <b><a href="https://sentiment-sweep.com/">sentiment-sweep.com</a></b>
</p>
<p align="center">
  <a href="https://sentiment-sweep.com/about">
    <img width="800" src="https://i.ibb.co/W0f10Vv/sentiment-sweep-grid.png" />
  </a>
</p>

### Contents

- [About](#about)
- [Demo](#demo)
- [Build Instructions](#building)
   - [Developing](#developing)
   - [Deploying](#deploying)
   - [Testing](#testing)
- [Modules](#modules)
- [Project Info](#project-info)
- [Documentation](#documentation)
- [License](#license)


## About

#### What
A project to make large quantities of social media data more understandable.

#### How
The app that streams live social media data, and runs it through a custom sentiment analysis algorithm, to determine trends which are then visualised with a series of dynamic real-time charts.

#### Why
The aim of the app is to allow trends to be found between sentiment and other factors such as geographical location, time of day, demographics, similar topics, etc.

It has a range of uses, like analysing the effectiveness of a marketing campaign, comparing competing products, viewing local trends, gauging public opinion by location, determining best time of day to advertise to certain audiences, etc.

#### Where
A live demo is available at: [http://sentiment-sweep.com](http://sentiment-sweep.com)

#### When
This project was initially developed in 2015.
Some of the technologies used are a little out-dated now, although the app still works great.
A few of the external services that were used to provide additional context (like HP Idol on Demand, and IBM Watson, and certain GCP features) have been discontinued, meaning certain features may now be unavailible on the live instance.

---

## Building


#### Developing

> See the [Dev Setup](/docs/installation-instructions.md) docs for local dev setup.

1. **Prerequisites** - You will need [Node.js], [MongoDB] and [git]  installed on
your system.
2. **Get the files** - `git clone https://github.com/Lissy93/twitter-sentiment-visualisation.git tsv` then `cd tsv`
3. **Install dependencies** -  `npm i` / `yarn` will download requirements into node_modules, then automatically kick off a `bower install` for frontend libraries
4. **Set Config** - `yarn run config`  will generate the `config\src\keys.coffee` file, which you will then need to populate with your API keys and save. 5. **Apply Settings** - Check that your happy with the general app config in `config/src/app-config.coffee`
6. **Build Project** - `yarn build` will compile the project from the source, outputting files into dist ready to be published
7. **Start MongoDB** - `mongod` will start a [MongoDB] instance (run in separate terminal instance, see instructions: [Starting a MongoDB instance])
8. **Run the project** - `yarn dev` will build, start the dev server, with live-reload and auto-testing
9. **Open Browser** - Navigate to the specified port, to view running app, e.g. [http://localhost:8080]

#### Deploying

> See the [Prod Deployment(/docs/build-environment.md) docs for more info.

Follow the instructions above, then
1. **Execute Tests** - `yarn test` Ensure all tests pass and everything is working as expected 
2. **Build for Prod** - `yarn build` Compile all source files to the dist directory
3. **Start Server** - `yarn start` Spin up HTTP server to start API and serve up compiled files

#### Testing

> See the [Test Strategy] Docs for more info.<br>
> TSV is fully unit tested, and follows a BHD pattern. Unit, integration, coverage and depencency tests can be run using `yarn test`.

<details>
 <summary>Pass/ Fail Criteria</summary>
 
| Test Type          | Pass Condition                                                                          |
|--------------------|-----------------------------------------------------------------------------------------|
| Functional Testing | All acceptance criteria must be met, checked and documented                             |
| Unit Tests         | 100% of unit tests must pass. It will be immediately clear when a unit test is failing  |
| Integration Tests  | 100% pass rate after every commit                                                       |
| Coverage Tests     | 80% or greater                                                                          |
| Code Reviews       | B grade/ Level 4 or higher. Ideally A grade/ Level 5 if possible.                       |
| Dependency Checks  | Mostly up-to-date dependencies except in justified circumstances.                       |

 
</details>


<details>
 <summary>Testing Tool</summary>
 
- Framework - [Mocha](https://github.com/mochajs/mocha)
  - Used in order to store, write and run the tests in a structured way
- Assertion Library - [Chai](https://github.com/chaijs/chai)
  - Provides a structure and syntax in order to actually write the test cases
- Coverage Testing - [Istanbul](https://github.com/gotwarlost/istanbul)
  - Measures the proportion of your source code that is covered by your unit tests
- Stubs, Spies and Mocking - [Sinon.js](https://github.com/sinonjs/sinon)
  - Mocking removes the need to call production APIs while running frontend unit tests
- Continuous Integration Testing - [Travis CI](https://github.com/travis-ci/travis-ci)
  - Ensures that all the standalone modules function correctly when put together
- Dependency Checking - [David](https://github.com/alanshaw/david)
  - Checks that each dependency is present, correct, secure and functional
- Automated Code Review's - [Code Climate](https://github.com/codeclimate/codeclimate)
  - Scans for best practices, and fails in any part of the code could be improved upon
- Headless Browser Testing - [PhantomJS](https://github.com/ariya/phantomjs)
  - Runs frontend tests without the need for a GUI browser
- Testing HTTP services - [SuperTest](https://github.com/visionmedia/supertest)
  - Tests API endpoints and ensures routing is working correctly

</details> 

#### Automated Workflows
 
> TSV uses the Gulp streaming build tool to automate the prod and dev workflows. For more info, see the [Build Environment] docs.

The following tasks are useful for getting started:
- `gulp generate-config` - Generates correctly structured default configuration files for settings and API keys
- `gulp build` - Builds the project fully, including optimization, compilation, minification and validation
- `gulp nodemon` - Runs the application on the default port (probably 8080), with live refresh
- `gulp test` - Executes all unit and coverage tests, and generates a report containing the results
- `gulp` - Default dev task - check the project is configured correctly, build ALL the files, run the server, watch for changes, recompile relevant files and reload browsers on change, and keep all browsers in sync, when a test condition changes it will also re-run tests - a lot going on!

---

## Modules

The project was developed in a modular approach, made up of several distinct components.
Each is published as a fully tested, documented and MIT-licensed NPM module for easy re-use.

- [sentiment-analysis] - Useses AFINN-111 approach to calculate overall sentiment of a given sentence
- [fetch-tweets] - Fetches tweets from Twitter based on topic, location, timeframe or combination
- [stream-tweets] - Streams live Twitter data in real-time, based on location, given term, etc
- [remove-words] - Removes all non-key words from a given string
- [place-lookup] - Finds the latitude and longitude for any fuzzy place name using the Google Places API
- [hp-haven-sentiment-analysis] - A Node.js client library for HP Haven OnDemand Sentiment Analysis module
- [haven-entity-extraction] - Node.js client for HP Haven OnDemand Entity Extraction
- [tweet-location] - Calculates the location from geo-tagged Tweets using the Twitter Geo API
- [find-region-from-location] - Given a latitude and longitude calculates which region that point belongs in

---

## Project Info

#### Project Planning

A set of [User Stories with Acceptance Criteria] and [Complexity Estimates](docs/story-points.md) were drawn up outlining what features the finished solution should have. These were expaned upon further with wireframes in the [Methodology](https://github.com/Lissy93/twitter-sentiment-visualisation/blob/dev/docs/methodology-frontend.md) section.

#### Technologies

View full tech stack at: [stackshare.io/Lissy93/sentiment-sweep](http://stackshare.io/Lissy93/sentiment-sweep)

The backend is primarily written in Node.js, with web-sockets facilitating the real-time communication with the frontend, and a data cache stored in MongoDB. Pages are rendered isomorphically, with data visualizations written using D3.js. Social data is fetched from Twitter, compute happens locally, and a few external APIs were used to provide additional context in the form of AI. Views are written in Pug, styles in Less, scripts in CoffeeScript and everything is compiled via a Gulp script.

The project and app are still functional, however 5 years on, this would not be an ideal tech stack. There are now better technologies available that would enable greater performance, less code, easier project management and improved developer experience. If I was to re-write this project in 2022, a better tech stack would likely be Go for the backend, Svelte + Svelte Kit for the frontend and TypeScript for the code, with Pixi.js for the interactive content, styled-components for styling and Rollup for putting it all together.

#### Status

[![Build Status](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation.svg?branch=dev)](https://travis-ci.org/Lissy93/twitter-sentiment-visualisation)
[![View on Snyk](https://snyk.io/test/github/lissy93/twitter-sentiment-visualisation/badge.svg)](https://snyk.io/test/github/Lissy93/Twitter-Sentiment-Visualisation)
[![Code Climate](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation/badges/gpa.svg)](https://codeclimate.com/github/Lissy93/twitter-sentiment-visualisation)
![Size](https://img.shields.io/bundlephobia/min/sentiment-analysis)
[![Website](https://img.shields.io/website?down_color=red&down_message=Down&up_color=green&up_message=Online&url=https%3A%2F%2Fsentiment-sweep.com%2F)](https://sentiment-sweep.com/)

#### Demo

A live demo of the application has been deployed to: [http://sentiment-sweep.com](http://sentiment-sweep.com)

View [Screenshots](/docs/screenshots#readme) of each screen in the docs.

[![Screenshots](https://i.ibb.co/873YkwP/sentiemnt-sweep-screenshots.png)](/docs/screenshots#readme)

#### Awards

<a href="https://notes.aliciasykes.com/p/0s5s3uOtKj"><img align="left" width="240" src="https://i.ibb.co/RzcxQGK/profile1.jpg" alt="Alicia Sykes - StartHack Winner" /></a>
<a href="https://oxon.bcs.org/2016/06/27/annual-student-prizes-2016/"><img align="left" width="315" src="https://oxon.bcs.org/wp-content/uploads/2016/06/IMG_0681-768x576.jpg" alt="Alicia Sykes - Oxford Winner" /></a>

The first stages of the project were developed at StartHack Switzerland 2014, where it won first-place. 

It was then further expanded upon, and used as part of my undergraduate thesis, where it won the Oxford BCS best Dissertation Award.

<br><br><br>

The University Project recieved 96%, so feel free to use it as an example - here's the [Final Report](https://www.docdroid.net/x8srrAf/final-report-with-appendix-asykes-12011471-pdf) in PDF format (warning - it's 300 pages!). And the deck used for the technical presentation, us available at: [presentation.sentiment-sweep.com](https://presentation.sentiment-sweep.com/#/)

---

## Documentation

- **Development Documentation**
  - [Installation Instructions](docs/installation-instructions.md)
  - [Build Environment](docs/build-environment.md)
  - [Testing](docs/test-strategy.md)
- **Project Information**
  - [Project Introduction](docs/project-introduction.md)
  - [Addressing Potential Risks](docs/project-risks.md)
  - [System Development Life Cycle](docs/sdlc.md)
  - [Licence](docs/LICENSE.md)
- **Project Planning**
  - [User Stories](docs/user-stories.md)
  - [Complexity Estimates](docs/story-points.md)
  - [High Level UML](docs/high-level-data-flow.png)
  - [Methodology - frontend](docs/methodology-frontend.md)
  - [Test Strategy](docs/test-strategy.md)
- **Research**
  - [The current sentiment analysis scene](docs/research-1-sa-current-uses.md)
  - [Comparison of various sentiment analysis algorithm approaches](docs/research-2-sa-comparison.md)
  - [References](docs/references.md)

---

## License

[twitter-sentiment-visualisation](https://github.com/Lissy93/twitter-sentiment-visualisation) was developed by [Alicia Sykes](https://aliciasykes.com), licensed under [MIT](https://git.io/Jew4i) © 2014 - 2022.

<sup>For information, see [TLDR Legal > MIT](https://tldrlegal.com/license/mit-license)</sup>

```
The MIT License (MIT)
Copyright (c) Alicia Sykes <alicia@omg.com> 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sub-license, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included install copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANT ABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

---


<!-- License + Copyright -->
<p  align="center">
  <i>© <a href="https://aliciasykes.com">Alicia Sykes</a> 2015 - 2020</i><br>
  <i>Licensed under <a href="https://gist.github.com/Lissy93/143d2ee01ccc5c052a17">MIT</a></i><br>
  <a href="https://github.com/lissy93"><img src="https://i.ibb.co/4KtpYxb/octocat-clean-mini.png" /></a><br>
  <sup>Thanks for visiting :)</sup>
</p>

<!-- Dinosaur -->
<!-- 
                        . - ~ ~ ~ - .
      ..     _      .-~               ~-.
     //|     \ `..~                      `.
    || |      }  }              /       \  \
(\   \\ \~^..'                 |         }  \
 \`.-~  o      /       }       |        /    \
 (__          |       /        |       /      `.
  `- - ~ ~ -._|      /_ - ~ ~ ^|      /- _      `.
              |     /          |     /     ~-.     ~- _
              |_____|          |_____|         ~ - . _ _~_-_
-->




   [Trello Board]: <https://trello.com/b/jWBg1vd1/twitter-sentiment-visualisation>
   [Node.js]: <https://nodejs.org/en/>
   [MongoDB]: <https://www.mongodb.org/>
   [Yarn]: <https://yarnpkg.com>
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
   [haven-entity-extraction]: <https://github.com/Lissy93/haven-entity-extraction>
   [find-region-from-location]: <https://github.com/Lissy93/find-region-from-location>
