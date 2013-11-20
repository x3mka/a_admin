angular.module("a_admin.services.dialog", ['ui.bootstrap']).factory "dialogService", ($modal, $injector, $controller, $q) ->

  getResolvePromises = (resolves) ->
    promisesArr = []
    angular.forEach resolves, (value, key) ->
      promisesArr.push $q.when($injector.invoke(value))  if angular.isFunction(value) or angular.isArray(value)
    promisesArr

  showGenericModalDialog = (modalOpts, dialogOpts) ->
    defaultModalOpts =
      resizeable: true
      keyboard: true
      templateUrl: "/assets/themes/default/partials/modals/generic.tpl.html"
      backdrop: 'static'

    defaultDialogOpts =
      headerTemplateUrl: ''
      bodyTemplateUrl: ''
      footerTemplateUrl: ''
      showHeader: true
      showBody: true
      showFooter: true

    modalOpts = angular.extend({}, defaultModalOpts, modalOpts)
    dialogOpts = angular.extend({}, defaultDialogOpts, dialogOpts)

    currentCtrl = modalOpts.controller

    modalOpts.controller = ($scope) ->
      $scope.dialogOpts = dialogOpts

      if currentCtrl
        modalOpts.resolve = modalOpts.resolve || {};

        $q.all(getResolvePromises(modalOpts.resolve)).then((vars) ->
          ctrlLocals = {$scope: $scope}
          resolveVarIndex = 0;

          angular.forEach modalOpts.resolve, (value, key) ->
            ctrlLocals[key] = vars[resolveVarIndex++]

          ctrlInstance = $controller(currentCtrl, ctrlLocals)
          $.extend(this, ctrlInstance)
        )

    $modal.open(modalOpts)


  showAlertDialog = (message, title = 'Alert', dialogOpts = {}) ->
    defaultDialogOpts =
      headerTemplateUrl: "/assets/themes/default/partials/modals/header.tpl.html"
      headerText: title
      bodyTemplateUrl: "/assets/themes/default/partials/modals/alert.body.tpl.html"
      bodyText: message
      footerTemplateUrl: "/assets/themes/default/partials/modals/alert.footer.tpl.html"
      okButtonText: 'Ok'
      cancelButtonText: 'No'
      showCancelButton: false

    mergedDialogOpts = {}
    angular.extend(mergedDialogOpts, defaultDialogOpts, dialogOpts)
    showGenericModalDialog({}, mergedDialogOpts)

  showFormDialog = (opts, dialogOpts = {}) ->
    defaultDialogOpts =
      headerTemplateUrl: "/assets/themes/default/partials/modals/header.tpl.html"
      headerText: opts.title
      bodyTemplateUrl: "/assets/themes/default/partials/modals/form.body.tpl.html"
      formTemplateUrl: opts.templateUrl
      footerTemplateUrl: "/assets/themes/default/partials/modals/form.footer.tpl.html"
      showSubmitButton: true,
      showCancelButton: true,
      submitButtonText: 'Save'
      cancelButtonText: 'Cancel'

    modalOpts =
      controller: opts.controller
      resolve: opts.resolve

    mergedDialogOpts = {}
    angular.extend(mergedDialogOpts, defaultDialogOpts, dialogOpts)
    showGenericModalDialog(modalOpts, mergedDialogOpts)

  info = (message, title = 'Information', dialogOpts = {}) ->
    showAlertDialog(message, title, dialogOpts)

  error = (message, title = 'Error', dialogOpts = {}) ->
    showAlertDialog(message, title, dialogOpts)

  warning = (message, title = 'Warning', dialogOpts = {}) ->
    showAlertDialog(message, title, dialogOpts)

  confirm = (message, title = 'Confirmation', dialogOpts = {}) ->
    defaultDialogOpts =
      showCancelButton: true
      okButtonText: 'Yes',
      cancelButtonText: 'No'
    mergedDialogOpts = {}
    angular.extend(mergedDialogOpts, defaultDialogOpts, dialogOpts)
    showAlertDialog(message, title, mergedDialogOpts)

  #public API for our service.
  showFormDialog: showFormDialog

  info: info
  error: error
  warning: warning

  confirm: confirm

