# Services
opinionBabyServices = angular.module 'opinionBabyServices', [ 'ng', 'ngResource' ]


# App
opinionBabyApp = angular.module 'opinionBabyApp', [ 'opinionBabyServices' ]

# Controllers
opinionBabyApp.controller 'MainController', [
  '$scope'
  '$route'
  '$http'
  ($scope, $route, $http) ->
    $scope.onHeaderLoaded = ->
      whatIsThisElement = $('#whatIsThis')

      whatIsThisElement.popover
        trigger: 'hover'
        placement: 'auto'
        html: true
        title: '<label>OpinionBaby</label>'
        content: '<strong>OpinionBaby</strong> provides <strong>an awesome opinion analysis</strong> from review text data.'
        
      whatIsThisElement.popover 'show'

      setTimeout ->
        whatIsThisElement.popover 'hide'
      , 
        1000


    $scope.sourceText = """A very light and comfortable stroller. I like that the tray comes off to help infant-size riders see ahead well. Nice big undercarriage storage. Had some difficulty getting used to folding/unfolding but it stores nice and compactly. A great value!"""
    $scope.sourceTextLength = $scope.sourceText.length
    $scope.maxSourceTextLength = 300
    $scope.sourceTextLengthClass = ''
    $scope.parsedHtml = ''
    
    $scope.sourceTextChange = ->
      $scope.sourceTextLength = $scope.sourceText.length
      if $scope.sourceTextLength > $scope.maxSourceTextLength
        $scope.sourceTextLengthClass = 'red'
      else
        $scope.sourceTextLengthClass = ''

    $scope.parse = ->
      $http
        url: '/opinions/parse'
        method: 'POST'
        data: $.param
          sourceText: $scope.sourceText
        headers:
          'Content-Type': 'application/x-www-form-urlencoded'
      .success (data, status, headers, config) ->
        $scope.parsedHtml = OpinionBabyHelper.parsedToHtml data
      .error (data, status, headers, config) ->
        alert JSON.stringify data
]

# app configiguration
opinionBabyApp.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider.when '/',
      templateUrl: 'views/main.html'
      controller: 'MainController'

    $locationProvider.html5Mode true
]

# bootstraping
angular.bootstrap document, [ 'opinionBabyApp' ]
