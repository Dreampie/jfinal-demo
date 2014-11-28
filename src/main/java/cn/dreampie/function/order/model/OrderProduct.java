package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_order_product")
public class OrderProduct extends Model<OrderProduct> {
  public static OrderProduct dao=new OrderProduct();

}
