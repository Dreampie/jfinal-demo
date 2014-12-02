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
                if(data.user)
                  $("a.update").attr("deletedat",data.user.deleted_at)
                  td=t.parent()
                  td.siblings().eq(td.index() - 1).text("已删除")
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
#              if(data.user)
#                if(todo=="update")
#                  tag=$(e.target)
#                  td=tag.parent()
#                  tds=td.siblings()
#                  tds.eq(td.index() - 1).text("正常")
#                  if($(form).find("input[name='reuse'][checked]"))
#                    tag.attr("deletedat", "")
#                  tag.attr("regionid", $(form).find("select[name='region_id']").val())
#                  tag.attr("branchid",$(form).find("select[name='branch_id']").val())
#                  tag.attr("firstname",$(form).find("select[name='user.first_name']").val())
#                  tag.attr("lastname",$(form).find("select[name='user.last_name']").val())
#                  tag.attr("phone",$(form).find("select[name='user.phone']").val())
#                  tag.attr("username",$(form).find("select[name='user.username']").val())

                  $(modal).modal("hide")
                  $(form).bootstrapValidator('resetForm', true)
                  location.reload(true)
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
            btn=$(e.relatedTarget)
            $(this).find("input[name='user.id']").val(btn.attr("userid"))
#            $(this).find("select[name='region_id']").attr("select",btn.attr("regionid"))
#            $(this).find("select[name='branch_id']").attr("select",btn.attr("branchid"))

            regselect = $(this).find("select[name='region_id']")
            brhselect = $(this).find("select[name='branch_id']")
            App.Service.ConfigSrv.multiselect().reselect(regselect,btn.attr("regionid"))
            App.Service.ConfigSrv.multiselect().reselect(brhselect,btn.attr("branchid"))
            $(this).find("input[name='user.first_name']").val(btn.attr("firstname"))
            $(this).find("input[name='user.last_name']").val(btn.attr("lastname"))
            $(this).find("input[name='user.phone']").val(btn.attr("phone"))
            $(this).find("input[name='user.username']").val(btn.attr("username"))
            if(btn.attr("deletedat")!="")
              $(this).find("div.deleted_at span").html(btn.attr("deletedat"))
              $(this).find("div.deleted_at").show()
            else
              $(this).find("div.deleted_at").hide()
          )
    }
