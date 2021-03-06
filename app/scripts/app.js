// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  Highcharts.setOptions({
    global: {
      useUTC: false
    }
  });

  angular.module('twimpressApp', ['ngRoute', 'btford.socket-io', 'ngAnimate', 'ngCookies']).config(function($routeProvider, socketProvider) {
    var mySocket;
    mySocket = io.connect("http://localhost:8080");
    socketProvider.ioSocket(mySocket);
    return $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/evaluateTweets', {
      templateUrl: 'views/evaluateTweets.html',
      controller: 'EvaluateTweetsCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  });

}).call(this);

/*
//@ sourceMappingURL=app.map
*/
