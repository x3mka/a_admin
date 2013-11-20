angular.module("a_admin.controllers.dialogs",['a_admin.services.dialog']).controller "dialogsCtrl", ["$scope", "dialogService", "$controller", ($scope, dialogService, $controller) ->

  $scope.info = (message) -> dialogService.info(message)
  $scope.error = (message) -> dialogService.error(message)
  $scope.warning = (message) -> dialogService.warning(message)

  $scope.confirm = (message) ->
    dialogService.confirm(message).result.then((result) ->
      dialogService.info("You replied: " + (if result then 'Yes' else 'No'))
    )

  $scope.resultFromCustomForm =
    firstName: 'Dima'
    lastName: 'Boltrushko'

  $scope.openCustomFormDialog = (model) ->
    opts =
      title: "Custom Form"
      templateUrl: 'assets/themes/default/partials/modals/customForm.tpl.html'
      controller: 'customFormCtrl'
      resolve:
        model: () -> $scope.resultFromCustomForm

    d = dialogService.showFormDialog(opts)
    d.result.then((result) ->
      $scope.resultFromCustomForm = result.model if result
    )
]