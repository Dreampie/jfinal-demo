package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

import java.util.List;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_address")
public class Address extends Model<Address> {
  public static Address dao = new Address();

  public List<Address> findDetailBy(String where, Object... paras) {
    String selectSql = getSelectSql() + ",`province`.name province_name,`city`.name city_name,`county`.name county_name";
    String fromSql = getFromSql() + " LEFT JOIN com_area `province` ON (`address`.province_id=`province`.id)" +
        " LEFT JOIN com_area `city` ON (`address`.city_id=`city`.id)" +
        " LEFT JOIN com_area `county` ON (`address`.county_id=`county`.id)";
    return dao.find(selectSql + fromSql + getWhere(where), paras);
  }

  public Address findFirstDetailBy(String where, Object... paras) {
    String selectSql = getSelectSql() + ",`province`.name province_name,`city`.name city_name,`county`.name county_name";
    String fromSql = getFromSql() + " LEFT JOIN com_area `province` ON (`address`.province_id=`province`.id)" +
        " LEFT JOIN com_area `city` ON (`address`.city_id=`city`.id)" +
        " LEFT JOIN com_area `county` ON (`address`.county_id=`county`.id)";
    return dao.findFirst(selectSql + fromSql + getWhere(where), paras);
  }
}
