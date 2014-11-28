'use strict'

libsources =
#id like webjars dir
  version:
    'require-css': '0.1.7'
    'jquery': '2.1.1'
    'nprogress': '0.1.2'
    'bootstrap': '3.3.0'
    'bootstrap-datetimepicker': '2.3.1'
    'bootstrap-multiselect': '0.9.8'
    'bootstrapvalidator': '0.5.2'
    'font-awesome': '4.1.0'
  cdn:
    'nprogress': '//cdn.bootcss.com/'
    'bootstrap': '//cdn.bootcss.com/'

  jarpath: (requireid, webjarsname)->
    'webjars/' + requireid + '/' + libsources.version[requireid] + '/' + webjarsname
#when cdnname  not equal webjarsname  please insert param cdnname
  jarpaths: (requireid, webjarsname, cdnname)->
    webjarspath = libsources.jarpath(requireid, webjarsname)
    if libsources.cdn[requireid]
      #cdnpath = webjars.cdn[requireid] + webjars.version[requireid] + '/' + (cdnname || webjarsname)
      [libsources.cdnpath(requireid, cdnname || webjarsname), webjarspath]
    else
      webjarspath
  localjs: (name)->
    'javascript/' + name
  localcss: (name)->
    'style/' + name
  localpaths: (requireid, localname, cdnname, type = 'js')->
    localpath = if type == 'css' then libsources.localcss(localname) else libsources.localjs(localname)
    if libsources.cdn[requireid]
      #cdnpath = webjars.cdn[requireid] + webjars.version[requireid] + '/' + (cdnname || localname)
      [libsources.cdnpath(requireid, cdnname || localname), localpath]
    else
      localpath
  cdnpath: (requireid, cdnname)->
    libsources.cdn[requireid] + requireid + '/' + libsources.version[requireid] + '/' + cdnname


#requirejs  config
requirejs.config
  baseUrl: '/'
  urlArgs: 'v=1.0'
#all of the webjar configs from their webjars-requirejs.js files
  paths:
    'jquery': libsources.jarpath('jquery', 'jquery.min')
    'nprogress': libsources.jarpath('nprogress', 'nprogress')
    'bootstrap': libsources.jarpath('bootstrap', 'js/bootstrap.min')
    'bootstrap-datetimepicker': libsources.jarpath('bootstrap-datetimepicker', 'js/bootstrap-datetimepicker.min')
    'bootstrap-datetimepicker.zh_CN': libsources.jarpath('bootstrap-datetimepicker', 'js/locales/bootstrap-datetimepicker.zh-CN')
    'bootstrap-multiselect':libsources.jarpath('bootstrap-multiselect', 'js/bootstrap-multiselect')
    'bootstrapvalidator': libsources.jarpath('bootstrapvalidator', 'js/bootstrapValidator')
    'bootstrapvalidator.zh_CN': libsources.jarpath('bootstrapvalidator', 'js/language/zh_CN')

    'areapicker': libsources.localjs('lib/areapicker')

    #'main':libsources.localjs('main')
    'app': libsources.localjs('app')
    'controller': libsources.localjs('main/controller')
    'model': libsources.localjs('main/model')
    'service': libsources.localjs('main/service')

    'user.model':libsources.localjs('app/user/model')
    'user.service':libsources.localjs('app/user/service')
    'user.controller':libsources.localjs('app/user/controller')

    'member.service':libsources.localjs('app/member/service')
    'member.controller':libsources.localjs('app/member/controller')

    'order.model':libsources.localjs('app/order/model')
    'order.service':libsources.localjs('app/order/service')
    'order.controller':libsources.localjs('app/order/controller')
  shim:
    'bootstrap': ['jquery', 'css!' + libsources.jarpath('bootstrap', 'css/bootstrap.min')] #webjars/bootstrap/3.2.0/css/bootstrap.min
    'bootstrap-datetimepicker': ['bootstrap', 'css!' + libsources.jarpath('bootstrap-datetimepicker', 'css/bootstrap-datetimepicker.min')]
    'bootstrap-datetimepicker.zh_CN': ['bootstrap-datetimepicker']
    'bootstrap-multiselect':['css!'+libsources.jarpath('bootstrap-multiselect', 'css/bootstrap-multiselect')]
    'bootstrapvalidator': ['bootstrap', 'css!' + libsources.jarpath('bootstrapvalidator', 'css/bootstrapValidator.min')]
    'bootstrapvalidator.zh_CN': ['bootstrapvalidator']

    'nprogress': ['jquery', 'css!' + libsources.jarpath('nprogress', 'nprogress')]#webjars/nprogress/0.1.2/nprogress
    'controller': ['css!' + libsources.jarpath('font-awesome', 'css/font-awesome.min'), #webjars/font-awesome/4.1.0/css/font-awesome.min
                   'css!' + libsources.localcss('layout'),'css!' + libsources.localcss('app/signin')]#style/layout
  map:
    '*':
      'css': libsources.jarpath('require-css', 'css') #'webjars/require-css/0.1.4/css' #or whatever the path to require-css is

#  waitSeconds: 1

App = {
  Model: {}
  Controller: {}
  Service: {}
}

require ['app']
