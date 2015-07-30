angular.module('resourceLibraryApp').directive('nav', ['directoryService', (directoryService) ->
  return {
    link: (scope, element, attrs) ->
      scope.directory = directoryService.getStructure()
    templateUrl: './views/directiveTemplates/nav.html'
  }
])
