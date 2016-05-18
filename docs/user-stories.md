# User Stories and Acceptance Criteria
## Main Programme
> User stories relating to the program in general

[View complexity estimates for each story here](story-points.md)

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
-	AC1 � There should be as few requests as physically possible
-	AC2 � Only data that is going to be uses should be requested where possible
-	AC3 � If a data request takes more than 4 seconds it should time out and a backup data source used or show appropriate error message

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
-	AC1 All unnecessary data, such as URL�s, pictures and additional handles will be removed
-	AC2 All special characters will be escaped 
-	AC3 The maximum length per Tweet will be cut to 145 characters

**TSV-G035 As a system I should use both the cached and live data in conjunction or depending on user selection**
-	AC1 If the user has searches for a location or hashtag, while it is loading database data will be displayed, and the map will then update according to new Tweets





## Home Screen
> Stories relating to the initial landing page of the application

**TSV-H037 As a user I should find the start page clear and concise**
-	AC1 It will not contain more information than necessary 
-	AC2 It will give a very brief overview about what the application is, and what it can be used for

**TSV-H038 As a user I can make a search directly from the home page**
-	AC1 There will be a search field to enter a keyword or topic
-	AC2 The user will be redirected to the search results page to display the findings
-	AC3 It should be clear to the user where to search and what to enter

**TSV-H039 As a user I can navigate to any other part of the application directly from the home screen**
-	AC1 There will be a link to each section of the website, including all 10 data visualisations
-	AC2 There will also be a link to the `about` page and the source code and documentation



## Regional Map Screen
> Stories relating to the regional map front-end

** TSV-I040 - As a user I should be able to get an immediate overview of results**
-	AC1 Should show geographical sentiment towards a specified topic
-	AC2 Each region should be a single colour, with no gradients
-	AC3 A region should be clickable 
-	AC4 When user hovers or clicks a region, they should be able to view numeric results

**TSV-I041 – As a user I should be able search for a specific search term**
-	AC1 There must be an input box
-	AC2 Results must then be rendered according to the value of the search field
TSV-I042 – As a user I should be able to see a list of most positive and negative regions
-	AC1 After the user has entered their topic and the map has been rendered, a bullet point list of the most positive regions, and most negative regions towards the specified topic.
-	AC2 Items in the list must display a sentiment value in percentage form
-	AC3 Items in the list should be clickable


## Trending Screen
> Stories relating to the trending topics front-end

**TSV-J043 - As a user I should be able see what is currently trending worldwide**
-	AC1 A list of the top ten trends worldwide will be shown
-	AC2 The sentiment of each will be indicated by colour
-	AC3 The list will be sorted by volume of tweets, with the most popular trends at the top

**TSV-J044 – As a user I should be able to enter a custom location to view local trends**
-	AC1 - An input filed will be provided for the user to enter a location
-	AC2 The user should be able to enter any place e.g. ‘OX3 0BP’, ’14 Greys Road’, ‘California’, ‘Europe’. The Google Places API will then be used to find the latitude and longitude of the given string.
-	AC3 The trends displayed should be specific to the users location

**TSV-J045 – As a user I can click a trend to find out more**
-	AC1 The user should be able to click any trend and be redirected to the search page
-	AC2 It should be clear to the user the trends are clickable 
-	AC3 Trends in the bubble chart (see below) will also be clickable 

**TSV-J046 – As a user I can view trends visually, to get an overview of volume and sentiment**
-	AC1 There will be a bubble diagram below the list of trends
-	AC2 The diagram will show one bubble for each trend
-	AC3 The size of the bubble will represent the volume of tweets for that trend
-	AC4 The colour of each bubble will indicate sentiment
-	AC5 The bubble will be clickable to gain more information about a given trend



## Text Tweets Screen
> Stories for the front-end of the text tweets screen, which shows displays raw tweets

**TSV-K047 – As a user I should be able to read the plain text tweets relating to a chosen topic/ word**
-	AC1 There must be a search field for the user to enter their topic or keyword into
-	AC2 Once they press enter fresh data should be fetched and rendered
-	AC3 Tweets should be laid out in a clear and concise manor

**TSV-K048 – As a user I should be able to quickly pick out the key information while reading**
-	AC1 Positive and negative tweets should be in separate columns
-	AC2 Each tweet should have their keywords in bold, to make scan reading easier
-	AC3 The sentiment, date/time and location of each tweet should be displayed

**TSV-K049 – As a user I should see new tweets come in in real-time**
-	AC1 – The user shouldn’t have to refresh page to see new data


## Word Cloud
>Stories for the front-end of the word cloud screen

**TSV-L050 – As a user I can see a word cloud after entering my search term**
-	AC1 Words should vary in size depending on number of times used
-	AC2 Sentiment should be represented by the shade of colour, red = negative, green = positive, grey = neutral and all colours in between show sentiment in between

**TSV-L051 – As a user I can see a text list of the top words used in positive and negative tweets**
-	AC1 There should be two lists, one for top words used in positive tweets, the other negative
-	AC2 Each word should have an average sentiment value for associated tweets, in percentage
-	AC3 Each word should be followed by a number, of how many times it occurred in that set
-	AC4 The words should be clickable to view more 



## Word Scatter Plot
> Stories for the front-end of the word scatter plot screen

**TSV-M052 – As a user I can view the scatter plot for a given search term/ keyword**
-	AC1 Sentiment should be displayed along the y-axis
-	AC2 Frequency along the x-axis
-	AC3 The colour of the points should also be relative to the sentiment

