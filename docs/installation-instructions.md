# Running TSV Locally 

## Prerequisites
Since this is a Node application you'll need Node.js installed on your system. Download it from here http://nodejs.org and follow the steps to install.

TSV also needs to be connected to a database in order to cache Tweets. For this you will need to install MongoDB, this can be downloaded from https://www.mongodb.org/ and again just follow the installation set up.

Finally, if you wish to clone the git repository directly, you will also need git installed. You can get the latest version of git from: https://git-scm.com/downloads 

Once Node is installed run the following command:
```npm install gulp -g``` and also ```npm install bower -g``` . This will install gulp and bower globally on your system, meaning they can be used directly as commands. The gulp build tool is required to build the project, and Bower is a frontend package manager needed to download all frontend libraries and frameworks.

## Getting the files
If you have git installed (try running ```git --version``` to see if you do). Then you can clone the repository directly with this command:

```git clone https://github.com/Lissy93/twitter- sentiment-visualisation.git```

Once you've done that you should have a new folder called `twitter-sentiment-visualisations`, navigate into that directory with the commend `cd twitter-sentiment-visualisation`

## Install Dependencies 
The backend dependencies can be installed using the npm package manager, run: `npm install` to download them into the node_modules directory. 

The frontend dependencies need to be downloaded with Bower. Run `bower install` in the same way to save the frontend libraries and frameworks to the bower_components directory.

## Configuring
Since the application requires access to a few API's to function, you need to provide it with your API keys. See the links at the bottom for where you can obtain all the necessary keys.

Run: `npm run config` to generate a JSON file for you to paste your keys into. If your on Windows, then this file should open automatically after running the command, (if not then just open `config\src\keys.coffee`) then just populate it with your stuff then save and close. 

You may also want to check the variables set in `config/src/app-config.coffee` which would have been set with predicted defaults, such as MongoDB path, default port and other key bits of data.

To get your developer API keys, you will need to sign up for free, at the following URL's:

- **HP Haven OnDemand**: http://www.havenondemand.com/login.html?signUp=true
- **IBM Watson**: https://www.ibm.com/account/us-en/signup/register.html?Target=https://myibm.ibm.com/
- **Google Developer**: https://console.developers.google.com/apis/dashboard
- **Twitter Developer**: https://dev.twitter.com/resources/signup


## Building
Since the majority of the code is written in CoffeeScript or other languages that need to be compiled or bundled, the project must be built before it can be run. You can read more about the build process in the build document.

Run `npm run build` to build the project


## Start the Database
One final step which must be done before the project can be run, is staring MongoDB.
Have a look at the guide on the official MongoDB page for how to start MongoDB: http://docs.mongodb.org/master/tutorial/getting-started-with-the-mongo-shell/

You will need to start MongoDb in a separate window, for Windows you can do something like this: `cd C:\Program Files\MongoDB\Server\3.0\bin` and then `mongod --dbpath C:\Users\YOUR_NAME\Documents\mongodb`


## Running
Now that everything is set up and working, we can run the project! 

Ensure the MongoDb instance is still open in another command line windows, and run the following in the TSV directory: `npm start`


Then in your web browser head over to:  http://localhost:8080


## Summary
Install Node.js, MongoDB and git. Then run the following commands in series, modifying where necessary.
```
npm install gulp bower -g   # Install Gulp and Bower global
git clone https://github.com/Lissy93/twitter- sentiment-visualisation.git # Clone the repo
cd twitter-sentiment-visualisation # Navigate into the directory
npm install # Download node module dependencies 
bower install # Download frontend libraries and frameworks
npm run config # Generate configuration files
## enter your API keys in config\src\keys.coffee
npm run build # Build the project 
## Start MongoDb in a new terminal window
npm start # Run the project
## Open your web browser and navigate to:  http://localhost:8080

```
