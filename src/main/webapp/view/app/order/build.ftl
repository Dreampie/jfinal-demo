<#include "/view/main/layoutframe.tpl.ftl"/>
<!-- build:js  -->
<script data-main="/javascript/app/order/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layoutframe activebar="build" html_title="新订单">


<form class="form-horizontal save" id="saveForm" role="form" action="/order/save" method="post">
  <div class="form-group">
    <label class="col-sm-3 control-label">品类:</label>

    <div class="col-sm-7">
      <select name="orderProduct.product_id">
        <#if products?? && products?size gt 0>
          <#list products as product>
            <option value="${product.id}" <#if product.id==1 >selected="selected" </#if> price="${product.price}">${product.category}
              -${product.name}</option>
          </#list>
        </#if>
        <option value="">请选择</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label">数量:</label>

    <div class="col-sm-7">
      <input class="form-control" type="text" name="orderProduct.num" value="${(orderProduct.num)!10}"
             placeholder="数量">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label">送货日期:</label>

    <div class="col-sm-7">
      <div class="input-group date form_datetime" data-date="${.now?string('yyyy/MM/dd')}" data-start-date="${.now?string('yyyy/MM/dd')}"
           data-date-format="yyyy/mm/dd">
        <input readonly class="form-control" size="10" type="text" name="order.delivered_at"
               value="${.now?string('yyyy/MM/dd')}">
      <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
      </div>
      <div class="tip"><i class="fa fa-lightbulb-o"></i>按您所在的区域选择规定时间</div>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label">收货地址:</label>

    <div class="col-sm-7">
      <select name="order.address_id" select="${(order.address_id)!}">
        <#if addresses?? && addresses?size gt 0>
          <#list addresses as address>
            <option value="${address.id}" provinceid="${address.province_id}" cityid="${address.city_id}" countyid="${address.county_id}"
                    street="${address.street}" addressname="${address.name}" phone="${address.phone}" sparename="${(address.spare_name)!}"
                    sparephone="${(address.spare_phone)!}">${address.name}</option>
          </#list>
        </#if>
        <option value="" selected="selected">请选择</option>
      </select>

      <a id="newadr" class="btn btn-default" tabindex="-1" href="javascript:void(0);" value="">新建</a>
    </div>
  </div>

  <div class="form-group">
    <label class="col-sm-3 control-label"></label>

    <div class="col-sm-7">
      <div class="tip addressDetail" style="padding: 10px;"></div>
    </div>
  </div>

  <div id="newadrDiv" style="display: none">
    <div class="form-group">
      <label class="col-sm-3 control-label">收货人:</label>

      <div class="col-sm-7">
        <input class="form-control" type="text" name="address.name" value="${(address.name)!}"
               placeholder="收货人">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">电话:</label>

      <div class="col-sm-7">
        <input class="form-control" type="text" name="address.phone" value="${(address.phone)!}"
               placeholder="电话">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">备用收货人:</label>

      <div class="col-sm-7">
        <input class="form-control" type="text" name="address.spare_name"
               value="${(address.spare_name)!}" placeholder="备用收货人">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">备用电话:</label>

      <div class="col-sm-7">
        <input class="form-control" type="text" name="address.spare_phone"
               value="${(address.spare_phone)!}" placeholder="备用电话">
      </div>
    </div>
  <#--<div class="form-group">-->
  <#--<label class="col-sm-3 control-label">邮编:</label>-->

  <#--<div class="col-sm-7">-->
  <#--<input class="form-control" type="text" name="address.zip_code" value="${(address.zip_code)!}" placeholder="邮编">-->
  <#--</div>-->
  <#--</div>-->
    <div class="form-group">
      <label class="col-sm-3 control-label">省市县:</label>

      <div class="col-sm-7 pcc">
        <select class="province" name="address.province_id">
          <option value="" selected="selected">请选择</option>
        </select>
        <select class="city" name="address.city_id">
          <option value="" selected="selected">请选择</option>
        </select>
        <select class="county" name="address.county_id">
          <option value="" selected="selected">请选择</option>
        </select>
        <br>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">街道:</label>

      <div class="col-sm-7">
        <input class="form-control" type="text" name="address.street" value="${(address.street)!}"
               placeholder="街道">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label"></label>

      <div class="col-sm-7">
        <button id="newadrRstBtn" type="button" class="btn btn-default">重置</button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button id="newadrBtn" type="button" class="btn btn-primary">保存地区</button>
      </div>
    </div>
  </div>

  <div class="form-group">
    <label class="col-sm-3 control-label"></label>

    <div class="col-sm-7 settlement">
      <ul class="list-unstyled pull-right ">
        <li><label>金额:</label>￥<span class="total_pay">0.00</span></li>
        <li><label>数量:</label><span class="num">0</span>提</li>
        <li><label>送货日期:</label><span class="delivered_at"></span></li>
      </ul>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label"></label>

    <div class="col-sm-7">
      <button type="button" class="btn btn-danger pull-right submit">提交订单</button>
    </div>
  </div>
</form>

</@layoutframe>