**TSV-M053 – As a user I can hover over a point to view the associated key word**
-	AC1 The word should be displayed as a tooltip
-	AC2 The current point should slightly change colour/ size to make clear which one it is
-	AC3 The user should also be able to click a point to search for that word


## 3D Sentiment Globe
> Stories for the front-end of the 3D sentiment globe

**TSV-N054 – As a user I can interact with the globe**
-	AC1 The user should be able to rotate the globe
-	AC2 The user should be able to zoom in and out of the globe

**TSV-N055 – As a user I can see sentiment for each location (that has Twitter) on the globe**
-	AC1 There should be vertical bars for each settlement with Twitter
-	AC2 The colour of the bar will represent sentiment
-	AC3 The height of the bar will represent scale of sentiment and volume of tweets

**TSV-N056 – As a user I can view statistics of the data shown on the globe**
-	AC1 Including number of tweets displayed and average sentiment
-	AC2 There will also be links to view the same data in other forms



## Timeline
> User stories relating to the sentiment over time-of-day visualisation

**TSV-O057 – As a user I can see both positive and negative sentiment over the past 24 hours**
-	AC1 The positive sentiment will be represented by a green line and shaded area
-	AC2 The negative sentiment will be represented by a red line and shaded area
**TSV-O058 – As a user I can interact with the map and the axis**
-	AC1 The user should be able to hover over the line to see the sentiment at a given time
-	AC2 The user should be able to hover over the line to see time for a given sentiment value



## Comparison
> User stories relating to the topic comparison page

**TSV-P059 – As a user I can enter between one and four search terms**
-	AC1 The screen will be divided into the number of search terms entered 
-	AC2 The user should not be able to enter over four topics, or zero topics

**TSV-P060 – As a user I can see the overall sentiment for each of my search terms**
-	AC1 this should be displayed in the form of a donut chart for each topic
-	AC2 the chart should be labelled, and the user can hover over it to get more details

**TSV-P061 – As a user I can see most commonly used words and their sentiment for each topic**
-	AC1 the top ten words will be displayed
-	AC2 the words will be coloured according to sentiment
-	AC3 the words will be clickable 

**TSV-P062 – As a user I can view links to the other data visualisations for each of the topics**


## Tone Identification
> User stories relating to screen that identifies tone of language of tweets

**TSV-Q063 – As a user I can view a summary of the key tones identified for a topic**
-	AC1 these should be displayed in the form of no more than 12 mini bars on a chart
-	AC2 the user should be able to hover over a bar to get a more accurate percentage value

**TSV-Q64 – As a user I can see a more detailed breakdown in the form of a segmented radar chart**


## Entity Extraction
> User stories relating to the screen that displays the entity extraction results

**TSV-R065 – As a user I can view the key entities extracted from a set of tweets**
-	AC1 Entities should be grouped into categories
-	AC2 The first few matches for each entity should be displayed
-	AC3 Where possible an image should be shown for each entity, pulled from Wikipedia

**TSV-R066 – As a user I can see what volume of each entity and category visually on a Sankey chart**



## Search Screen
> User stories relating the search results screen

**TSV-S067 – As a user I can make a search**
-	AC1 Either from the homepage, initial search page or search results page

**TSV-S068 – As a user I can get a quick overview of the average sentiment of my topic**
-	AC1 A gauge should show average sentiment
-	AC2 A hexagon mesh should give a quick overview of sentiment of individual tweets

**TSV-S069 – As a user I can see which keywords are most commonly used in the twitter results**
-	AC1 Should be listed in order of volume of use
-	AC2 Should be highlighted according to sentiment
-	AC3 Should be clickable 

**TSV-S070 – As a user I can see a summary of the tones identified** 
-	AC1 Each tone identified and the percentage certainty should be displayed
-	AC2 Displayed in the form of bars
-	AC3 User should be able to hover to see exact percent
-	AC4 There should be a see more button, directing the user to the tone identification page

**TSV-S071 – As a user I can see a summary of the entities extracted**
-	AC1 the top six categories for that topic should be displayed
-	AC2 the entities in each six categories should be shown
-	AC3 if the user hovers over an entity they should be able to see number of occurrences
-	AC4 the entities should be clickable
-	AC5 if the system has found an associated Wikipedia image for the entity, it should be displayed
-	AC6 there should be a read more button to find and display more entities on the entity screen

**TSV-S072 – As a user I can see how my topic compares to the rest of Twitter**
-	AC1 Should be displayed as a donut chart
-	AC2 There should be three input fields to enter more topics to compare with search term
-	AC3 Should provide a link to the comparison screen

**TSV-S073 – As a user I can read a set of tweets relating to my topic**
-	AC1 The top five positive tweets should be shown in one column
-	AC2 The top five negative tweets should be shown in another column
-	AC3 There should be a load more button, to show more tweets from topic
-	AC4 The sentiment for each tweet should be shown
-	AC5 The location (if applicable) for each tweet should be shown as small grey text
-	AC6 The time tweets should be displayed in a readable form in small grey text
-	AC7 The keywords of each tweet should be highlighted in bold, and clickable

**TSV-S074 – As a user I can view more results for my search term on each data visualisation**
-	AC1 A thumbnail with image for each applicable data visualisation should be shown
-	AC2 Each page will show relevant results to that search term

