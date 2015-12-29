/** @jsx React.DOM */

var React = require('react');

module.exports = Tweet = React.createClass({
    render: function(){
        var tweet = this.props.tweet;

        return (
            <li>
                <blockquote>
                    <span className="content">{tweet.body}</span>
                </blockquote>
            </li>
        )
    }
});