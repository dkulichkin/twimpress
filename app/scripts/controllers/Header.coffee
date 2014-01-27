'use strict'

angular.module('twimpressApp')
  .controller 'HeaderCtrl', ['$scope', 'socket', '$location', '$window', '$cookies', ($scope, socket, $location, $window, $cookies) ->

    $scope.socketStatus = 'Closed'
    $scope.poorSignal = 200

    socket.forward 'port-opened', $scope
    socket.forward 'port-closed', $scope
    socket.forward 'disconnect', $scope

    $scope.$on 'socket:port-opened', () ->
      $scope.socketStatus = 'Opened'
    $scope.$on 'socket:disconnect', ->
      $scope.socketStatus = 'Closed'
      $scope.poorSignal = 200

    socket.forward 'data', $scope
    $scope.$on 'socket:data', (ev, data) ->
      $scope.poorSignal = data.poorSignal if data.poorSignal?

    $scope.getClass = (path) ->
      $location.path() == path

  ]