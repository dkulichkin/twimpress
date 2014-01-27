'use strict'

angular.module('twimpressApp')
  .filter 'setHeightCss', () ->
    (input) ->
      "width: #{input}%"
