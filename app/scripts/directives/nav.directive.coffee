angular.module('resourceLibraryApp').directive('nav', ['directoryService', '$compile', (directoryService, $compile) ->
  return {

  scope: {}

  link: (scope, element) ->
    scope.nav = null

    navHtmlStrArry = []
    navHtmlStr = ""

    directoryRecursion = (dirObj) ->
        for f in dirObj
          if f != null
            if f.type is "file"
              fileName = f.shortName
              scope[fileName] = f
              html = "<li><a ng-href='#/{{#{fileName}.path}}'>{{#{fileName}.countryName}}</a></li>"
              navHtmlStrArry.push(html)
            else
              scope[f.name] = f
              html = "<ul>"
              html1 = "<lh>{{#{f.name}.name}}</lh>"
              navHtmlStrArry.push(html)
              navHtmlStrArry.push(html1)

              directoryRecursion(f.children)

              html3 = "</ul>"
              navHtmlStrArry.push(html3)


    directoryService.getStructure().then((dir)->
      directoryRecursion(dir)
      for string in navHtmlStrArry
        navHtmlStr += string
      element.html(navHtmlStr)
      $compile(element.contents())(scope)
    )
  }
])
