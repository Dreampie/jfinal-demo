package cn.dreampie.function.order;

import cn.dreampie.ValidateKit;
import cn.dreampie.function.order.model.Order;
import cn.dreampie.web.ReturnKit;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import cn.dreampie.function.order.model.OrderProduct;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class OrderValidator extends Validator {

  @Override
  protected void validate(Controller c) {
    if (getActionKey().equals("/order/save")) {
      boolean numEmpty = ValidateKit.isNullOrEmpty(c.getPara("orderProduct.num"));
      if (numEmpty) addError("orderProduct_num_msg", "产品数量不能为空");
      if (!numEmpty && !ValidateKit.isNumber(c.getPara("orderProduct.num")))
        addError("orderProduct_num_msg", "产品数量必须是数字");

      boolean daEmpty = ValidateKit.isNullOrEmpty(c.getPara("order.delivered_at"));
      if (daEmpty) addError("order_delivered_at_msg", "发货时间不能为空");
      if (!daEmpty && !ValidateKit.isDateTime(c.getPara("order.delivered_at")))
        addError("order_delivered_at_msg", "发货时间不是时间格式");
    } else if (getActionKey().equals("/order/control") || getActionKey().equals("/order/update")) {

      boolean idEmpty = ValidateKit.isNullOrEmpty(c.getPara("order.id"));
      if (idEmpty) addError("order_id_msg", "id不能为空");
      if (!idEmpty && !ValidateKit.isNumber(c.getPara("order.id")))
        addError("order_id_msg", "id必须是数字");
    }
  }

  @Override
  protected void handleError(Controller c) {
    c.keepModel(Order.class);
    c.keepModel(OrderProduct.class);
    c.keepPara();
    c.setAttr("state", "failure");
    if (ReturnKit.isJson(c.getRequest()))
      c.renderJson();
    else {
      if (getActionKey().equals("/order/save")) {
        c.render("/view/app/order/build.ftl");
      } else if (getActionKey().equals("/order/update")) {
        c.render("/view/app/order/detail.ftl");
      }
    }
  }

}
