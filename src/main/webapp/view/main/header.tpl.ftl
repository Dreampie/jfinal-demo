<div class="nav-top">
  <div class="container">
    <ul class="list-inline pull-right">
    <@shiro.authenticated>
      <li><a href="/user/center">
        <@shiro.principal name="full_name"/>
      </a></li>
      |
      <li><a href="/signout">退出</a></li>
    </@shiro.authenticated>
    <@shiro.notAuthenticated>
      <li><a href="/">登陆</a></li>
    </@shiro.notAuthenticated>
    </ul>
  </div>
</div>
<div class="navbar navbar-static-top hidden-print">
  <div class="container nav-menu">
    <div class="navbar-header">
      <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
        <span class="sr-only">Toggle navigation</span> <span
          class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span></button>
      <a class="navbar-brand logo" href="/"><img alt="Brand" src="/image/app/logo.png"></a></div>
    <div class="navbar-collapse collapse bs-navbar-collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/order" class="<#if activebar=='order'>nav-active</#if>">我的订单</a></li>
        <li><a href="/order/build" class="<#if activebar=='build'>nav-active</#if>">新订单</a></li>
      <@shiro.hasPermission name="P_ORDER_CONTROL">
        <li><a href="/order/branch" class="<#if activebar=='branch'>nav-active</#if>">全部订单</a></li>
      </@shiro.hasPermission>
      <@shiro.hasPermission name="P_REGION_CONTROL">
        <li><a href="/order/region" class="<#if activebar=='region'>nav-active</#if>">全部支行</a></li>
      </@shiro.hasPermission>
      <@shiro.hasPermission name="P_USER_CONTROL">
        <li><a href="/member" class="<#if activebar=='member'>nav-active</#if>">全部用户</a></li>
      </@shiro.hasPermission>
        <li><a href="/user/center" class="<#if activebar=='center'>nav-active</#if>">个人中心</a></li>

      </ul>
    </div>
  </div>
</div>