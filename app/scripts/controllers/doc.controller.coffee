angular.module('resourceLibraryApp').controller('DocController', ['$scope', '$routeParams', '$http', '$sce'
($scope, $routeParams, $http, $sce) ->
  filePath = $routeParams.filePath
  $scope.doc = null

  $http.get("docs/#{filePath}").then((data)->
    $scope.doc = $sce.trustAsHtml(data.data)
  )
])
