<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#macro layout activebar html_title>
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
  <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable = no"/>
  <!--IE兼容模式-->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="shortcut icon" href="/image/favicon.ico"/>
  <title>${html_title}</title>
</head>
<body>
  <#include "/view/main/header.tpl.ftl">
<!--页面内容-->
<div class="container mainer">
  <#nested>
</div>
  <#include "/view/main/footer.tpl.ftl">
<a class="back-top fa fa-angle-up" href="#"></a>

<!-- Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="confirmLabel"></h4>
      </div>
      <div class="modal-body">
        <p id="confirmContent"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary ok">确定</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
</#macro>