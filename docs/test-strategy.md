# Test Strategy
>In order to develop high quality software, thorough testing is essential.

## Introduction

This document is a high level presentation of the test approach to be undertaken 
in relation to Twitter Sentiment Visualisation.

## Test Driven Development
This is a process where the tests are written before the code is developed. 
The test cases are written based on the user stories, and most the logic on 
the application is developed in the tests, so when it comes to writing the 
code it should be a very quick process.

TDD was chosen as the testing methodology, as it has several key advantages. 
Firstly it will ensure the code that is written is structured, as the structure
 must be determined before the code can be written. Secondly it helps the code 
 fit with the user stories, since the tests will be based from the user stories. 
 It also creates a detailed specification. Most importantly less time is spend 
 debugging and fixing bugs, as code is written to pass tests.


## Unit Testing
Unit testing involves writing a series of very thorough tests to cover each 
module, function or method independently as a unit. Each function should be 
checked that it produces the expected output with a variety of hardcoded inputs. 
This should include testing error handling, and borderline and unexpected inputs. 
After the unit tests have been written the unit test process can be automated, 
so every time a method is changed, the tests are rerun to check that it still 
produces the correct output with various inputs.

Unit testing has a lot of benefits to software development, firstly any 
potential bugs or failures will be identified before that function gets 
integrated with the larger application. Developers can verify their code 
still works as expected as they refractor and change parts, in the same 
way, unit testing can prevent future changes from breaking functionality. 
It also helps you understand your code, and gives you instant feedback when 
something is not working as it should be.


## Behaviour Driven Development
This is the same principle as TDD, but involves writing tests with a more 
functional point of view. The syntax used to write the tests tends to be more 
like English, and the tests follow very closely to the user stories. 
Following BDD will ensure that the code written follows user stories, so as 
long as they are complete, then the finished solution should also be thorough.

----

## Pass/ Fail Criteria

| Test Type          | Pass Condition                                                                          |
|--------------------|-----------------------------------------------------------------------------------------|
| Functional Testing | All acceptance criteria must be met, checked and documented                             |
| Unit Tests         | 100% of unit tests must pass. It will be immediately clear when a unit test is failing  |
| Integration Tests  | 100% pass rate after every commit                                                       |
| Coverage Tests     | 80% or greater                                                                          |
| Code Reviews       | B grade/ Level 4 or higher. Ideally A grade/ Level 5 if possible.                       |
| Dependency Checks  | Mostly up-to-date dependencies except in justified circumstances.                       |



----

## Documenting Results
A ststus of all unit tests, coverage tests, dependency checks and code review 
will be displayed in the form of badges on the repository readme. Each will be 
linked with the appropriate service, so will update live. This will indicate 
immediately as soon as a test is failing or a dependency becomes outdated.

Detailed test reports for each testing method will also be generated and saved.


----


## Testing Tools

### Framework – [Mocha](https://github.com/mochajs/mocha)
Mocha is a feature-rich and well established JavaScript testing framework. 
A JavaScript framework is required in order to store, write and run the tests 
in a structured way. Using a framework will also make using various testing 
plugins easier to use neatly. 

### Assertion Library – [Chai](https://github.com/chaijs/chai)
An assertion library will provide structure and syntax in order to actually 
write the test cases. Chai is a good choice, as it fits nicely with Mocha, 
and has a very flexible syntax, including a ‘should’ library built in, which 
will allow for tests to be written in a BDD style.

### Coverage Testing – [Istanbul](https://github.com/gotwarlost/istanbul)
Coverage testing measures the proportion of your source code that is covered 
by your unit tests. It can be very helpful while developing as it makes it 
easier to aim for as close to 100% as possible. It also highlights the code 
that is not covered by unit tests. For this project Istanbul will be configured 
to show a coverage summary in the console when a test or source code file 
changes, it will also generate a much more detailed HTML report that will be 
saved in the reports directory.

### Stubs, Spies and Mocking – [Sinon.js](https://github.com/sinonjs/sinon)
For the tests, it is not good practice to have any network calls, so Sinon.js 
will be used to stub the data that would have been returned for each network 
call. Spies will also be used to test the functionality of methods.

### Continuous Integration Testing – [Travis CI](https://github.com/travis-ci/travis-ci)
Since the code will be written following a very modular approach, and each 
module will be thoroughly tested standalone but it is of course vital that 
they work together seamlessly as they are meant to. A Travis CI configuration 
file will be written in a Yamel format, which will specify to Travis which 
tests need to be run in order to ensure the code is working as it should, 
and which versions of Node (and other technologies) the code will need to be 
run on. Then every time a new commit is made Travis will run tests to ensure 
everything continues to pass, and the code repository is not broken by the 
latest commit.

### Dependency Checking – [David](https://github.com/alanshaw/david)
Since there are quite a few external dependencies that come together to make 
each component of the project possible, it is important to ensure that all 
the current dependencies are stable and have no bugs that could effect the 
running of TSV. For this automated dependency checking will be implemented 
with David-DM. When a dependency is no longer in date an notification will 
be triggered.

### Automated Code Review’s – [Code Climate](https://github.com/codeclimate/codeclimate)
Code reviews can pick up on bad practices and inefficient code, such as 
including dependencies and not using them, variables in the wrong scope, 
poor identifiers, not following convention etc.. All of this information 
can help write better quality code. Code Climate also provides automated 
coverage testing in conjunction with Istanbul.

### Headless Browser Testing – [PhantomJS](https://github.com/ariya/phantomjs)
For running functional frontend tests without having to use a browser, 
it can be automated in the same way as the other tests and can test the 
integration with other frontend libraries. PhantomJS also provides network 
monitoring utilities that can help cut down page load times.

### Testing HTTP services – [SuperTest](https://github.com/visionmedia/supertest)
SuperTest is an agent driven library for testing node.js HTTP servers using 
a fluent API. It will be used for testing HTTP servers. It will be used to 
check the routing for the Express web service, to ensure with a given URL 
and parameters returns the expected output.


