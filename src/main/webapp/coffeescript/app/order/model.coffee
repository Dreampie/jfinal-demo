define ['app'], ->
  'use strict'
  $ ->
    App.Model.Order = {
      update: (order, success, error)->
        $.post('/order/update', order).success(success).error(error)
      control: (order, success, error)->
        $.post('/order/control', order).success(success).error(error)
      query: (order, success, error)->
        $.get('/order/query', order).success(success).error(error)
    }
    App.Model.Address = {
      query: (address, success, error)->
        $.get('/address/query', address).success(success).error(error)
      save: (address, success, error)->
        $.post('/address/save', address).success(success).error(error)
    }
    App.Model.Branch = {
      all: (success, error)->
        $.get('/branch/all').success(success).error(error)
    }