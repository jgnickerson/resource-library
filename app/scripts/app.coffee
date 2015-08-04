angular.module 'resourceLibraryApp', ['ngAnimate', 'ngCookies', 'ngMessages', 'ngResource', 'ngRoute', 'ngSanitize','ngTouch']
.config ($routeProvider) ->
#  path = htmlDirPathProviderrovider.$get()
# how can I use $http in app.config?

  $routeProvider.when('/',
    templateUrl: 'views/landing.html'
    controller: 'LandingController'
    controllerAs: 'landing'
    #what if we want to dynamically create this
    #path based on structure.json
  ).when("/.tmp/src/:filePath*",
    templateUrl: 'views/doc.html'
    controller: 'DocController'
    controllerAs: 'doc'
  ).otherwise(redirectTo: '/')
