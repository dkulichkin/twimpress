'use strict'

describe 'Directive: twitterSignin', () ->

  # load the directive's module
  beforeEach module 'twimpressApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<twitter-signin></twitter-signin>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the twitterSignin directive'
