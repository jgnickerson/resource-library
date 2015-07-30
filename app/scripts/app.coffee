angular.module 'resourceLibraryApp', ['ngAnimate', 'ngCookies', 'ngMessages', 'ngResource', 'ngRoute', 'ngSanitize','ngTouch']
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'views/landing.html'
    controller: 'LandingController'
    controllerAs: 'landing'
  .when '/docs/:filePath*',
    templateUrl: 'views/doc.html'
    controller: 'DocController'
    controllerAs: 'doc'
  .otherwise
      redirectTo: '/'
