define ['css!/style/app/user/center','app','bootstrap-multiselect', 'user.service'], ->
  'use strict'
  $ ->
    App.Controller.UserController = {
      init: ->
        switch App.Service.ConfigSrv.path("/user")
          when '/'
            App.Service.ConfigSrv.multiselect('[name="region_id"]','[name="branch_id"]')
          when '/center','/updatePwd'
            #验证码
            App.Service.ConfigSrv.captcha('img.captcha')
            App.Service.UserSrv.center('#update_pwd')
          else
    }
    #start
    App.Controller.UserController.init()