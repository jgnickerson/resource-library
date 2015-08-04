angular.module('resourceLibraryApp').provider('htmlDirPathProvider', [ -> #had $http injected
  return {
    $get: ->
#    $get :  ->
#      $http.get('./structure.json').then((res) ->
#        console.log res.data[0].path
#        res.data[0].path
#      )
  }
])