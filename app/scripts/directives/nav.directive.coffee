angular.module('resourceLibraryApp').directive('nav', ['directoryService','$q','$sce', (directoryService, $q, $sce) ->
  return {
    templateUrl: './views/directiveTemplates/nav.html'

    scope: {}

    link: (scope, element, attrs) ->
      directory = directoryService.getStructure()
      scope.nav = null

      navHtmlStrArry = []
      navHtmlStr = ""

      directoryRecursion = (dirObj) ->

#        return $q.all(dirObj.map((f) ->
        for f in dirObj
          if f.type is "file"
            scope[f.name] = f
            html = "<li>{{#{f.name}.name}}</li>"
            console.log html
            navHtmlStrArry.push(html)
          else
            scope[f.name] = f
            html = "<ul>"
            html1 = "<lh>{{#{f.name}.name}}</lh>"
            console.log html
            console.log html1
            navHtmlStrArry.push(html)
            navHtmlStrArry.push(html1)

            directoryRecursion(f.children)

            html3 = "</ul>"
            console.log html3
            navHtmlStrArry.push(html3)


      directoryRecursion(directory)
      console.log navHtmlStrArry
      for string in navHtmlStrArry
        navHtmlStr += string
      console.log navHtmlStr



#
#        if (_.every(dirObj.children, (f) -> f.type is "file"))
#          folderName = dirObj.name
#          scope[folderName] = dirObj.children
#          html = "<li ng-repeat='child in #{folderName}'>{{child}}</li>"
#          navHtml.concat(html)
#        else if (_.every(dirObj.children, (f) -> f.type is "folder"))
#          for folder in dirObj.children
#            html = "<ul><lh>"
#            html1 = directoryRecursion(folder)
#            html2 = "</lh></ul>"
#            navHtml.concat(html).concat(html1).concat(html2)
#
#        else
#          for f in dirObj.children
#            if f.type is "file"
##              console.log f, " is a file"
#            else
##              console.log f, " is a folder, recursing!"
#              directoryRecursion(f)


  }
])
