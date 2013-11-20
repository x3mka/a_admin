angular.module("a_admin.controllers.theme", ['ngCookies']).controller "themeCtrl", ["$scope", "$cookies", "$location", "$window", ($scope, $cookies, $location, $window) ->

  $scope.changeTheme = (theme) ->
    $cookies['a_admin_theme'] = theme
    #$location.path '/'
    $window.location.href = '/'


]