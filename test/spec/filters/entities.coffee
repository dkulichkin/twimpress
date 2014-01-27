'use strict'

describe 'Filter: entities', () ->

  # load the filter's module
  beforeEach module 'twimpressApp'

  # initialize a new instance of the filter before each test
  entities = {}
  beforeEach inject ($filter) ->
    entities = $filter 'entities'

  it 'should return the input prefixed with "entities filter:"', () ->
    text = 'angularjs'
    expect(entities text).toBe ('entities filter: ' + text)
