define ['app', 'bootstrap-multiselect', 'member.service'], ->
  'use strict'
  $ ->
    App.Controller.MemberController = {
      init: ->
        switch App.Service.ConfigSrv.path("/member")
          when '/','/branch'
            App.Service.MemberSrv.branch()
            App.Service.MemberSrv.delete()
            App.Service.MemberSrv.control('save','#saveForm','#saveModal','#saveModal button.ok')
            App.Service.MemberSrv.control('update','#updateForm','#updateModal','#updateModal button.ok')
            App.Service.ConfigSrv.multiselect('[name="region_id"]', '[name="branch_id"]')
          else
    }
    #start
    App.Controller.MemberController.init()