# Twitter Sentiment Visualisations

A web app that uses data from Twitter combined with sentiment analysis and
emotion detection to create a series of data visualisations to illustrate
the happy and less happy locations, topics and times.

## Building Locally
1. **Prerequsites** - You will need [Node.js], [MongoDB] and [git] (download from the links) installed on your system. You will also need Glulp and Bower, which (once node is installed) you can install by running ```npm install gulp bower -g```
2. **Get the files** - Run: ```git clone https://github.com/Lissy93/twitter-sentiment-visualisation.git``` to clone the repo and then ```cd twitter-sentiment-visualisation```  to navigate into the directory.
3. **Install dependancies** -  Run: ```npm install``` to populates the node_modules, and then ```bower install``` which will download the bower_components.
4. **Build Project** - Run ```npm rub build``` to generate the compiled code from the source
5. **Start MongoDB** - In a seperate commnd line window, cd into where MongoDB installed to, e.g. ```cd C:\Program Files\MongoDB\Server\3.0\bin``` then start Mongod with this command: ```mongod --dbpath C:\Users\YOUR_NAME\Documents\mongodb```
6. **Run the project** - Run ```npm start``` then open your browser and navigat to [http://localhost:8080]

View [detailed installation instructions]

To run the tests: ```npm test```


   [Node.js]: <https://nodejs.org/en/>
   [MongoDB]: <https://www.mongodb.org/>
   [git]: <https://git-scm.com/>
   [http://localhost:8080]: <http://localhost:8080>
   [detailed installation instructions]: <docs/installation-instructions.md>



