'use strict'

describe 'Directive: gaugechart', () ->

  # load the directive's module
  beforeEach module 'twimpressApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<gaugechart></gaugechart>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the gaugechart directive'
