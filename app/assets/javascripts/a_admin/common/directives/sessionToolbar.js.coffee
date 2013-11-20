# The sessionToolbar directive is a reusable widget that can show login or logout buttons
# and information for the current authenticated user
angular.module("a_admin.directives.session", []).directive "sessionToolbar", ["sessionService", "$state", "AUTH_CONFIG", (sessionService, $state, AUTH_CONFIG) ->
  directive =
    templateUrl: "assets/themes/default/session/sessionToolbar.tpl.html"
    restrict: "E"
    replace: true
    scope: true

    controller: ($scope, $attrs, sessionService) ->
      $scope.isAuthenticated = sessionService.isAuthenticated
      $scope.login = sessionService.showLogin
      $scope.logout = ->
        sessionService.logout ((res) ->
          $state.transitionTo AUTH_CONFIG.LOGIN_STATE
          toastr.success "You have been successfully logged out."
        ), (x) ->
          toastr.error "Logout failed."

    link: ($scope, $element, $attrs, $controller) ->
      $scope.$watch (->
        sessionService.user()
      ), (currentUser) ->
        $scope.currentUser = currentUser

  directive
]