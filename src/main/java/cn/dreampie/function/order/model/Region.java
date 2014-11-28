package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

import java.util.List;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_region")
public class Region extends Model<Region> {
  public static Region dao = new Region();

  public List<Branch> getBranches() {
    if (this.get("branches") == null) {
      this.set("branches", Branch.dao.findBy("`branch`.region_id=?", this.get("id")));
    }
    return this.get("branches");
  }
}
