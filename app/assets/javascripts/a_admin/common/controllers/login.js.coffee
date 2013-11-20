angular.module("a_admin.controllers.login", ["a_admin.services.session"]).controller "loginCtrl", ["$scope", "sessionService", "$state", "AUTH_CONFIG", ($scope, sessionService, $state, AUTH_CONFIG) ->
  console.log "In sessionCtrl"

  # The model for this form
  $scope.user =
    email: "admin@test.com"
    password: "12345678"
    remember_me: true

  $scope.login = ->

    #Clear any errors
    $scope.authError = null

    #Attempt Login
    sessionService.login $scope.user, ((res) ->
      $state.transitionTo AUTH_CONFIG.AFTER_LOGIN_STATE
    ), (x) ->
      $scope.authError = "Credentials are invalid"


  $scope.clearForm = ->
    $scope.user = {}

  $scope.cancelLogin = ->
    sessionService.cancelLogin()
]