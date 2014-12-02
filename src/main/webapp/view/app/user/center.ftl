<#include "/view/main/layoutframe.tpl.ftl"/>
<!-- build:js javascript/main.js -->
<script data-main="/javascript/app/user/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layoutframe activebar="center" html_title="个人中心">
<div class="page-header">
  <h1>个人中心</h1>
</div>
    <#if user??>
      <form id="update_pwd" class="form-horizontal update" role="form" method="post" action="/user/updatePwd">
        <div class="form-group">
          <label for="username" class="col-sm-2 control-label">用 户 名:</label>

          <div class="col-sm-8">
          ${(user.full_name)!}(${(user.username)!})<br>
          ${(user.branch.name)!}(${(user.phone)!})
          </div>
        </div>
        <div class="form-group">
          <label for="oldPassword" class="col-sm-2 control-label">原 密 码:</label>

          <div class="col-sm-8">
            <input type="password" class="form-control" id="oldPassword" name="oldpassword"
                   placeholder="Oldpassword">
          </div>
        </div>
        <div class="form-group">
          <label for="password" class="col-sm-2 control-label">新 密 码:</label>

          <div class="col-sm-8">
            <input type="password" name="user.password" class="form-control" id="password"
                   placeholder="Password">
          </div>
        </div>
        <div class="form-group">
          <label for="repassword" class="col-sm-2 control-label">重复密码:</label>

          <div class="col-sm-8">
            <input type="password" class="form-control" id="repassword" name="repassword"
                   placeholder="Repassword">
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label"></label>

          <div class="col-sm-8">
            <span class="error" style="color: red">${user_oldpasswordMsg!}</span>
          </div>
        </div>

        <div class="error-box"></div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-8">
            <button type="reset" class="btn btn-default">重置</button>
            <button type="submit" class="btn btn-primary save" data-loading-text="正在保存..."
                    data-complete-text="保存成功!">保存
            </button>
          </div>
        </div>
      </form>
    </#if>
</@layoutframe>

