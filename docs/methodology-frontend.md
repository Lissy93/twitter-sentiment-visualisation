# Methodology – Frontend


## 1.1	DATA SOURCE FOR EACH PAGE
All pages (with the exception of that start screen) will follow the same format in terms of data source. Upon landing on the page, results will be calculated on tweets that are cashed from the backend streaming engine, and up to 60 minutes’ old. The user can then make a search (or add /[search-query] onto the URL). This will fetch a fresh set of tweets, and render the data visualisation based on this new data. This is explained more in the backend section of the methodology.


## 1.2	FRONTEND TECHNOLOGIES
### 1.2.1	D3
The majority of the charts and data visualizations will be coded in D3.js (but written in CoffeeScript). D3 (or Data Driven Documents) is an advanced JavaScript library for manipulating documents based on data. It allows for web elements (such as SVG and HTML) to be bound to data. (See more at https://d3js.org/).
D3 was chosen, because it is focused on binding DOM elements to the data, and is a bare-bones language, meaning the highly customisable documents can be created. Furthermore D3.js is written in JavaScript, and uses a functional style meaning code reuse is seamless. For this project CoffeeScript will be used as opposed to JavaScript, but the same applies.

### 1.2.2	Google Maps 
The sentiment heat map, will make use of the Google Maps and Google Places API.

### 1.2.3	Socket.io
Socket.IO enables real-time bidirectional event-based communication, it will take care of aspects like web sockets, and ensure maximum browser support. Socket.io will be implemented in all data visualizations and charts that require live data to be displayed and updated in real-time.
It is a good choice since it handles graceful degradation to numerous technical alternatives for real-time functionally, and it also handles browser inconsistencies.

### 1.2.4	Materialize 
Materialize is a modern responsive frontend framework, which implements many of the design standards of material design (released by Google at IO/14)


## 1.3	THE HOME SCREEN
### 1.3.1	Introduction
The home screen or lading page will be the first screen the user is presented with when they start using the application. It will be split into two parts, each filling the browser screen. The first will have a very short description of what the application is, to give the user some context and a search box, where they can enter a topic or keyword to get started. The second part of the home screen will have a link to each of the ten data visualizations across the site. 

### 1.3.2	Aims of Screen
The aim of this screen is to provide a starting point to the application. 
-	It should make clear what the app does, and what it can be used for. 
-	It should allow the user to make a search directly.
-	It should provide navigation to all other sections of the application, and be laid out in a clear concise manor.
-	It should not be over-cluttered, but still show some form of data to entice the user to continue exploring the site.

### 1.3.3	User Stories and Acceptance Criteria for Home Screen
TSV-H036 - As a user I should find the start page clear and concise
-	AC1 It will not contain more information than necessary 
-	AC2 It will give a very brief overview about what the application is, and what it can be used for
TSV-H037 - As a user I can make a search directly from the home page
-	AC1 There will be a search field to enter a keyword or topic
-	AC2 The user will be redirected to the search results page to display the findings
-	AC3 It should be clear to the user where to search and what to enter
TSV-H038 - As a user I can navigate to any other part of the application directly from the home screen
-	AC1 There will be a link to each section of the website, including all 10 data visualisations
-	AC2 There will also be a link to the `about` page and the source code and documentation


### 1.3.4	Wireframe Mockups and Description for Home Screen 
Part 1 – Initial landing screen 
![](wireframes/1_Home-page.png)


This will be the initial landing page. As the wireframe illustrates, it’s got three key parts: a short introduction to the application (with a read more button), a search field and a link to scroll down to navigate to any ten of the data visualizations.

Part 2- Links to all other sections of the application

The second part of the homepage displays a thumbnail image for each section of the site as a clickable hyperlink. This should allow the user to easily navigate to any page.



### 1.3.5	Technical Summary and Justification
No fresh data will be fetched as a rest request for the summary visualization on this page. Doing so would limit scalability and slow down load speeds. Instead cached data from the database will be utilized, requiring very little bandwidth, it’s fast and scalable. All cached data is from the last 60 minutes, so isn’t outdated.  It is essential that the starting page loads quickly.

### 1.3.6	Constraints, limitations and risks of screen
The key constraint here will be ensuring optimum page load speeds can be reached without limiting the quality of data. 


## 1.4	SENTIMENT HEAT MAP SCREEN
### 1.4.1	Introduction to heat map
This will be an interactive geographical map, with a dynamic heat map overlay varying in color to indicate which areas are more positive or negative. Sentiment will be calculated either by specific user defined topic or keyword, that they can search, or using the cashed streamed Twitter results from the past 60 minutes.

### 1.4.2	Aims of the heat map screen
-	To give an overview of which parts of the world, a country or a city are more or less positive about a certain topic, or overall
-	To allow the user to zoom in, and drill down to analyses a more specific area and read actual tweets
-	To illustrate real-time regional events, either positive or negative

### 1.4.3	Wireframe Mockups and Description for the Heat Map

![](wireframes/2_heat-map.png)

The wireframe above show’s that the heat map page will a navigation bar running horizontally along the top of the screen, with links to the other sections of the site on the right hand side. This will be the same for many of the other screens.

The flowing block, also running horizontally, will be a search field and a location field. If the user enters a topic or keyword, and presses enter it will trigger the backend process of fetching and calculating fresh results, and then render it on the map below. The location field shall work in a similar way, with the addition of Google Places autocomplete functionality, which will aid the user in selecting their intended location.



### 1.4.4	User Stories and Acceptance Criteria for the Heat Map
TSV-C009 - As a user I should be able to see the heat map over the top of the standard map
-	AC1 The heat map should not affect the functionality of the underlying map
-	AC2 The heat map overlay should be semi-transparent to show the map underneath	
TSV-C010 - As a user I should be able to toggle the display of the heat map to show and hide it
-	AC1 The toggle button should display as a simple switch
-	AC2 The overlay should disappear and reappear instantly
TSV-C011 - As a user I should be able to adjust the opacity of the heat map with a simple slider
-	AC1 The opacity should range from 0 to 1
-	AC2 There should be no lag
TSV-C012 - As a system I should bind data to the heat map
-	AC1 The data source the heat map reads from should be what is outputted by the backend system
TSV-C013 - As a system I should be able to bind additional data to the map to update it after the initial heat map has already been rendered
-	AC1 The system should be constantly looking for changes in the database
-	AC2 The system should be constantly waiting for new updates from the Twitter module
-	AC3 The updates should be seamless with no visible loading or lag
TSV-C014 - As a user I should find the colours of the heat map clearly represent the data it is displaying 
-	AC1 There should be a legend indicating what colour is what


### 1.4.5	Technical Summary and Justification for the Heat Map Screen
The Google Maps API will be utilized to initially render the map, however a custom module will be written and applied to it, so that it’s styling and functionality are appropriate for this application. The heat map layer will be a combination of Google’s native layer package, and a custom D3 module. An invisible cluster map layer will provide the click functionality and option windows will display clicked tweets. The Google Places API will be used to fetch place data via an AJAX call when the user is typing their desired location, this will be combined with a jQuery autocomplete plugin.

### 1.4.6	Constraints, limitations and risks of the Heat Map Screen
With some search terms, the results will be very densely populated in one geographic area, but could be very sparse in another. Since heat maps usually vary in opacity depending on the number of results, the sparser areas could become almost invisible, and work will need to be done to ensure that doesn’t happen.

It may also become a problem when some areas have a large mix of both very positive and very negative sentiments, as it needs to be clear what causes each, and what the overall result is.


## 1.5	THE REGIONAL SENTIMENT MAP SCREEN

### 1.5.1	Introduction to the Regional Map
The heat map (on previous page) provides a very detailed approach to analyzing individual areas, and what’s causing each sentiment. However often it may be necessary just to gain a quick overview of which regions your search term (e.g. brand, marketing campaign, sports team, political candidate) are positive, and which regions are negative. This is the purpose of the regional map.

### 1.5.2	Aims of the Regional Map
-	Provide a geographical snapshot of sentiment towards a given keyword
-	Simple to look at
-	List most and least positive regions
-	Links for drilling down to gain more details, but not actually displaying details on this screen

### 1.5.3	User Stories and Acceptance Criteria for the Regional Map Screen
TSV-I039 - As a user I should be able to get an immediate overview of results
-	AC1 Should show geographical sentiment towards a specified topic
-	AC2 Each region should be a single colour, with no gradients
-	AC3 A region should be clickable 
-	AC4 When user hovers or clicks a region, they should be able to view numeric results
TSV-I040 – As a user I should be able search for a specific search term
-	AC1 There must be an input box
-	AC2 Results must then be rendered according to the value of the search field
TSV-I041 – As a user I should be able to see a list of most positive and negative regions
-	AC1 After the user has entered their topic and the map has been rendered, a bullet point list of the most positive regions, and most negative regions towards the specified topic.
-	AC2 Items in the list must display a sentiment value in percentage form
-	AC3 Items in the list should be clickable

### 1.5.4	Wireframe Mockups and Description for the Regional Map Screen

![](wireframes/3_region-map.png)

As the mockup shows, the navigation bar is the same as on the other screens. There are two input fields where the user can enter either a topic, or a region. Preceding that is the regional map- it should be noted that this is not a detailed map like the one on the heat map page. The map will show regions, where sentiment is represented by a solid color. It will be possible for the user to hover over a region to view more information. Below the map there will be two lists. The first list will show the top ten most positive regions for the users search term, and the second list will be top ten most negative regions. Again the items in the list will be clickable, and will also show sentiment value as a percentage.

### 1.5.5	Technical Summary and Justification for the Regional Map Screen
The map will be generated in D3.js. The location search will have a custom written autocomplete that translates a location entered by the user into a valid region code or latitude and longitude on the client side.

### 1.5.6	Constraints, limitations and risks of the Regional Map Screen
The regional map screen will show a much less detailed version of the map. If a certain region is large, and has a lot of twitter results, then it might be possible that the overall sentiment value is less accurate, because for example people on the East of the region may have the opposite opinion to those on the West, however all these results will be blurred. 


## 1.6	THE TRENDING SCREEN

### 1.6.1	Introduction to the Trending Screen
This screen shows the keywords, hashtags and users that are currently trending on Twitter at that time. It also shows the volume of tweets for each trend, and calculates and displays the overall sentiment.

### 1.6.2	Aims of the Trending Screen
The primary aim for this screen is entertainment, and to provide the user with the most up to date topical sentiment results from their location
-	To show an overview of what’s currently trending both worldwide and at a custom location
-	To show which topics are positive and which are negative, as well as volume
-	To provide links to the search screen for each trend


### 1.6.3	User Stories and Acceptance Criteria for the Trending Screen
TSV-J042 - As a user I should be able see what is currently trending worldwide 
-	AC1 A list of the top ten trends worldwide will be shown
-	AC2 The sentiment of each will be indicated by colour
-	AC3 The list will be sorted by volume of tweets, with the most popular trends at the top
TSV-J043 – As a user I should be able to enter a custom location to view local trends
-	AC1 - An input filed will be provided for the user to enter a location
-	AC2 The user should be able to enter any place e.g. ‘OX3 0BP’, ’14 Greys Road’, ‘California’, ‘Europe’. The Google Places API will then be used to find the latitude and longitude of the given string.
-	AC3 The trends displayed should be specific to the user’s location
TSV-J044 – As a user I can click a trend to find out more
-	AC1 The user should be able to click any trend and be redirected to the search page
-	AC2 It should be clear to the user the trends are clickable 
-	AC3 Trends in the bubble chart (see below) will also be clickable 
TSV-J045 – As a user I can view trends visually, to get an overview of volume and sentiment
-	AC1 There will be a bubble diagram below the list of trends
-	AC2 The diagram will show one bubble for each trend
-	AC3 The size of the bubble will represent the volume of tweets for that trend
-	AC4 The colour of each bubble will indicate sentiment
-	AC5 The bubble will be clickable to gain more information about a given trend

### 1.6.4	Wireframe Mockups and Description for the Trending Screen 

As the wireframe below illustrates, the navigation bar will be the same as on other screens. On landing on this screen, initially trends will be shown worldwide. There is an input field for location, upon entering a location and submitting the form, the user will be presented with the same screen however trends will be local. On the left is the list of trends, sorted by volume, and proceeded by their sentiment value. On the right is the bubble chart followed by a short textual description. 

![](wireframes/4_trending.png)
 

### 1.6.5	Technical Summary and Justification for the Trending Screen
The bubble chart will be developed in pure D3. The backend code will require multiple asynchronous requests to populate the trend data for each value, for that reason the frontend will make an AJAX call and a loading spinner will be displayed while the page waits for the data to be returned. This will take between 0.5 and 2.5 seconds, and then a further 0.1 seconds to render.


### 1.6.6	Constraints, limitations and risks of the Trending Screen
If the user enters a location that has a very low volume of twitter data, under ten trends may be displayed. If the user enters a place that is not found, they will be displayed with a dialog message.  Since this page involves ten requests in order to calculate sentiment data, as opposed to the single request on many other pages, it could potentially be a problem if this page receives a very high number of search traffic within a short period.


## 1.7	THE TEXT TWEETS SCREEN
### 1.7.1	Introduction to Text Tweets
Often after viewing the various data visualizations around a topic, a user may want to just view the original plain-text tweets, so they can read exactly what people are saying. This is the purpose of the text tweet page. 

### 1.7.2	Aims of Text Tweets
-	To allow the user to view the text of tweets, rather than just a colorful chart
-	To allow for users to monitor in real-time what people are saying about their chosen topic

### 1.7.3	Wireframe Mockups and Description for the Text Tweets Screen 
The wireframe below shows what the screen will look like. The user will enter a search term in the input box at the top to fetch relevant tweets. Since some more popular topics may have a very large volume of real-time data coming through, there needs to be the option to pause the live functionality, or the data will move to fast to read. 

Each tweet will be displayed in a box, with location, time and sentiment following the user requirements. Keywords will be in bold (not illustrated on mockup).

![](wireframes/5_raw-tweets.png)

### 1.7.4	User Stories and Acceptance Criteria for the frontend of the Text Tweets Screen
TSV-H046 – As a user I should be able to read the plain text tweets relating to a chosen topic/ word
-	AC1 There must be a search field for the user to enter their topic or keyword into
-	AC2 Once they press enter fresh data should be fetched and rendered
-	AC3 Tweets should be laid out in a clear and concise manor
TSV-H047 – As a user I should be able to quickly pick out the key information while reading
-	AC1 Positive and negative tweets should be in separate columns
-	AC2 Each tweet should have their keywords in bold, to make scan reading easier
-	AC3 The sentiment, date/time and location of each tweet should be displayed
TSV-H048 – As a user I should see new tweets come in in real-time
-	AC1 – The user shouldn’t have to refresh page to see new data

### 1.7.5	Technical Summary and Justification for Live Text Tweets
Socket.io will connect the frontend and backend for the real-time functionality for this screen. Moment.js will be used to display the time, as it is lightweight and stable. The highlighting of keywords will be done in the backend, and the location displayed is simply the text location on the user who tweeted, so may not be accurate.

### 1.7.6	Constraints, limitations and risks of the Live Text Tweets Screen
Since a large amount of real-time data may flow through this screen, it needs to be managed accordingly, by removing older results when new ones come in, to avoid the browser running out of memory. It should be noted to the user that it is not possible to control which tweets are displayed in terms of appropriateness.


## 1.8	WORD CLOUD
### 1.8.1	Introduction to the Word Cloud Screen
The word cloud will be made up of words used in either recent cached tweets, or tweets about a topic specified by the user. Size of each word will represent frequency of use, color will indicate sentiment. Words will be clickable.

### 1.8.2	Aims of the Word Cloud
The aim of this data visualization is to allow the user to see which keywords are used commonly in twitter results about their specified topic. This can better indicate why results are negative/ positive.

### 1.8.3	User Stories and Acceptance Criteria for the Word Cloud
TSV-L049 – As a user I can see a word cloud after entering my search term
-	AC1 Words should vary in size depending on number of times used
-	AC2 Sentiment should be represented by the shade of color, red = negative, green = positive, grey = neutral and all colors in between show sentiment in between
TSV-L050 – As a user I can see a text list of the top words used in positive and negative tweets
-	AC1 There should be two lists, one for top words used in positive tweets, the other negative
-	AC2 Each word should have an average sentiment value for associated tweets, in percentage
-	AC3 Each word should be followed by a number, of how many times it occurred in that set
-	AC4 The words should be clickable to view more 

### 1.8.4	Wireframe Mockups and Description for the Word Cloud
As the wireframe shows, the word cloud will take up the majority of the screen. On the left there will be space for the about section, an input field to enter a search term, the word statistics (most used words) and a link to the scatter chart (see next page).

![](wireframes/6_word-cloud.png)



### 1.8.5	Technical Summary and Justification for the Word Cloud Page
The word data will be calculated on the server-side for efficiency. The data visualization will be developed in pure D3.

### 1.8.6	Constraints, limitations and risks of the Word Cloud Page
The words will need to scaled correctly, so as to fit on the page without being too big, or too small. Also the algorithm to calculate the word data, may be rather long, however that will be included in the server-side methodology. 


## 1.9	WORD SCATTER PLOT

### 1.9.1	Introduction to Scatter Plot
This data visualization is very similar to the word cloud, as it presents the same data just in a different form. It will make it clearer for larger amounts of data. The scatter plot will have frequency along the x-axis, and sentiment along the y-axis. Each point will also have a size and color accordingly, and the user can hover to see the associated word.

### 1.9.2	Aims of the Word Scatter Plot
To visually illustrate which keywords are used most commonly in positive and negative tweets about a certain topic.

### 1.9.3	User Stories and Acceptance Criteria for the Word Scatter Plot
TSV-M050 – As a user I can view the scatter plot for a given search term/ keyword
-	AC1 Sentiment should be displayed along the y-axis
-	AC2 Frequency along the x-axis
-	AC3 The colour of the points should also be relative to the sentiment
TSV-M051 – As a user I can hover over a point to view the associated key word
-	AC1 The word should be displayed as a tooltip
-	AC2 The current point should slightly change colour/ size to make clear which one it is
-	AC3 The user should also be able to click a point to search for that word

### 1.9.4	Wireframe Mockups and Description for the Word Scatter Plot Screen
As the wireframe shows – this screen is very similar to the word cloud, with the only difference being how the data is presented.

![](wireframes/7_word-scatter.png)

### 1.9.5	Technical Summary and Justification for the Word Scatter Plot
The scatter plot will be generated on the server side, and rendered with D3.js on page load. The data used will be exactly the same as that of the word plot above.

### 1.9.6	Constraints, limitations and risks of the Word Scatter Plot
If there are a lot of low-frequency words, or a lot of neutral sentiment words, then the center of the chart may get very densely populated, making it hard for the user to hover over certain points. As a result, points with the same coordinate will be grouped, and multiple words shown on the label.
Another potential problem comes from calculating this data, but this will be covered in the server-side methodology.


## 1.10	THE 3D SENTIMENT GLOBE

### 1.10.1	Introduction to the Globe
This is a real-time 3D globe showing sentiment for geographical nations across the planet, and updating live. 

### 1.10.2	Aims of the Globe
-	Show’s how sentiment varies (either overall, or relating to a search term) across the planet
-	Quite cool to show in a 3D form

### 1.10.3	User Stories and Acceptance Criteria for the Globe
TSV-N052 – As a user I can interact with the globe
-	AC1 The user should be able to rotate the globe
-	AC2 The user should be able to zoom in and out of the globe
TSV-N053 – As a user I can see sentiment for each location (that has Twitter) on the globe
-	AC1 There should be vertical bars for each settlement with Twitter
-	AC2 The colour of the bar will represent sentiment
-	AC3 The height of the bar will represent scale of sentiment and volume of tweets
TSV-N054 – As a user I can view statistics of the data shown on the globe
-	AC1 Including number of tweets displayed and average sentiment
-	AC2 There will also be links to view the same data in other forms

### 1.10.4	Wireframe Mockup and Description for the Globe
This page will be slightly different than the others, as it does not have a navigation bar. This it is a much more immersive experience. The user will be able to interact with the globe. They will also have the ability to hide the controls on the left. There will be a link back to the homepage in the top left corner.

![](wireframes/8_3d-globe.png)

### 1.10.5	Technical Summary and Justification for the Globe
The globe will use Web GL which is a JavaScript graphics library for rendering 2D and 3D for the browser. The same adapter code from the heat map will be used.

### 1.10.6	Constraints, limitations and risks of the Globe
The user will need to be using a modern browser, which supports HTML 5, nowadays that includes nearly everyone so there won’t be a version for non-compatible browsers.


## 1.11	SENTIMENT TIMELINE 

### 1.11.1	Introduction to Timeline
The timeline displays average positive and negative sentiment over time. Either all tweets over the last 24 hours, or just tweets relating to a specific topic

### 1.11.2	Aims of the Timeline
To show what times of day people are most positive or negative

### 1.11.3	User Stories and Acceptance Criteria for the Timeline
TSV-O055 – As a user I can see both positive and negative sentiment over the past 24 hours
-	AC1 The positive sentiment will be represented by a green line and shaded area
-	AC2 The negative sentiment will be represented by a red line and shaded area
TSV-O056 – As a user I can interact with the map and the axis
-	AC1 The user should be able to hover over the line to see the sentiment at a given time
-	AC2 The user should be able to hover over the line to see time for a given sentiment value

### 1.11.4	Wireframe Mockups and Description for the Timeline 
![](wireframes/9_time-line.png)



## 1.12	TOPIC COMPARISON

### 1.12.1	Introduction to the Comparison Screen
Very often users will not only want to see how their brand of tracked topic is doing, but also to compare this against competitors or other topics in the same category as a benchmark. The comparison screen makes this process seamless, the user can compare up to four search terms, with visual results and links for further details.

### 1.12.2	Aims of the Comparison Screen
-	To allow the user to compare similar topics in one place
-	To get a snapshot of how each topic is currently doing


### 1.12.3	User Stories and Acceptance Criteria for Comparison Screen
TSV-P057 – As a user I can enter between one and four search terms
-	AC1 The screen will be divided into the number of search terms entered 
-	AC2 The user should not be able to enter over four topics, or zero topics
TSV-P058 – As a user I can see the overall sentiment for each of my search terms
-	AC1 this should be displayed in the form of a donut chart for each topic
-	AC2 the chart should be labelled, and the user can hover over it to get more details
TSV-P059 – As a user I can see most commonly used words and their sentiment for each topic
-	AC1 the top ten words will be displayed
-	AC2 the words will be coloured according to sentiment
-	AC3 the words will be clickable 
TSV-P060 – As a user I can view links to the other data visualisations for each of the topics

### 1.12.4	Wireframe Mockups and Description for the Comparison Screen
The screen will be split into between 1 and four columns depending on how many search terms were entered.
Each section will start with the search term, followed by a sentence summary of results, then a donut chart showing average sentiment results.  Finally a list of each the most used keywords for each search term and links for further viewing.

![](wireframes/10_brand-comparison.png)

 
### 1.12.5	Technical Summary and Justification for Comparison Screen
The backend methodology will outline how the asynchronous requests are handled. The front-end is reasonably straightforward, it is written in D3.


## 1.13	 ENTITY EXTRACTION SCREEN

### 1.13.1	Introduction to the Entity Extraction Screen
The entity extraction screen shows the results of the key label sequences recognised in a set of tweets about a certain topic. Results will be summarised in the form of a dynamic Sankey diagram. Below that will be more detailed textual results. Entities can be anything fitting into the defined categories e.g. places, people, languages, objects, companies, films…

### 1.13.2	Aims of the Entity Extraction Screen
-	To clearly show which entities are commonly referred to when people are talking about a topic
-	To provide visual representation of the proportion of tweets talking about each entity 

### 1.13.3	User Stories and Acceptance Criteria for the Entity Extraction Screen
TSV-R065 – As a user I can view the key entities extracted from a set of tweets
-	AC1 Entities should be grouped into categories
-	AC2 The first few matches for each entity should be displayed
-	AC3 Where possible an image should be shown for each entity, pulled from Wikipedia
TSV-R066 – As a user I can see what volume of each entity and category visually on a Sankey chart


### 1.13.4	Wireframe Mockups and Description for the Entity Extraction Screen 

![](wireframes/11_entity-extraction.png)

 
### 1.13.5	Technical Summary and Justification for the Entity Extraction Screen
The Sankey diagram will be written in D3.js, and will be user controllable. The user will be able to drag components to move them.

The images for each entity item will be pulled from Wikipedia.

### 1.13.6	Constraints, limitations and risks of the Entity Extraction Screen
Wikipedia does put limits on image requests, which will need to be looked into. Images should be loaded after the rest of the page is fully rendered, so as to not slow down page load times.


## 1.14	TONE IDENTIFICATION SCREEN

### 1.14.1	Introduction to the Tone Identification Screen
This screen will visually display all the data calculated by the backend regarding the tones of speech extracted from a body of tweets.

### 1.14.2	Aims of the Entity Extraction Screen
-	To visually display the tones of speech from a set of tweets
-	

### 1.14.3	User Stories and Acceptance Criteria for the Tone Identification Screen
TSV-Q063 – As a user I can view a summary of the key tones identified for a topic
-	AC1 these should be displayed in the form of no more than 12 mini bars on a chart
-	AC2 the user should be able to hover over a bar to get a more accurate percentage value
TSV-Q64 – As a user I can see a more detailed breakdown in the form of a segmented radar chart


### 1.14.4	Wireframe Mockups and Description for the Tone Identification Screen 

![](wireframes/12_tone-identification.png)
 
