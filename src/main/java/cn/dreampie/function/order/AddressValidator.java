package cn.dreampie.function.order;

import cn.dreampie.ValidateKit;
import cn.dreampie.function.order.model.Address;
import cn.dreampie.web.ReturnKit;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class AddressValidator extends Validator {

  @Override
  protected void validate(Controller c) {
    if (getActionKey().equals("/address/save")) {
      boolean nameEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.name"));
      if (nameEmpty) addError("address_name_msg", "姓名不能为空");

      boolean phoneEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.phone"));
      if (phoneEmpty) addError("address_phone_msg", "电话不能为空");
      if (!phoneEmpty && !ValidateKit.isPhone(c.getPara("address.phone")))
        addError("address_phone_msg", "电话格式不正确");

      boolean provinceIdEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.province_id"));
      if (provinceIdEmpty) this.addError("address_province_id_msg", "省份不能为空");
      if (!provinceIdEmpty && !ValidateKit.isPositiveNumber(c.getPara("address.province_id")))
        addError("address_province_id_msg", "省份数据格式错误");

      boolean cityIdEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.city_id"));
      if (cityIdEmpty) addError("address_city_id_msg", "市区不能为空");
      if (!cityIdEmpty && !ValidateKit.isPositiveNumber(c.getPara("address.city_id")))
        addError("address_city_id_msg", "市区数据格式错误");

      boolean countyIdEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.county_id"));
      if (countyIdEmpty) addError("address_county_id_msg", "城镇不能为空");
      if (!countyIdEmpty && !ValidateKit.isPositiveNumber(c.getPara("address.county_id")))
        addError("address_county_id_msg", "城镇数据格式错误");

      boolean streetEmpty = ValidateKit.isNullOrEmpty(c.getPara("address.street"));
      if (streetEmpty) addError("address_street_msg", "街道不能为空");
    }
  }

  @Override
  protected void handleError(Controller c) {
    c.keepModel(Address.class);
    c.keepPara();
    c.setAttr("state", "failure");
    if (ReturnKit.isJson(c.getRequest()))
      c.renderJson();
    else {
      if (getActionKey().equals("/address/save"))
        c.forwardAction("/address/build");
    }
  }
}
