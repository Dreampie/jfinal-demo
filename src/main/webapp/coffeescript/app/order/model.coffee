define ['app'], ->
  'use strict'
  $ ->
    App.Model.Order = {
      update: (order, success, error)->
        $.post('/order/update', order).success(success).error(error)
      control: (order, success, error)->
        $.post('/order/control', order).success(success).error(error)
    }
    App.Model.Address = {
      query: (address, success, error)->
        $.post('/address/query', address).success(success).error(error)
      save: (address, success, error)->
        $.post('/address/save', address).success(success).error(error)
    }
    App.Model.Branch = {
      all: (success, error)->
        $.post('/branch/all').success(success).error(error)
    }