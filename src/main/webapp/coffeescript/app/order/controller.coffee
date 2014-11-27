define ['css!/style/app/order/build','app', 'bootstrap-datetimepicker.zh_CN','bootstrap-multiselect', 'areapicker', 'order.service'], ->
  'use strict'
  $ ->
    App.Controller.OrderController = {
      init: ->
        switch App.Service.ConfigSrv.path("/order")
          when '/'
            App.Service.OrderSrv.receipt()
            App.Service.OrderSrv.cancel()
          when '/branch'
            App.Service.OrderSrv.branch()
            App.Service.OrderSrv.receive()
            App.Service.OrderSrv.deliver()
            App.Service.ConfigSrv.multiselect('[name="region_id"]','[name="order.branch_id"]')
          when '/build'
            App.Service.OrderSrv.build()
            App.Service.AddressSrv.newEvent('#newadr', '#newadrDiv', '#newadrBtn')
            App.Service.AddressSrv.newValid('#newadrDiv', '#newadrBtn', '#newadrRstBtn')
            App.Service.OrderSrv.save('#saveForm','#saveForm button.submit','#newadrDiv')
            App.Service.ConfigSrv.datetimepicker('.form_datetime')
            App.Service.ConfigSrv.multiselect('[name="order.address_id"]','[name="orderProduct.product_id"]')
          else

    }
    #start
    App.Controller.OrderController.init()