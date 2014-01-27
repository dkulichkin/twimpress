'use strict'

describe 'Controller: EvaluatetwittsCtrl', () ->

  # load the controller's module
  beforeEach module 'twimpressApp'

  EvaluatetwittsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EvaluatetwittsCtrl = $controller 'EvaluatetwittsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
