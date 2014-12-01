define ['app', 'service'], ->
  'use strict'
  $ ->
    #base
    App.Controller.Controller = {
      init: ->
        switch App.Service.ConfigSrv.path()
          when '/'
            #验证码
            App.Service.ConfigSrv.captcha('img.captcha')
          else
    }

    App.Controller.Controller.init()
