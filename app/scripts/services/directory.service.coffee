angular.module('resourceLibraryApp').service('directoryService', [ ->
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
        ]
      }
      {
        'type': 'folder'
        'name': 'files2'
        'path': '/files2'
        'children': [{
          'type': 'file'
          'name': 'html3'
          'path': '/files2/html3.html'
        }]
      }
    ]

  service.getStructure = -> directoryStructure

  return service
])
