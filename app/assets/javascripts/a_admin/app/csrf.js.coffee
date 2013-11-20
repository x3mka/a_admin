App.config(['$httpProvider', ($httpProvider) ->
  headers = $httpProvider.defaults.headers.common
  headers['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])