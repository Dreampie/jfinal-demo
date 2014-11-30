define ['app', 'bootstrapvalidator.zh_CN', 'order.model'], ->
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
    #订单
    App.Service.OrderSrv = {
      region:(form)->
        regselect = $("select[name='region_id']")
        if(regselect.attr("select") && regselect.attr("select") != "")
          App.Service.ConfigSrv.multiselect().reselect(regselect,regselect.attr("select"))
        stateInput = $("<input type='hidden' name='state' value=''/>")
        $("ul.menu-tabs li a").click(->
          stateInput.val($(this).attr("value"))
          form = $("form.region")
          form.append(stateInput)
          form.submit()
        )
      branch: ->
        branches = null
        App.Model.Branch.all((data)->
          if(data.branches)
            branches = data.branches
            regselect = $("select[name='region_id']")
            brhselect = $("select[name='order.branch_id']")

            regselect.change(->
              val = $(this).val() * 1
              App.Service.ConfigSrv.multiselect().clean("select[name='order.branch_id']")
              for branch in branches
                if(branch.region_id == val)
                  brhselect.find("option[value='']").before("<option value='" + branch.id + "'>" + branch.name + "</option>")

              if(brhselect.attr("select") && brhselect.attr("select") != "")
                App.Service.ConfigSrv.multiselect().reselect(brhselect,brhselect.attr("select"))
              else
                App.Service.ConfigSrv.multiselect().rebuild("select[name='order.branch_id']")
            )
            if(regselect.attr("select") && regselect.attr("select") != "")
              App.Service.ConfigSrv.multiselect().reselect(regselect,regselect.attr("select"))
        )
        stateInput = $("<input type='hidden' name='order.state' value=''/>")
        $("ul.menu-tabs li a").click(->
          stateInput.val($(this).attr("value"))
          form = $("form.branch")
          form.append(stateInput)
          form.submit()
        )

      build: ->
        $("div.settlement span.num").text($("input[name='orderProduct.num']").val())
        $("input[name='orderProduct.num'],select[name='orderProduct.product_id']").change(->
          select = $("select[name='orderProduct.product_id']")
          num = $("input[name='orderProduct.num']").val() * 1
          product_id = select.val()
          price = select.find("option:selected").attr("price") * 1
          total_pay = App.Service.ConfigSrv.format(num * price / 100, 2)
          $("div.settlement span.total_pay").text(total_pay)
          $("div.settlement span.num").text(num)
        )
        product_id = $("select[name='orderProduct.product_id']").val()
        if(product_id != "" && !isNaN(product_id))
          $("select[name='orderProduct.product_id']").change()

        $("div.settlement span.delivered_at").text($("input[name='order.delivered_at']").val())
        $("input[name='order.delivered_at']").change(->
          $("div.settlement span.delivered_at").text($(this).val())
        )

#        App.Model.Address.query(
#          ,(data)->
#            if(data.addresses)
#              $("select[name='order.address_id']").change(->
#              )
#        )
    receive: ->
        modal = App.Service.ConfigSrv.confirmModal((t)->
          App.Model.Order.control(
            'order.id': $("a.receive").attr("orderid")
            'do': 'receive'
            (data)->
              if(data.state == 'success')
                modal.modal("hide")
                td = t.parent()
                td.html("")
                td.siblings().eq(td.index() - 1).text("已接收")
          )
        )
      deliver: ->
        modal = App.Service.ConfigSrv.confirmModal((t)->
          App.Model.Order.control(
            'order.id': $("a.deliver").attr("orderid")
            'do': 'deliver'
            (data)->
              if(data.state == 'success')
                modal.modal("hide")
                td = t.parent()
                td.html("")
                td.siblings().eq(td.index() - 1).text("已发货")
          )
        )
      receipt: ->
        modal = App.Service.ConfigSrv.confirmModal((t)->
          App.Model.Order.update(
            'order.id': $("a.receipt").attr("orderid")
            'do': 'receipt'
            (data)->
              if(data.state == 'success')
                modal.modal("hide")
                td = t.parent()
                td.html("<a class='pay' href='" + t.attr("orderid") + "'>付款</a>")
                td.siblings().eq(td.index() - 1).text("已收货")
          )
        )
      cancel: ->
        modal = App.Service.ConfigSrv.confirmModal((t)->
          App.Model.Order.update(
            'order.id': $("a.cancel").attr("orderid")
            'order.state': -1
            (data)->
              if(data.state == 'success')
                modal.modal("hide")
                td = t.parent()
                td.html("")
                td.siblings().eq(td.index() - 1).text("已取消")
          )
        )
      save: (form = 'form.save', btn = 'button.submit', diser = '#newadrDiv')->
        $(form).bootstrapValidator(
          submitButtons: btn
          fields:
            'orderProduct.product_id':
              validators:
                notEmpty: {}
                integer: {}
            'orderProduct.num':
              validators:
                notEmpty: {}
                integer: {}
            'order.delivered_at':
              validator:
                notEmpty: {}
                date:
                  format: 'YYYY/MM/DD'
                  min: $("input[name='order.delivered_at']").parent().attr("data-start-date"),
                  max: '2020/12/30'
            'order.address_id':
              validators:
                notEmpty:
                  message: '选择一个送货地址'
        ).on('success.form.bv', (e) ->
          # Prevent form submission
          e.preventDefault()
          saveForm = $(form)
          $(diser).remove()
          da = saveForm.find("input[name='order.delivered_at']")
          dt = da.val().replace(/\//gm, '-')
          if(dt.indexOf(" 00:00:00") < 0)
            da.val(dt + " 00:00:00")
          saveForm.bootstrapValidator('defaultSubmit')
          false
        )
        $(btn).click(->
          $(form).bootstrapValidator('validate')
        )
    }
    #收货地址
    App.Service.AddressSrv = {
    #form 容器 btn 提交按钮 rst重置按钮
      newValid: (form, btn, rst,toggle)->
        $(form).bootstrapValidator(
          submitButtons: btn
          fields:
            'address.name':
              validators:
                notEmpty: {}
                stringLength:
                  min: 2
                  max: 10
            'address.phone':
              validators:
                notEmpty: {}
                phone:
                  country: 'CN'
            'address.spare_name':
              validators:
                stringLength:
                  min: 2
                  max: 10
            'address.spare_phone':
              validators:
                phone:
                  country: 'CN'
            'address.province_id':
              validators:
                notEmpty:
                  message: '请选择省份'
            'address.city_id':
              validators:
                notEmpty:
                  message: '请选择城市'
            'address.county_id':
              validators:
                notEmpty:
                  message: '请选择区镇'
            'address.street':
              validators:
                notEmpty: {}
        ).on('success.form.bv', (e) ->
          # Prevent form submission
          e.preventDefault()
          newadrDiv = $(form)
          address =
            'address.name': newadrDiv.find("input[name='address.name']").val()
            'address.phone': newadrDiv.find("input[name='address.phone']").val()
            'address.spare_name': newadrDiv.find("input[name='address.spare_name']").val()
            'address.spare_phone': newadrDiv.find("input[name='address.spare_phone']").val()
          #'address.zip_code': newadrDiv.find("input[name='address.zip_code']").val()
            'address.province_id': newadrDiv.find("select[name='address.province_id']").val()
            'address.city_id': newadrDiv.find("select[name='address.city_id']").val()
            'address.county_id': newadrDiv.find("select[name='address.county_id']").val()
            'address.street': newadrDiv.find("input[name='address.street']").val()


          App.Model.Address.save(address, (data)->
            if(data.state == 'success')
              $(toggle).text('新建')
              newadrDiv.hide()
              o = $("<option value=" + data.address.id + " >" + data.address.name + "</option>")
              select = $("select[name='order.address_id']")
              select.find("option[value='']").before(o)
              select.find("option:selected").removeAttr("selected")
              o.attr("selected", "selected")
              App.Service.ConfigSrv.multiselect().rebuild("select[name='order.address_id']")
              newadrDiv.bootstrapValidator('resetForm', true)
            else
          )
          false
        )

        $(rst).click(->
          $(form).bootstrapValidator('resetForm', true)
        )
        $(btn).click(->
          $(form).bootstrapValidator('validate')
        )

    #toggle 切换显示和隐藏的按钮  form容器 btn提交按钮
      newEvent: (toggle,select, form, btn,sub)->
        #new address div 显示
        $(toggle).click(->
          if($(form).is(":visible"))
            $(this).text('新建')
            $(form).hide()
            $(sub).removeAttr('disabled')
            $(sub).removeClass('disabled')
          else
            $(this).text('取消')
            $(form).show()
            $(sub).attr('disabled','disabled')
            $(sub).addClass('disabled')
        )
        #隐藏
        $(select).change(->
          $(toggle).text('新建')
          $(form).hide()
          $(sub).removeAttr('disabled')
          $(sub).removeClass('disabled')
        )
    }