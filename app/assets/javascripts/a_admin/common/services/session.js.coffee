angular.module("a_admin.services.session", []).factory "sessionService", ($location, $http, $q, AUTH_CONFIG, $cookieStore) ->

  accessLevels = routingConfig.accessLevels
  userRoles = routingConfig.userRoles
  ANONYMOUS_USER = { username: "", role: userRoles.public }
  currentUser = $cookieStore.get(AUTH_CONFIG.SESSION_COOKIE_KEY) || ANONYMOUS_USER

  $cookieStore.remove(AUTH_CONFIG.SESSION_COOKIE_KEY);

  changeUser = (user, role) ->
    currentUser = { username: user.email, role: userRoles[role] }
    $cookieStore.put(AUTH_CONFIG.SESSION_COOKIE_KEY, currentUser);

  service =

    showLogin: ->
      $location.path '/login'

    authorize: (accessLevel, role) ->
      role = currentUser.role if role is `undefined`
      accessLevel.bitMask & role.bitMask

    login: (user, success, error) ->
      $http.post("/api/v1/login.json", { user: user }).success((response) ->
        changeUser(response.user, response.role)
        success()
      ).error error

    logout: (success, error) ->
      $http.post("/api/v1/logout.json").success((response) ->
        currentUser = ANONYMOUS_USER
        success()
      ).error error

#    requestCurrentUser: ->
#      # service.currentUser = $cookieStore.get(settingsService.sessionCookieKey);
#      if service.isAuthenticated()
#        $q.when service.currentUser
#      else
#        $http.get("/api/v1/current_user.json").then (response) ->
#          service.currentUser = response.data.user
#          service.currentUser


    accessLevels: accessLevels
    userRoles: userRoles
    user: () ->
      currentUser

    isAuthenticated: (user) ->
      user = currentUser if user is `undefined`
      user.role.title is userRoles.user.title or user.role.title is userRoles.admin.title

  service
