package com.shengmu.function.order;

import cn.dreampie.shiro.core.SubjectKit;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.shengmu.common.web.controller.Controller;
import com.shengmu.function.order.model.Address;
import com.shengmu.function.user.model.User;

/**
 * Created by ice on 14-10-30.
 */
public class AddressController extends Controller {
  static String indexView = "/view/app/address/index.ftl";

  public void index() {
    render(indexView);
  }

  @Before({AddressValidator.class, Tx.class})
  public void save() {
    User user = SubjectKit.getUser();
    Address address = getModel(Address.class);
    if (address.set("user_id", user.get("id")).save()) {
      setSuccess("address", address);
    } else {
      setError();
    }
    render(indexView);
  }

}
