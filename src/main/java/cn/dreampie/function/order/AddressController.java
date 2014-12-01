package cn.dreampie.function.order;

import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.order.model.Address;
import cn.dreampie.shiro.core.SubjectKit;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import cn.dreampie.function.user.model.User;

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
    if (user.getAddresses() == null || user.getAddresses().size() <= 0)
      address.set("is_default", 1);
    if (address.set("user_id", user.get("id")).save()) {
      setSuccess("address", address);
    } else {
      setError();
    }
    render(indexView);
  }

  public void query() {
    User user = SubjectKit.getUser();
    if (user.getLong("id") != null)
      setAttr("addresses", user.getAddresses());
    render(indexView);
  }
}
