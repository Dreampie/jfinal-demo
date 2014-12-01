define ['app'], ->
  'use strict'
  $ ->
    App.Model.User = {
      control: (user,success, error)->
        $.post('/member/control',user).success(success).error(error)
      query: (user, success, error)->
        $.get('/member/query', user).success(success).error(error)
      authed: (success, error)->
        $.post('/authed').success(success).error(error)
    }