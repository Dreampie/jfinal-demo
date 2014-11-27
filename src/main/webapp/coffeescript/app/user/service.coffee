define ['app', 'bootstrapvalidator.zh_CN', 'user.model'], ->
  'use strict'
  $ ->
    $.fn.bootstrapValidator.DEFAULT_OPTIONS = $.extend(
      {}
      $.fn.bootstrapValidator.DEFAULT_OPTIONS
      {
      # Exclude only disabled fields
      # The invisible fields set by Bootstrap Multiselect must be validated
        excluded: [':disabled']
        feedbackIcons:
          valid: 'glyphicon glyphicon-ok'
          invalid: 'glyphicon glyphicon-remove'
          validating: 'glyphicon glyphicon-refresh'
      }
    )
    #用户
    App.Service.UserSrv = {
      center: (form)->
        $(form).bootstrapValidator(
          fields:
            'oldpassword':
              validators:
                notEmpty: {}
                stringLength:
                  min: 5
                  max: 18
            'user.password':
              validators:
                notEmpty: {}
                regexp:
                  regexp: /^\w{5,18}$/i
                  message: '请输入5至18个包含下划线,字母,数字的字符'
            'repassword':
              validators:
                notEmpty: {}
                identical:
                  field: 'user.password'
                  message: '确认秘密不正确'
        )
        $(form).find("input[name='oldpassword']").change(->
          $(form).find("span.error").html("")
        )
    }