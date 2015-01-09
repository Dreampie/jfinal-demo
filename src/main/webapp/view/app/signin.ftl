<#include "/view/main/layout.tpl.ftl"/>
<!-- build:js javascript/main.js -->
<script data-main="/javascript/main" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layout activebar="index" html_title="首页">
<form class="form-horizontal signin" role="form" method="post" action="/signin">
  <div class="form-group">
    <label class="col-sm-2 control-label">用户名:</label>

    <div class="col-sm-8">
      <input class="form-control" type="text" name="username" value="${(username)!}" placeholder="用户名" required>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">密码:</label>

    <div class="col-sm-8">
      <input class="form-control" type="password" name="password" value="${(password)!}" placeholder="密码" required>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">验证码:</label>

    <div class="col-sm-8">
      <input type="text" name="captcha" value="" class="form-control captcha" ng-minlength="4" ng-maxlength="4"
             placeholder="验证码" required>
      <img class="captcha" src="/captcha?width=128&height=45&fontsize=30&time=${.now?time}">
    </div>
  </div>

  <div class="form-group">
    <label class="col-sm-2 control-label"></label>

    <div class="col-sm-8">
      <div class="checkbox">
        <label>
          <input type="checkbox" name="rememberMe" value="remember-me">记住我
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"></label>

    <div class="col-sm-8">
      <@shiro.isLoginFailure name="shiroLoginFailure">
        <div class="alert alert-danger" style="background-image: none;">
          <@shiro.loginException name="shiroLoginFailure"/>
        </div>
      </@shiro.isLoginFailure>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"></label>

    <div class="col-sm-8">
      <button type="reset" class="btn btn-default">重&nbsp;置</button>
      &nbsp;&nbsp;
      <button type="submit" class="btn btn-primary">登&nbsp;录</button>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"></label>

    <div class="col-sm-8">
      Github大量jfinal插件库，<a href="https://github.com/Dreampie">Dreampie</a><br>
      本项目源码，<a href="https://github.com/Dreampie/jfinal-demo">jfinal-demo</a><br>
      本项目帐号，admin/shengmu<br><br>
      [<span style="color: red;font-size: 16px">强烈推荐</span>] 极简restful+activerecord框架,代码比ssh省至少60%,简洁orm,轻量级(核心代码只有190K左右) 源码链接 <a href="https://github.com/Dreampie/resty">Resty</a><br>
    </div>
  </div>
</form>

</@layout>

