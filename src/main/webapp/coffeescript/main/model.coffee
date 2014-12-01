define ['app'], ->
  'use strict'
  $ ->
    App.Model.Area = {
      query: (area, success, error)->
        $.get('/area/query', area).success(success).error(error)
    }