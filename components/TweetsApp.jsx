/** @jsx React.DOM */

var React = require('react');
var Tweets = require('./Tweets.jsx');


// Export the TweetsApp component
module.exports = TweetsApp = React.createClass({

    // Method to add a tweet to the component
    addTweet: function(tweet){
        var updated = this.state.tweets;
        var count = this.state.count + 1;
        var skip = this.state.skip + 1;
        updated.unshift(tweet);
        this.setState({tweets: updated, count: count, skip: skip});
    },

    // Set the initial component state
    getInitialState: function(props){
        props = props || this.props;
        return {
            tweets: props.tweets,
            count: 0,
            page: 0,
            paging: false,
            skip: 0,
            done: false
        };
    },

    componentWillReceiveProps: function(newProps, oldProps){
        this.setState(this.getInitialState(newProps));
    },

    // Called directly after component rendering, only on client
    componentDidMount: function(){
        var self = this;
        var socket = io.connect();
        socket.on('tweet', function (data) {
            self.addTweet(data);
        });
        socket.on('disconnect', function () {
            console.log('disconnect client event....');
        });
    },

    // Render the component
    render: function(){
        return (
            <div className="tweets-app">
                <Tweets tweets={this.state.tweets} />
            </div>
        )
    }

});