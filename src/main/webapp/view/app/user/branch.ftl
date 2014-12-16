<#include "/view/main/layoutframe.tpl.ftl"/>
<!-- build:js javascript/main.js -->
<script data-main="/javascript/app/member/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layoutframe activebar="member" html_title="用户管理">
<form class="form-inline branch" role="form" action="/member/branch" method="get">
  <div class="form-group">
    <label class="control-label" style="text-align: left;width: 100px;">区域/支行:</label>

    <select name="region_id" select="${region_id!}">
      <#if regions?? && regions?size gt 0>
        <#list regions as region>
          <option value="${region.id}">${region.name}</option>
        </#list>
      </#if>
      <option value="" selected="selected">请选择</option>
    </select>
    <select name="branch_id" select="${(branch_id)!}">
      <option value="" selected="selected">请选择</option>
    </select>

  </div>

  <div class="form-group">
    <button type="submit" class="btn btn-primary">搜索</button>
  </div>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <div class="form-group pull-right">
    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#saveModal">新用户</button>
  </div>
</form>

<table class="table table-bordered table-hover">
  <thead>
  <tr>
    <th>姓名</th>
    <th>支行</th>
    <th>机构代码</th>
    <th>联系电话</th>
    <th>登录名</th>
    <th>创建时间</th>
    <th>状态</th>
    <@shiro.hasPermission name="P_USER_CONTROL">
      <th>操作</th>
    </@shiro.hasPermission>
  </tr>
  </thead>
  <tbody>
    <#if users?? && users.list?size gt 0>
      <#list users.list as user>
      <tr>
        <td>${(user.full_name)!}</td>
        <td>${(user.branch_name)!}</td>
        <td>${(user.branch_code)!}</td>
        <td>${(user.phone)!}</td>
        <td>${(user.username)!}</td>
        <td>${(user.created_at)!}</td>
        <td>
          <#if user.deleted_at??>
            已删除
          <#else>
            正常
          </#if>
        </td>
        <@shiro.hasPermission name="P_USER_CONTROL">
          <td>
            <a class="update" firstname="${user.first_name}" lastname="${user.last_name}" branchid="${user.branch_id}" regionid="${user.region_id}"
               username="${user.username}" userid="${user.id}" phone="${user.phone}" deletedat="${(user.deleted_at)!}" href="#updateModal"
               data-toggle="modal">修改</a>
            <#if user.deleted_at??><#else>
              <a class="delete" userid="${user.id}" href="#confirmModal" data-toggle="modal"
                 data-label="删除" data-content="确认删除？">删除</a>
            </#if>
          </td>
        </@shiro.hasPermission>
      </tr>
      </#list>
    </#if>
  </tbody>
</table>
  <#if orders?? && orders.list?size gt 0>
    <@paginate currentPage=orders.pageNumber totalPage=orders.totalPage actionUrl=_localUri urlParas=_localParas className="pagination"/>
  </#if>


<div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="saveLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="saveLabel">新用户</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal save" id="saveForm" role="form" action="/member/control" method="post">
          <input type="hidden" name="do" value="save">

          <div class="form-group">
            <label class="col-sm-2 control-label">区域:</label>

            <div class="col-sm-8">
              <select name="region_id" select="${region_id!}">
                <#if regions?? && regions?size gt 0>
                  <#list regions as region>
                    <option value="${region.id}">${region.name}</option>
                  </#list>
                </#if>
                <option value="" selected="selected">请选择</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">支行:</label>

            <div class="col-sm-8">
              <select name="branch_id" select="${(branch_id)!}">
                <option value="" selected="selected">请选择</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">姓名:</label>

            <div class="col-sm-8">
              <div class="input-group">
                <input class="form-control" style="width: 20%;padding-right: 12px !important;" type="text" name="user.last_name"
                       value="${(user.last_name)!}"
                       placeholder="姓">
                <input class="form-control" style="width: 25%;padding-right: 12px !important;" type="text" name="user.first_name"
                       value="${(user.first_name)!}"
                       placeholder="名">
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">联系电话:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="user.phone" value="${(user.phone)!}"
                     placeholder="联系电话">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">登录帐号:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="user.username" value=""
                     placeholder="登录帐号">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="password" name="user.password" value=""
                     placeholder="密码">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">确认密码:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="password" name="repassword" value="${(repassword)!}"
                     placeholder="确认密码">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"></label>

            <div class="col-sm-8">
              <span style="color: red" class="error">${user_usernameMsg!}</span>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary ok">确定</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="updateLabel">修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal update" id="updateForm" role="form" action="/member/control" method="post">
          <input type="hidden" name="do" value="update">
          <input type="hidden" name="user.id" value="">

          <div class="form-group">
            <label class="col-sm-2 control-label">区域:</label>

            <div class="col-sm-8">
              <select name="region_id" select="${region_id!}">
                <#if regions?? && regions?size gt 0>
                  <#list regions as region>
                    <option value="${region.id}">${region.name}</option>
                  </#list>
                </#if>
                <option value="" selected="selected">请选择</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">支行:</label>

            <div class="col-sm-8">
              <select name="branch_id" select="${(branch_id)!}">
                <option value="" selected="selected">请选择</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">姓名:</label>

            <div class="col-sm-8">
              <div class="input-group">
                <input class="form-control" style="width: 20%;padding-right: 12px !important;" type="text" name="user.last_name"
                       value="${(user.last_name)!}"
                       placeholder="姓">
                <input class="form-control" style="width: 25%;padding-right: 12px !important;" type="text" name="user.first_name"
                       value="${(user.first_name)!}"
                       placeholder="名">
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">联系电话:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="user.phone" value="${(user.phone)!}"
                     placeholder="联系电话">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">登录帐号:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="user.username" value=""
                     placeholder="登录帐号">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="user.password" value=""
                     placeholder="密码">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">确认密码:</label>

            <div class="col-sm-8">
              <input class="form-control" style="width: 60%" type="text" name="repassword" value="${(repassword)!}"
                     placeholder="确认密码">
            </div>
          </div>
          <div class="form-group deleted_at" style="display: none">
            <label class="col-sm-2 control-label">删除时间:</label>

            <div class="col-sm-8">
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="reuse" value="true"><span></span>(选中重新启用)
                </label>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"></label>

            <div class="col-sm-8">
              <span style="color: red" class="error">${user_usernameMsg!}</span>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary ok">确定</button>
      </div>
    </div>
  </div>
</div>
</@layoutframe>

