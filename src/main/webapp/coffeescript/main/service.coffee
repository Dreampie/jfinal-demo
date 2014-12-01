define ['app', 'model'], ->
  'use strict'
  $ ->
    #app config
    App.Service.ConfigSrv = {
      path: (base)->
        if(base)
          pathname = window.location.pathname.replace(base, '')
        else
          pathname = window.location.pathname

        if(pathname == "" || pathname == "/")
          pathname = "/"
        else
          last = pathname.length - 1
          if(pathname != '/' && pathname.lastIndexOf('/') == last)
            pathname = pathname.substring(0, last)
        pathname

      format: (number, digit)->
        Number(number).toFixed(digit)

      multiselect: (selector...)->
        opt =
          maxHeight: 200
          nonSelectedText: '请选择'
          onChange: (option, checked)->
            $(this).change()
        for e in selector
          $(e).multiselect(opt)
          selval = $(e).find("option:selected").attr("value")
          if(selval && selval != "")
            $(e).change()
        rebuild: (selector...)->
          for e in selector
            $(e).multiselect('setOptions', opt)
            $(e).multiselect('rebuild')
        clean: (selector...)->
          for e in selector
            opts = $(e).find("option[value!='']")
            opts.remove()
        reselect: (selector, value)->
          $(selector).find("option:selected").removeAttr("selected")
          $(selector).find("option[value='" + value + "']").attr("selected", "selected")
          $(selector).multiselect('setOptions', opt)
          $(selector).multiselect('rebuild')
          $(selector).change()

      confirmModal: (ok) ->
        #confirm  modal
        $('#confirmModal').on('show.bs.modal', (e)->
          btn = $(e.relatedTarget)
          $("#confirmLabel").html(btn.attr("data-label"))
          $("#confirmContent").html(btn.attr("data-content"))
          $(this).find("button.ok").click(-> ok(btn))
        )
        $('#confirmModal')
    #验证码
      captcha: (selector = 'img.captcha')->
        $(selector).click(->
          src = $(this).src
          $(this).attr("src", $(this).attr("src").replace(/time=\w*/, "time=" + new Date().getTime()))
        )
        $(selector)
    #下拉菜单
      dropdownmenu: (selector...)->
        menuClick = (selector)->
          $(selector).click(->
            btng = $(this).parents(".btn-group");
            btng.find('span.selection').text($(this).text())
            btng.find('input.selection').val($(this).attr("value"))
            btng.find('input.selection').change()
          )
        for e in selector
          menuClick(e + " li a")
          #下拉菜单回显数据
          $(e).each(->
            btng = $(this).parents("div.btn-group")
            val = btng.find("input.selection").val()
            btng.find(e + " li a[value='" + val + "']").click()
          )

          if($(e + " li a.checked"))
            $(e + " li a.checked").each(->
              $(this).click()
            )

        menuClick
    #时间选择
      datetimepicker: (selector ...)->
        #default  config
        df =
          language: 'zh-CN'
          weekStart: 1
          todayBtn: true
          autoclose: 1
          todayHighlight: 1
          startView: 2
          showMeridian: 1
          format: 'yyyy-mm-dd hh:ii:ss'
        for e in selector
          if ($(e))
            $(e).each(->
              if($(this).attr("data-start-date"))
                df.startDate = new Date(Date.parse($(this).attr("data-start-date").replace(/-/g, "/")))
              if($(this).attr("data-end-date"))
                df.endDate = new Date(Date.parse($(this).attr("data-end-date").replace(/-/g, "/")))
              if ($(this).attr("data-date-format"))
                format = $(this).attr("data-date-format")
                if (format.length == 7)
                  df.minView = 3
                  df.startView = 3
                  df.todayBtn = false
                else if (format.length == 10)
                  df.startView = 2
                  df.todayBtn = true
                  df.minView = 2

                df.format = format
                $(this).datetimepicker(df)
              else
              $(this).datetimepicker(df)
              $(this).on('changeDate update remove', (e) ->
                $(this).change()
              )
            )
    }