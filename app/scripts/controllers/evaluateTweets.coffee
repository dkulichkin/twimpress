'use strict'

angular.module('twimpressApp')
  .controller 'EvaluateTweetsCtrl', ['$scope', '$http', '$timeout', '$interval', '$sce', 'socket', '$rootScope', ($scope, $http, $timeout, $interval, $sce, socket, $rootScope) ->

    ## Various helper variables
    searchButtonText = $sce.trustAsHtml "Search"

    ## Dom references
    userContainer = angular.element('.user-container')
    evaluationBar = angular.element('.evaluation-bar')
    tweetsContainer = angular.element('.tweets-table').parent()

    ## Initial scope's values
    $scope.isUserSigned = false
    $scope.searchButtonText = searchButtonText
    $scope.evaluationStarted = false
    $scope.showResults = false
    $scope.evaluationBarLevel = 0
    $scope.attention = 0
    $scope.inputPlaceHolder = "Please sign in to start"

    ## Forwarding socket-io's events into angular's env and binding callbacks
    socket.forward 'data', $scope
    $scope.$on 'socket:data', (ev, data) ->
      if data.poorSignal < 50
        $scope.attention = data.attention if data?.attention

    $rootScope.$on "signed", () ->
      $scope.isUserSigned = true
      $scope.inputPlaceHolder = "Enter search query"

    ## On Search button click callback
    $scope.doSearch = ->

      $scope.searchButtonText = $sce.trustAsHtml '<i class="fa fa-refresh fa-spin"></i>'

      $http.jsonp('http://127.0.0.1:8080/getTweets?callback=JSON_CALLBACK', {params: {q: $scope.searchTerm}})
      .success (body) ->
        $scope.Users = body
        if $scope.Users.length > 0 then $scope.startEvaluation()
      .error () ->
        console.log arguments
      .finally () ->
        $scope.searchButtonText = searchButtonText
        $scope.searchTerm = ""


    $scope.startEvaluation = ->

      $scope.evaluationStarted = true

      ## A prep function called before displaying a new user
      processNextUser = (i) ->
        $scope.attention = 50 if $scope.attention > 65 and $scope.evaluationBarLevel >= 100
        $scope.evaluationBarLevel = 0

        tweetsToPaste = $scope.Users[i].tweets
        userContainer.removeClass "success error"
        tweetsContainer.css { minHeight: tweetsToPaste.length * 79 + "px" }
        evaluationBar.addClass "ng-hide"

        $scope.Users[i].tweets = [];
        $scope.currentUser = $scope.Users[i]
        tweetAnimationItemIndex = 0
        
        ## Making tweets appearing with an animation effect
        tweetsListAnimationTimer = $interval () ->
          if tweetAnimationItemIndex < tweetsToPaste.length
            $scope.currentUser.tweets.push tweetsToPaste[tweetAnimationItemIndex]
            tweetAnimationItemIndex++
          else
            $interval.cancel tweetsListAnimationTimer
            evaluationBar.width(userContainer.height()).removeClass "ng-hide"
            showNextUser i
        , 200

      ## Showing a new user, calculating attention and evaluation metrics
      showNextUser = (i) ->
        $scope.cycleStart = new Date()
        currentUser = $scope.currentUser
        currentUser.averageAttention = 0
        currentUser.evaluationCyclePasses = 0

        ## Assuming 4 seconds for one message in list
        timeoutInterval = currentUser.tweets.length * 4

        ## User evaluation loop
        evaluationTimer = $interval () ->

          ## Determine when to halt - we out of summary time or reached 100% evaluation level
          if (new Date() - $scope.cycleStart) / 1000 > timeoutInterval || $scope.evaluationBarLevel >= 100
            evaluationFinishedClass = if $scope.evaluationBarLevel >= 100 then "success" else "error"
            userContainer.toggleClass evaluationFinishedClass
            currentUser.evaluationFinishedClass = evaluationFinishedClass
            currentUser.averageAttention = Math.floor(currentUser.averageAttention / currentUser.evaluationCyclePasses)
            $interval.cancel evaluationTimer

            ## For two seconds demonstrating the result, by blinking (error/success classes), then proceeding to next
            $timeout () ->
              displayNextUser i+1
            , 2000

          else
            currentUser.averageAttention += $scope.attention
            currentUser.evaluationCyclePasses++
            if $scope.evaluationBarLevel < 100 && $scope.attention > 65
              $scope.evaluationBarLevel += 10 / currentUser.tweets.length

        , 100


      ## OnAfter user's showing
      hideCurrentUser = (i, callback) ->
        if $scope.currentUser
          tweets = $scope.currentUser.tweets
          ## Making tweets hiding with an animation effect
          tweetsListAnimationTimer = $interval () ->
            if $scope.currentUser.tweets.length
              $scope.currentUser.tweets.pop()
            else
              $interval.cancel tweetsListAnimationTimer
              $scope.currentUser.tweets = tweets
              if typeof callback == "function" then callback i
          , 100
        else
          if typeof callback == "function" then callback i


      ## Users processing - Main core business logic's loop
      (displayNextUser = (i) ->
        if $scope.Users[i]
          if $scope.Users[i].tweets.length
            hideCurrentUser i, processNextUser
          else
            displayNextUser i+1
        else
          hideCurrentUser i, () ->
            $scope.currentUser = null
            $scope.showResults = true
            $scope.evaluationStarted = false
      )(0)

    $scope.getDate = (date) ->
      new Date(date)

    $scope.backToNewSearch = () ->
      $scope.showResults = false
  ]
