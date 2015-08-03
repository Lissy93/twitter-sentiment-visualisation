chai = require 'chai'
expect = chai.expect

## Should just pass by default, it's a test test
describe 'Coffee example test', ->
  it 'should return true in CoffeeScript', ->
    expect(true).equal true
    return
  return