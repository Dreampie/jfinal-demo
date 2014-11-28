define ['app'], ->
  'use strict'
  $ ->
    App.Model.Area = {
      query: (area, success, error)->
        $.post('/area/query', area).success(success).error(error)
    }