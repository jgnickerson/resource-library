angular.module('resourceLibraryApp').directive('nav', ['directoryService', '$compile', (directoryService, $compile) ->
  return {

  scope: {}

  controller: ['$scope', ($scope) ->
    $scope.toggle = (jurisdiction, override = null) ->
      if override?
        $scope.showing[jurisdiction] = override
      else
        $scope.showing[jurisdiction] = !$scope.showing[jurisdiction]

    $scope.isShown = (jurisdiction) ->
      $scope.showing[jurisdiction]

    $scope.toggleAll = ->
      _.forEach(_.keys($scope.showing), (jurisdiction) -> $scope.toggle(jurisdiction))
  ]

  link: (scope, element) ->
    scope.nav = null
    scope.showing = {}

    navHtmlStrArry = []
    navHtmlStr = ""

    directoryRecursion = (dirObj, jurisdiction = null) ->
      for f in dirObj
        if f != null
          if f.type is "file"
            fileName = f.shortName
            scope[fileName] = f
            html = """<li ng-show="isShown('#{jurisdiction}')"><a ng-href='#/{{#{fileName}.path}}'>{{#{fileName}.countryName}}</a></li>"""
            navHtmlStrArry.push(html)
          else
            scope[f.name] = f
            html = "<ul>"
            html1 = """<lh>{{#{f.name}.name}}<a ng-hide="isShown('#{f.name}')" ng-click="toggle('#{f.name}')">Show</a><a ng-show="isShown('#{f.name}')" ng-click="toggle('#{f.name}')">Hide</a></lh>"""
            navHtmlStrArry.push(html)
            navHtmlStrArry.push(html1)

            directoryRecursion(f.children, "#{f.name}")
            html3 = "</ul>"
            navHtmlStrArry.push(html3)


    directoryService.getStructure().then((dir)->
      directoryRecursion(dir)
      for string in navHtmlStrArry
        navHtmlStr += string
      element.html('<h5 ng-click="toggleAll()">Expand</h5>' + navHtmlStr)
      $compile(element.contents())(scope)
    )
  }
])
