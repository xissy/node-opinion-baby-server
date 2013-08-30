# Services
sentimentServices = angular.module 'sentimentServices', [ 'ng', 'ngResource' ]


# App
sentimentApp = angular.module 'sentimentApp', [ 'sentimentServices' ]

# Controllers
sentimentApp.controller 'MainController', [
  '$scope'
  '$route'
  ($scope, $route) ->
    $scope.onHeaderLoaded = ->
      whatIsThisElement = $('#whatIsThis')

      whatIsThisElement.popover
        trigger: 'hover'
        placement: 'auto'
        html: true
        title: '<label>SentimentBaby</label>'
        content: '<strong>SentimentBaby</strong> provides <strong>an awesome sentiment analysis</strong> from review text data.'
        
      whatIsThisElement.popover 'show'

      setTimeout ->
        whatIsThisElement.popover 'hide'
      , 
        3000
]


sentimentApp.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider.when '/',
      templateUrl: 'views/main.html'
      controller: 'MainController'

    $locationProvider.html5Mode true
]

angular.bootstrap document, [ 'sentimentApp' ]
