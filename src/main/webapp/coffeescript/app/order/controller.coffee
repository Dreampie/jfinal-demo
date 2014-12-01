define ['css!/style/app/order/build','app', 'bootstrap-datetimepicker.zh_CN','bootstrap-multiselect', 'areapicker', 'order.service'], ->
  'use strict'
  $ ->
    App.Controller.OrderController = {
      init: ->
        switch App.Service.ConfigSrv.path("/order")
          when '/'
            App.Service.OrderSrv.detail()
            App.Service.OrderSrv.receipt()
            App.Service.OrderSrv.cancel()
          when '/region'
            App.Service.OrderSrv.region()
            App.Service.ConfigSrv.datetimepicker('.form_datetime')
            App.Service.ConfigSrv.multiselect('select[name="region_id"]')
          when '/branch'
            App.Service.OrderSrv.branch()
            App.Service.OrderSrv.detail()
            App.Service.OrderSrv.receive()
            App.Service.OrderSrv.deliver()
            App.Service.ConfigSrv.multiselect('select[name="region_id"]','select[name="order.branch_id"]')
          when '/build'
            App.Service.OrderSrv.build()
            App.Service.AddressSrv.newEvent('#newadr','select[name="order.address_id"]', '#newadrDiv', '#newadrBtn','#saveForm button.submit')
            App.Service.AddressSrv.newValid('#newadrDiv', '#newadrBtn', '#newadrRstBtn','#newadr')
            App.Service.OrderSrv.save('#saveForm','#saveForm button.submit','#newadrDiv')
            App.Service.ConfigSrv.datetimepicker('.form_datetime')
            App.Service.ConfigSrv.multiselect('select[name="order.address_id"]','select[name="orderProduct.product_id"]')
          else

    }
    #start
    App.Controller.OrderController.init()