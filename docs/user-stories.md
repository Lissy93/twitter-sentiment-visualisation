# User Stories and Acceptance Criteria
## Main Programme
> User stories relating to the program in general

**TSV-A001 As a user I should be able to view the solution in my browser simply by visiting a URL**
-	AC1 There will be no login, start screen or any other pages to navigate through before being presented with the solution
-	AC2 The URL will use the http protocol
-	AC3 The web page must be compatible with modern browsers including Chrome, Firefox and Safari
-	AC4 The web page must be indexed and crawlable by search engines

**TSV-A002 As a user I should have fast loading times or be displayed with a loading graphic**
-	AC1 The initial page should load in under 1 second
-	AC2 A loading animation should be displayed for anything that takes more than 1 second 
-	AC3 Where possible loading status should be displayed
-	AC4 The visualisation should be displayed as soon as there is sufficient data loaded

**TSV-A003 As a user I should be able to easily switch between different parts of the application**
-	AC1 There should be several clear buttons visible at the top of the page
-	AC2 The user should only have to click once to change view
-	AC3 If data needs to be loaded then a suitable loading graphic should be displayed 

**TSV-A004 As a user I should find the user interface clear and simple to look at**
-	AC1 The visualisation should be full screen with the only other component on the screen being the navigation bar at the top
-	AC2 There should be no unnecessary information displayed by default
	
## Map
> User stories relating to the displaying and functionality of the map

**TSV-B005 As a user I should be able to view the map**
-	AC1 The map will be shown by default
-	AC2 The map will display consistently in all modern browsers

**TSV-B006 As a user I should be able to pan (move the map with pointing device) and zoom (with both control buttons and hardware such as mouse wheel)**
-	AC1 There will be a maximum and minimum field of view defined for zoom
-	AC2 The user will be able to use their default pointing device to navigate the map

**TSV-B007 As a user I should be able to search for a specific location**
-	AC1 The search box will be clear and located at the top of the screen
-	AC2 The search box will have a placeholder text clearly indicating what should be entered
-	AC3 The search box will have autocomplete using Google Places. When the user starts typing a dropdown of matching places will be displayed similar to that on the Google.com map
-	AC4 The user should be able to search by postcode, address, place name, area, district or latitude & longitude

**TSV-B008 As a user I should find the map clear and neat to look at.**
-	AC1 The map should be pale-greyscale color 
-	AC2 The map should only have labels for significant place names
-	AC3 More places should be displayed as the user zooms in, and the detail decreased when the user zooms out


## Heat Map
> User stories relating to the heat map overlay

**TSV-C009 As a user I should be able to see the heat map over the top of the standard map**
-	AC1 The heat map should not affect the functionality of the underlying map
-	AC2 The heat map overlay should be semi-transparent to show the map underneath	

**TSV-C010 As a user I should be able to toggle the display of the heat map to show and hide it**
-	AC1 The toggle button should display as a simple switch
-	AC2 The overlay should disappear and reappear instantly

**TSV-C011 As a user I should be able to adjust the opacity of the heat map with a simple slider**
-	AC1 The opacity should range from 0 to 1
-	AC2 There should be no lag

**TSV-C012 As a system I should bind data to the heat map**
-	AC1 The data source the heat map reads from should be what is outputted by the backend system

**TSV-C013 As a system I should be able to bind additional data to the map to update it after the initial heat map has already been rendered**
-	AC1 The system should be constantly looking for changes in the database
-	AC2 The system should be constantly waiting for new updates from the Twitter module
-	AC3 The updates should be seamless with no visible loading or lag

**TSV-C014 As a user I should find the colors of the heat map clearly represent the data it is displaying**
-	AC1 There should be a legend indicating what color is what

## Sentiment Analysis
> User stories relating to the detaction of sentiment in Tweets

**TSV-D015 As a system I should be able to identify weather a string is positive, neutral or negative overall**
-	AC1 A request should be sent containing a string
-	AC2 The string will be sent to relevant API 
-	AC3 A response will be returned from the API and processed by the module

**TSV-D016 As a system I should be able to identify weather the attitude towards a certain specified topic is positive, neutral or negative**
-	AC1 An additional parameter containing the keyword needs to be passed in
-	AC2 The response must be relevant to that keyword

**TSV-D017 As a system I should be able to give a confidence estimate showing how likely it is that the sentiment value is accurate**
-	AC1 This should be expressed as a decimal between 0 and 1
-	AC2 This is generated by the API

**TSV-D018 As a system I should be able to return emotion analysis results for a given string**
-	AC1 The system should return the list of emotions, each with a decimal value between 0 and 1 indicating how much of that emotion was detected 
-	AC2 If none of an emotion is found it will return 0

**TSV-D019 As a system the load time for fetching results should be sufficiently fast**
-	AC1 Load time must be under 1 second
-	AC2 On the frontend suitable load animations should be displayed

