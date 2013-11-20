App.config(['$httpProvider', ($httpProvider) ->

  interceptor = ["$rootScope", "$location", "$q", "AUTH_CONFIG", ($rootScope, $location, $q, AUTH_CONFIG) ->
    success = (response) ->
      response
    error = (response) ->
      if response.status is 401
        $location.path "/login"
        # when using $state, circular dependency happens
        # $state.transitionTo AUTH_CONFIG.LOGIN_STATE
      $q.reject response
    (promise) ->
      promise.then success, error
  ]
  $httpProvider.responseInterceptors.push interceptor
])