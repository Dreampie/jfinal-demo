<#include "/view/main/layoutframe.tpl.ftl"/>
<#include "/view/main/pagination.tpl.ftl"/>
<!-- build:js -->
<script data-main="/javascript/app/order/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layoutframe activebar="region" html_title="全部支行">
<form class="form-inline region" role="form" action="/order/region" method="get">
  <div class="form-group">
    <label class="control-label" style="text-align: left;width: 64px;">区域:</label>

    <select name="region_id" select="${region_id!}">
      <#if regions?? && regions?size gt 0>
        <#list regions as region>
          <option value="${region.id}">${region.name}</option>
        </#list>
      </#if>
      <option value="" selected="selected">请选择</option>
    </select>
  </div>
  <div class="form-group">
    <div class="input-group date form_datetime" data-date="${.now?string('yyyy-MM')}"
         data-date-format="yyyy-mm">
      <input readonly class="form-control" size="7" type="text" name="started_at"
             value="${.now?string('yyyy-MM')}">
      <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
    </div>
  </div>
  <div class="form-group">
    <button type="submit" class="btn btn-primary submit">搜索</button>
  </div>
</form>
<ul class="nav nav-tabs menu-tabs" role="tablist" style="margin-bottom: 10px">
  <li role="presentation" class="<#if state?? && state!=''><#else>active</#if>"><a href="#">全部</a></li>
  <li role="presentation" class="<#if state?? && state=='1'>active</#if>"><a href="#"
                                                                             value="1">已收货</a></li>
  <li role="presentation" class="<#if state?? && state=='2'>active</#if>"><a href="#"
                                                                             value="2">已付款</a></li>
</ul>
<table class="table table-bordered table-hover">
  <thead>
  <tr>
    <th>支行名称</th>
    <th>总价格</th>
    <th>总支付</th>
    <#if products?? && products?size gt 0>
      <#list products as product>
        <th>${product.name}</th>
      </#list>
    </#if>
    <th>总数量</th>
  </tr>
  </thead>
  <tbody>
    <#if orders?? && orders?size gt 0>
      <#list orders as order>
      <tr>
        <td>${(order.branch_name)!'无'}</td>
        <td>${(((order.total_pay)!0)/100)?string('0.00')}</td>
        <td>${(((order.actual_pay)!0)/100)?string('0.00')}</td>
        <#if products?? && products?size gt 0>
          <#assign p_num=0/>
          <#list products as product>
            <#assign p_num=p_num+(order['product_'+product.id])!0/>
            <td>${(order['product_'+product.id])!0}</td>
          </#list>
        </#if>
        <td>
        ${p_num}
        </td>
      </tr>
      </#list>
    </#if>
  </tbody>
</table>
</@layoutframe>