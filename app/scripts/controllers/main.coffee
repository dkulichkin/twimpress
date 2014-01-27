'use strict'

angular.module('twimpressApp')
  .controller 'MainCtrl', ['$scope', 'socket', ($scope, socket) ->

    $scope.meditation = $scope.attention = $scope.delta = $scope.theta = $scope.lowAlpha = $scope.highAlpha =
    $scope.lowBeta = $scope.highBeta = $scope.lowGamma = $scope.$highGamma = $scope.rawEeg = 0
    $scope.isRecordingStarted = false

    socket.forward 'data', $scope
    $scope.$on 'socket:data', (ev, data) ->

      $scope.poorSignal = data.poorSignal if data.poorSignal?

      if $scope.poorSignal < 50
        if data?.rawEeg
          $scope.rawEeg = data.rawEeg
        else
          $scope.meditation = data.meditation || $scope.meditation
          $scope.attention = data.attention || $scope.attention
          $scope.delta = data.delta || $scope.delta
          $scope.theta = data.theta || $scope.theta
          $scope.lowAlpha = data.lowAlpha || $scope.lowAlpha
          $scope.highAlpha = data.highAlpha || $scope.highAlpha
          $scope.lowBeta = data.lowBeta || $scope.lowBeta
          $scope.highBeta = data.highBeta || $scope.highBeta
          $scope.lowGamma = data.lowGamma || $scope.lowGamma
          $scope.highGamma = data.highGamma || $scope.highGamma
  ]