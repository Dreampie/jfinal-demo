define ['app', 'bootstrapvalidator.zh_CN', 'user.model', 'order.model'], ->
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
    App.Service.MemberSrv = {
      branch: ->
        branches = null
        App.Model.Branch.all((data)->
          if(data.branches)
            branches = data.branches
            regselect = $("select[name='region_id']")
            brhselect = $("select[name='branch_id']")

            regselect.change(->
              val = $(this).val() * 1
              App.Service.ConfigSrv.multiselect().clean("select[name='branch_id']")
              for branch in branches
                if(branch.region_id == val)
                  brhselect.find("option[value='']").before("<option value='" + branch.id + "'>" + branch.name + "</option>")

              if(brhselect.attr("select") && brhselect.attr("select") != "")
#                brhselect.find("option:selected").removeAttr("selected")
#                brhselect.find("option[value='" + brhselect.attr("select") + "']").attr("selected", "selected")
                App.Service.ConfigSrv.multiselect().reselect(brhselect,brhselect.attr("select"))
              else
                App.Service.ConfigSrv.multiselect().rebuild("select[name='branch_id']")
            )

            if(regselect.attr("select") && regselect.attr("select") != "")
#              regselect.find("option:selected").removeAttr("selected")
#              regselect.find("option[value='" + regselect.attr("select") + "']").attr("selected", "selected")
#              App.Service.ConfigSrv.multiselect().rebuild("select[name='region_id']")
#              regselect.change()
              App.Service.ConfigSrv.multiselect().reselect(regselect,regselect.attr("select"))
        )
      delete: ->
        modal = App.Service.ConfigSrv.confirmModal((t)->
          App.Model.User.control(
            'user.id': $("a.delete").attr("userid")
            'do': 'delete'
            (data)->
              if(data.state == 'success')
                modal.modal("hide")
                $("a.delete").remove()
          )
        )
      control: (todo,form, modal,btn)->
        conf=
          submitButtons:btn
          fields:
            'region_id':
              validators:
                notEmpty:
                  message: '请选择区域'
            'branch_id':
              validators:
                notEmpty:
                  message: '请选择支行'
            'user.last_name':
              validators:
                notEmpty: {}
#            'user.fisrt_name':
#              validators:
#                notEmpty: {}
            'user.phone':
              validators:
                notEmpty: {}
                phone:
                  country: 'CN'
            'user.username':
              validators:
                notEmpty: {}
                regexp:
                  regexp: /^\w{5,18}$/i
                  message: '请输入5至18个包含下划线,字母,数字的字符'
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
        if(todo=='update')
          conf=
            submitButtons:btn
            fields:
              'user.phone':
                validators:
                  phone:
                    country: 'CN'
              'user.username':
                validators:
                  regexp:
                    regexp: /^(\w{5,18})?$/i
                    message: '请输入5至18个包含下划线,字母,数字的字符'
              'user.password':
                validators:
                  regexp:
                    regexp: /^(\w{5,18})?$/i
                    message: '请输入5至18个包含下划线,字母,数字的字符'
              'repassword':
                validators:
                  identical:
                    field: 'user.password'
                    message: '确认秘密不正确'
        $(form).bootstrapValidator(conf).on('success.form.bv', (e) ->
          # Prevent form submission
          e.preventDefault()
          App.Model.User.control($(form).serialize(), (data)->
            if(data.state == 'success')
              $(modal).modal("hide")
              $(form).bootstrapValidator('resetForm', true)
            else
              if(data.user_usernameMsg)
                $(form).find("span.error").html(data.user_usernameMsg)
          )
          false
        )
        $(btn).click(->
          $(form).bootstrapValidator('validate')
        )
        $(form).find('input[name="user.username"]').change(->
          $(form).find("span.error").html("");
        )
        if(todo=='update')
          $(modal).on('show.bs.modal',(e)->
            App.Model.User.query({'user.id':$(e.relatedTarget).attr("userid")},(data)->
              if(data.user)
                $(form).find("input[name='user.id']").val(data.user.id)
                regselect = $(form).find("select[name='region_id']")
                brhselect = $(form).find("select[name='branch_id']")
                App.Service.ConfigSrv.multiselect().reselect(regselect,data.user.region_id)
                App.Service.ConfigSrv.multiselect().reselect(brhselect,data.user.branch_id)
                $(form).find("input[name='user.last_name']").val(data.user.last_name)
                $(form).find("input[name='user.first_name']").val(data.user.first_name)
                $(form).find("input[name='user.phone']").val(data.user.phone)
                $(form).find("input[name='user.username']").val(data.user.username)
            )
          )
    }
