angular.module('resourceLibraryApp').service('directoryService', ['$http', ($http) ->
  service = {}

#  service.getRootPathToHtml = ->
#    $http.get('./structure.json').then((res) -> res.data[0].path)

  service.getStructure = ->
    $http.get('./structure.json').then((res) -> res.data[0].children)
    #added in res.data[0] (instead of just res.data.) because of the way jsondirbuilder npm plugin works
    #pushses everything to array initially instead of just building an object like before

  return service
])
