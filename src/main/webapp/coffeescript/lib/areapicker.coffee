define ['app', 'bootstrap-multiselect'], ->
  "use strict"

  # Main function
  $.fn.areapicker = (areas, options) ->
    $.fn.areapicker.settings = $.extend({}, $.fn.areapicker.defaults, options)
    $.fn.areapicker.areas = areas
    $.fn.areapicker.Op.initSelect()
    $.fn.areapicker.Op.checkedSelect()

  $.fn.areapicker.Op =
    initSelect: ->
      opt = $.fn.areapicker.settings
      size = opt.classes.length - 1
      for i in  [0..size]
        selector = $("select." + opt.classes[i])
        selector.attr("level", i)
        selector.multiselect(opt.config)
      #init first level
      $.fn.areapicker.Op.fillChildren(0, 0)

    checkedSelect: ->
      opt = $.fn.areapicker.settings
      size = opt.checkeds.length - 1
      for i in  [0..size]
        if(opt.checkeds[i])
          if(i < opt.classes.length - 1)
            $.fn.areapicker.Op.fillChildren(opt.checkeds[i], i + 1)
          selector = $("select." + opt.classes[i])
          selectOption = selector.find("option[value='" + opt.checkeds[i] + "']")
          if(selectOption.length > 0)
            selectOption.attr("selected", "selected")
          selector.multiselect('setOptions', opt.config)
          selector.multiselect('rebuild')

    cleanChildren: (level)->
      opt = $.fn.areapicker.settings
      #原数据重置
      size = opt.classes.length - 1
      if(level <= size)
        for i in  [level..size]
          selector = $("select." + opt.classes[i])
          #删除原节点
          opts = selector.find("option[value!='']")
          opts.remove()
          selector.multiselect('setOptions', opt.config)
          selector.multiselect('rebuild')

    getName: (ids...)->
      if ids.length==1 && ids[0] instanceof Array
        ids=ids[0]
      areas = $.fn.areapicker.areas
      names = []
      if (areas && areas.length > 0)
        $.each(areas, (index, element) ->
          for id in ids
            if id*1 == element.id
              names[names.length] = element.name
        )
      if names.length == 0
        return undefined
      else if names.length == 1
        return names[0]
      else
        return names
  #填充数据
    fillChildren: (pid, level) ->
      opt = $.fn.areapicker.settings
      areas = $.fn.areapicker.areas
      if (areas && areas.length > 0)
        selector = $("select." + opt.classes[level])
        $.each(areas, (index, element) ->
          if (pid == element.pid)
            t = $("<option value='" + element.id + "'>" + element.name + "</option>")
            selector.prepend(t)
        )
        selector.multiselect('setOptions', opt.config)
        selector.multiselect('rebuild')

  # Defaults
  $.fn.areapicker.defaults =
    classes: ['province', 'city', 'county']
    config:
      maxHeight: 200
      nonSelectedText: '请选择'
      onChange: (option, checked)->
        selector = $(option).parent()
        level = selector.attr("level") * 1
        pid = $(option).val()
        $.fn.areapicker.Op.cleanChildren(level + 1)
        if(pid != "" && !isNaN(pid))
          $.fn.areapicker.Op.fillChildren(pid * 1, level + 1)

        opt = $.fn.areapicker.settings
        size = opt.classes.length - 1
        if(level <= size)
          for i in  [level..size]
            $("select." + opt.classes[i]).change()

  $.areapicker = $.fn.areapicker

  #default init
  $ ->
    App.Model.Area.query('id':1,
    (data) ->
      if (data.areas)
        $.areapicker(data.areas,
          {checkeds: [1, $("select[name$='city_id']").attr("select") , $("select[name$='county_id']").attr("select") ]})
    )