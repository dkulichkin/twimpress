'use strict'

angular.module('twimpressApp')
  .directive('twitterSignin', ['$http', '$window', '$compile', '$rootScope', ($http, $window, $compile, $rootScope) ->
    restrict: 'A'
    link: (scope, element) ->

      signInButtonTpl = '<button ng-click="signIn()" class="btn btn-mini btn-signin"><i class="fa fa-twitter"></i> Sign in</button>'
      welcomeUserTpl = '<img ng-src="{{profileImg}}" class="profile-img" /> Welcome, {{screenName}}'

      scope.signIn = () ->
        $window.location = 'http://127.0.0.1:8080/twauth'

      $http.jsonp('http://127.0.0.1:8080/is-signed?callback=JSON_CALLBACK').success (response) ->

        resultTemplate = if response.isSigned then welcomeUserTpl else signInButtonTpl
        if response.isSigned
          scope.screenName = response.screenName
          scope.profileImg = response.profileImg
          $rootScope.$emit "signed"

        element.html resultTemplate
        $compile(element.contents())(scope)

  ])
