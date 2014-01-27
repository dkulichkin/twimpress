'use strict'

angular.module('twimpressApp')
  .directive('signal', () ->
    restrict: 'A'
    scope:
      signal: "@"
    link: (scope, element, attrs) ->
      element.addClass "signal-status"
      scope.$watch "signal", (value) ->
        value = +value
        classToAdd = switch
          when 100 <= value and value  < 200 then "connection-signal-poor-1"
          when 50 <= value and value  < 100 then "connection-signal-poor-2"
          when 0 < value and value < 50 then "connection-signal-poor-3"
          when value == 0 then "connection-connected"
          else "connection-disconnected"
        if scope.currentSignalClass then element.removeClass scope.currentSignalClass
        scope.currentSignalClass = classToAdd
        element.addClass classToAdd
  )
