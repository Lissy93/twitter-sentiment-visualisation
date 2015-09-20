# Twitter Sentiment Visualisations

A web app that uses data from Twitter combined with sentiment analysis and
emotion detection to create a series of data visualisations to illustrate
the happy and less happy locations, topics and times.

## Running Locally
1. **Prerequsites** - You will need [Node.js], [MongoDB] and [git] (download 
from the links) installed on your system. You will also need Glulp and Bower, 
which (once node is installed) you can install by running ```npm install gulp 
bower -g```
2. **Get the files** - Run: ```git clone https://github.com/Lissy93/twitter-
sentiment-visualisation.git``` to clone the repo and then ```cd twitter-sent
iment-visualisation```  to navigate into the directory.
3. **Install dependancies** -  Run: ```npm install``` to populates the node
_modules, and then ```bower install``` which will download the bower_components.
4. **Set Config** Run: ```npm run config``` this will create a new file for your
 API keys, and (if you are using Windows it will open the file automatically). 
 You will need to populate ```config\src\keys.coffee``` with your API keys, and save.
 Also check that your happy with the app config in ```config/src/app-config.coffee```
 change what you need to in this file.
5. **Build Project** - Run ```npm run build``` to generate the compiled code from
 the source
6. **Start MongoDB** - In a seperate commnd line window, cd into where MongoDB i
nstalled to, e.g. ```cd C:\Program Files\MongoDB\Server\3.0\bin``` then start 
Mongod with this command: ```mongod --dbpath C:\Users\YOUR_NAME\Documents\mongodb```
7. **Run the project** - Run ```npm start``` then open your browser and navigat 
to [http://localhost:8080]

View [detailed installation instructions]

To run the tests: ```npm test``` or see the more [detailed testing plan]


   [Node.js]: <https://nodejs.org/en/>
   [MongoDB]: <https://www.mongodb.org/>
   [git]: <https://git-scm.com/>
   [http://localhost:8080]: <http://localhost:8080>
   [detailed installation instructions]: <docs/installation-instructions.md>
   [detailed testing plan]: <docs/methodology-testing.md>


