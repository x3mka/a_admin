angular.module("a_admin.directives.navigation", []).directive("navMenu", ["$parse", "$compile", ($parse, $compile) ->
  restrict: "C"
  scope: true
  link: (scope, element, attrs) ->
    scope.selectedNode = null
    scope.$watch attrs.menuData, ((val) ->
      template = angular.element("<ul class=\"nav\"><li ng-repeat=\"node in " + attrs.menuData + "\" ng-class=\"{active:node.active && node.active==true, 'dropdown-menu': !!node.children && node.children.length}\"><a ng-href=\"{{node.href}}\" ng-click=\"{{node.click}}\" target=\"{{node.target}}\" >{{node.text}}</a><sub-navigation-tree></sub-navigation-tree></li></ul>")
      linkFunction = $compile(template)
      linkFunction scope
      element.html(null).append template
    ), true
]).directive "subNavigationTree", ["$compile", ($compile) ->
  restrict: "E" #Element
  scope: true
  link: (scope, element, attrs) ->
    scope.tree = scope.node
    if scope.tree.children and scope.tree.children.length
      template = angular.element("<ul class=\"dropdown \"><li ng-repeat=\"node in tree.children\" node-id={{node." + attrs.nodeId + "}}  ng-class=\"{active:node.active && node.active==true, 'has-dropdown': !!node.children && node.children.length}\"><a ng-href=\"{{node.href}}\" ng-click=\"{{node.click}}\" target=\"{{node.target}}\" ng-bind-html-unsafe=\"node.text\"></a><sub-navigation-tree tree=\"node\"></sub-navigation-tree></li></ul>")
      linkFunction = $compile(template)
      linkFunction scope
      element.replaceWith template
    else
      element.remove()
]