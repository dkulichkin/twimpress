'use strict'

describe 'Filter: setHeightCss', () ->

  # load the filter's module
  beforeEach module 'twimpressApp'

  # initialize a new instance of the filter before each test
  setHeightCss = {}
  beforeEach inject ($filter) ->
    setHeightCss = $filter 'setHeightCss'

  it 'should return the input prefixed with "setHeightCss filter:"', () ->
    text = 'angularjs'
    expect(setHeightCss text).toBe ('setHeightCss filter: ' + text)
