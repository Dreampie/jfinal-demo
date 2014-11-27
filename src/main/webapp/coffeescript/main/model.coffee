define ['app'], ->
  'use strict'
  $ ->
    App.Model.Area = {
      query: (id, success, error)->
        $.post('/area/query', {'id': id}).success(success).error(error)
    }