package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_address")
public class Address extends Model<Address> {
  public static Address dao=new Address();
}
