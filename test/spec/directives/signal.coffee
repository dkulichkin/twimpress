'use strict'

describe 'Directive: signal', () ->

  # load the directive's module
  beforeEach module 'twimpressApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<signal></signal>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the signal directive'
