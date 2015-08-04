angular.module('resourceLibraryApp').directive('nav', ['directoryService', '$compile', (directoryService, $compile) ->
  return {

  scope: {}

  controller: ['$scope', ($scope) ->
  #Why do we want a controller here, instead of just putting these functions in link?
    $scope.showing = {}

    $scope.toggle = (jurisdiction, override = null) ->
      $scope.showing[jurisdiction] = if override? then override else !$scope.showing[jurisdiction]

    $scope.isShown = (jurisdiction) ->
      $scope.showing[jurisdiction]

    $scope.someAreShown = ->
      _.some(_.keys($scope.showing), (jurisdiction) -> $scope.isShown(jurisdiction))

    $scope.someAreHidden = ->
      _.some(_.keys($scope.showing), (jurisdiction) -> !$scope.isShown(jurisdiction))

    $scope.expandAll = ->
      _.forEach(_.keys($scope.showing), (jurisdiction) -> $scope.toggle(jurisdiction, true))

    $scope.collapseAll = ->
    #forEach exits on "explicit false return", so must add empty return
      _.forEach(_.keys($scope.showing), (jurisdiction) ->
        $scope.toggle(jurisdiction, false)
        return
      )
  ]

  link: (scope, element) ->
    scope.nav = null
    htmlStrArray = []
    navHtml = ""

    directoryRecursion = (dirObj, jurisdiction = null) ->
      dirObj.forEach((f)->
        if f.type is "file"
          fileName = f.shortName
          scope[fileName] = f
          html = """<li ng-show="isShown('#{jurisdiction}')">
                     <a ng-href='#/{{#{fileName}.path}}'>{{#{fileName}.countryName}}</a>
                     </li>
                 """
          htmlStrArray.push(html)

        else #f is a dir
          scope[f.name] = f

          scope.showing[f.shortName] = false #expand/collapseAll must have keys to iterate over
                                             #NOTE: this is going to cause problems for nested folders
                                             #and for showing/hiding persistence across routes (if we can do this)
          html = "<ul>"
          html1 = """<lh><a ng-hide="isShown('#{f.name}')" ng-click="toggle('#{f.name}', true)">{{#{f.name}.name}} +</a>
                     <a ng-show="isShown('#{f.name}')" ng-click="toggle('#{f.name}', false)">{{#{f.name}.name}} -</a>
                     </lh>
                    """

          htmlStrArray.push(html)
          htmlStrArray.push(html1)

          directoryRecursion(f.children, "#{f.name}")

          html2 = "</ul>"
          htmlStrArray.push(html2)
      )

    prepareHtmlString = ->
      htmlStrArray.forEach((str) ->
        navHtml += str
      )
      toggleAllHtml = """<h6><a ng-show="someAreHidden()" ng-click="expandAll()">Expand All</a> -
                         <a ng-show="someAreShown()" ng-click="collapseAll()">Collapse All</a></h6>
                      """
      navHtml = toggleAllHtml + navHtml

    directoryService.getStructure().then((dir)->
      directoryRecursion(dir)
      prepareHtmlString()
      element.html(navHtml)
      $compile(element.contents())(scope)
    )
  }
])
