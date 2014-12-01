<#include "/view/main/layoutframe.tpl.ftl"/>
<#include "/view/main/pagination.tpl.ftl"/>
<!-- build:js -->
<script data-main="/javascript/app/order/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layoutframe activebar="order" html_title="我的订单">
<table class="table table-bordered table-hover" style="<#if data_type?? && data_type?contains('order')>width: 1400px;</#if>">
  <thead>
  <tr>
    <th>订单编号</th>
    <th>产品</th>
    <th>数量</th>
    <th>总价</th>
    <th>下单时间</th>
    <th>发货时间</th>
    <th>状态</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
    <#if orders?? && orders.list?size gt 0>
      <#list orders.list as order>
      <tr>
        <td>${order.code}</td>
        <td>
          <#list order.products as product>
            ${product.name}
          </#list>
        </td>
        <td>
          <#if order.products?? && order.products?size gt 0>
              <#list order.products as product>
          ${product.num}
          </#list>
            </#if>
        </td>
        <td>${(((order.actual_pay)!0)/100)?string('0.00')}</td>
        <td>${order.created_at?string('yyyy-MM-dd hh:mm:ss')}</td>
        <td>${order.delivered_at?string('yyyy-MM-dd')}</td>
        <td>
          <#if states?? && states?size gt 0>
          <#list states as state>
            <#if order.state==state.value>
            ${state.name}
            </#if>
          </#list>
        </#if>
        </td>
        <td>
          <a class="detail" orderid="${order.id}" href="#detailModal" data-toggle="modal">详情</a>
          <#if order.state==3>
            <#if order.payed_at??>
            <#else>
              <#--<a class="pay">付款</a>-->
            </#if>
          </#if>
          <#if order.state==2>
            <#if order.receipted_at??>
            <#else>
              <a class="receipt" orderid="${order.id}" href="#confirmModal" data-toggle="modal" data-label="收货" data-content="确认收货？">收货</a>
            </#if>
          </#if>

          <#if order.state gte 0 && order.state lte 1>
            <a class="cancel" orderid="${order.id}" href="#confirmModal" data-toggle="modal" data-label="取消" data-content="确认取消？">取消</a>
          </#if>
        </td>
      </tr>
      </#list>
    </#if>
  </tbody>
</table>
  <#if orders?? && orders.list?size gt 0>
    <@paginate currentPage=orders.pageNumber totalPage=orders.totalPage actionUrl=_localUri urlParas=_localParas className="pagination"/>
  </#if>

  <#include "/view/app/order/detail.tpl.ftl"/>
</@layoutframe>
