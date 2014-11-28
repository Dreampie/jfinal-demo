package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

import java.util.List;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_product")
public class Product extends Model<Product> {
  public static Product dao = new Product();

  public List<Product> findByOrder(String where,Object...paras) {
    String sql = "SELECT `product`.*,`orderProduct`.num FROM ord_product `product` LEFT JOIN ord_order_product `orderProduct` ON(`product`.id=`orderProduct`.product_id) "+getWhere(where);
    return dao.find(sql, paras);
  }
}
