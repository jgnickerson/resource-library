angular.module('resourceLibraryApp').controller('DocController', ['$scope', '$routeParams', '$http', '$sce'
($scope, $routeParams, $http, $sce) ->
  filePath = $routeParams.filePath
  $scope.doc = null

  $http.get("src/#{filePath}").then((data)->
    $scope.doc = $sce.trustAsHtml(data.data)
  )
])
