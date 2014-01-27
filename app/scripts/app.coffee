'use strict'
Highcharts.setOptions({
  global:
    useUTC: false
})

angular.module('twimpressApp', ['ngRoute', 'btford.socket-io', 'ngAnimate', 'ngCookies'])
  .config ($routeProvider, socketProvider) ->

    mySocket = io.connect "http://localhost:8080"
    socketProvider.ioSocket mySocket

    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/evaluateTweets',
        templateUrl: 'views/evaluateTweets.html'
        controller: 'EvaluateTweetsCtrl'
      .otherwise
        redirectTo: '/'
