angular.module('resourceLibraryApp').service('directoryService', ['$http', ($http) ->
  service = {}

  directoryStructure =
  [
      {
        'type': 'folder'
        'name': 'files1'
        'path': '/files1'
        'children': [
          {
            'type': 'file'
            'name': 'html1'
            'path': '/files1/html1.html'
          }
          {
            'type': 'file'
            'name': 'html2'
            'path': '/files1/html2.html'
          }
          {
            'type': 'folder'
            'name': 'files4'
            'path': '/files1/files4'
            'children': [
              {
                'type': 'file'
                'name': 'html5'
                'path': '/files1/files4/html5.html'
              }
              {
                'type': 'file'
                'name': 'html6'
                'path': '/files1/files4/html6.html'
              }
            ]
          }
        ]
      }
      {
        'type': 'folder'
        'name': 'files2'
        'path': '/files2'
        'children': [
          {
            'type': 'file'
            'name': 'html3'
            'path': '/files2/html3.html'
          }
          {
            'type': 'folder'
            'name': 'files3'
            'path': '/files2/files3'
            'children': [
              {
                'type': 'file'
                'name': 'html4'
                'path': '/files2/files3/html4.html'
              }
            ]
          }
        ]
      }
    ]


  service.getStructure = ->
    $http.get('./structure.json').then((res) -> res.data.children)

  return service
])