**TSV-D020 As a system I should give a suitable response and error code if no result is available**
-	AC1 The right error code should be returned
-	AC2 All result fields should be returned just with empty values 

## Fetching Tweets
> User stories relating to the fetching and streaming of Tweets from the Twitter API

**TSV-E021 As a system I should be able to fetch a specified number of Tweets from around a given location from the Twitter API**
-	AC1 The given location must be converted to a suitable unit
-	AC2 Only tweets from around that location should be displayed
-	AC3 Results must be in JSON format
-	AC4 Calls must be made asyncrously 

**TSV-E022 As a system I should be able to fetch a specified number of Tweets talking about a specific topic, hashtag or keyword from the Twitter API**
-	AC1 The keyword should be between 2 and 25 characters long and stripped of all special characters
-	AC2 Only Tweets containing the given keyword should be returned
-	AC3 Results must be in JSON format
-	AC4 Calls must be made asyncrously 

**TSV-E023 As a system I should have reasonable response times in fetching Tweets from the Twitter API**
-	AC1 – There should be as few requests as physically possible
-	AC2 – Only data that is going to be uses should be requested where possible
-	AC3 – If a data request takes more than 4 seconds it should time out and a backup data source used or show appropriate error message

**TSV-E024 As a system I should respond with a suitable error if there is a problem fetching Tweets from the Twitter API**
-	AC1 An error code and clear message should be displayed
-	AC2 There should be a troubleshooting section with a brief description and possible resolution of each error message and code

**TSV-E025 As a system I should be able to create a series of Tweet objects for the next stage**
-	AC1 Each Tweet object should follow the data structure outlined in the data structures section
-	AC2 The sentiment value should be left blank at this stage

## Displaying Results
> Bringing together the map, heat map, sentiment analysis and Tweets

**TSV-F026 As a user I should be able to see the heat map bound to data to display results**
-	AC1 The heat map created will use the data fetched from the sentiment analysis module

**TSV-F027 As a user I should be able to search for a keyword and location to see the heat map for just that topic**
-	AC1 The map view must update if a location is searched for
-	AC2 If a specific location is searched for fresh tweets will be fetched
-	AC3 Twitter results will be added to the map as they come on, rather than waiting for the whole batch to finish first
-	AC4 If a keyword is searched, only tweets resulting to that keyword will be displayed 

**TSV-F027 As a user I should be able to hover over specific areas of interest and see what is trending or causing that particular heat patch**
-	AC1 Once the users mouse has been still for more than 0.4 seconds a tooltip will display
-	AC2 The tooltip can be clicked for further details
-	AC3 The expanded tooltip will show a list of trending hashtags around the place of interest
-	AC4 If a hashtag is clicked then the map will update to show just the attitudes towards that hashtag

**TSV-F028 As a system I should be displaying data both from the database and live Tweets**
-	AC1 The system must be able to watch for changes on Twitter
-	AC2 The system must be able to trigger a call when there is a change
-	AC3 The call must fetch the tweet and process it
-	AC4 The UI must be updated without a complete re-render

**TSV-F029 As a system I should be able to load fast and display suitable loading graphic when loading times are more than 1 second**
-	AC1 A turning animation will be displayed for any loads more than 1 second
-	AC2 Where possible the load status will be displayed
-	AC3 The loading will time out if any one task takes more than 4 seconds to complete. A suitable error will be shown.

## Caching 
> Stories relating to the data caching and database

**TSV-G030 As a system I should be able to write to the database asyncrously** 
-	AC1 The system will be able to write JSON data following a schema to the database
-	AC2 The system will be able to write data while it is doing other tasks
-	AC3 The writing to the database will not hold up or block any other threads

**TSV-G031 As a system I should be able to read from the database asyncrously** 
-	AC1 The system will be able to read JSON data following a schema from the database
-	AC2 The system will be able to read data while it is doing other tasks
-	AC3 The reading from the database will not hold up or block any other threads

**TSV-G032 As a system I should be able to query the database for just relevant Tweets**
-	AC1 Parameters including keywords, handle, location, time should all be able to be queried

**TSV-G033 As a system I should delete the oldest entries when there reaches a certain number of records**
-	AC1 research the optimum number of Tweets to store in the database based on efficient rendering of the map and enough detail to make the basic visualisation effective
-	AC2 When the number of Tweets reaches this number start to delete older Tweets whenever a new one is inserted 

**TSV-G034 As a system I should be able to check and make safe data before inserting** 
-	AC1 All unnecessary data, such as URL’s, pictures and additional handles will be removed
-	AC2 All special characters will be escaped 
-	AC3 The maximum length per Tweet will be cut to 145 characters

**TSV-G035 As a system I should use both the cached and live data in conjunction or depending on user selection**
-	AC1 If the user has searches for a location or hashtag, while it is loading database data will be displayed, and the map will then update according to new Tweets
