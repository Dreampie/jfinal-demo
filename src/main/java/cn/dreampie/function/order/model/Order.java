package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;
import com.jfinal.plugin.activerecord.Page;
import org.joda.time.DateTime;

import java.util.List;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_order")
public class Order extends Model<Order> {
  public static Order dao = new Order();

  public List<Product> getProducts() {
    if (this.get("products") == null) {
      this.put("products", Product.dao.findByOrder("`orderProduct`.order_id=?", this.get("id")));
    }
    return this.get("products");
  }


  public boolean receive() {
    this.set("state", 1);
    return this.update();
  }

  public boolean deliver() {
    this.set("state", 2);
    this.set("actual_delivered_at", DateTime.now().toString("yyyy-MM-dd hh:mm:ss"));
    return this.update();
  }

  public boolean receipt() {
    this.set("state", 3);
    this.set("receipted_at", DateTime.now().toString("yyyy-MM-dd hh:mm:ss"));
    return this.update();
  }

  public boolean pay() {
    this.set("state", 4);
    this.set("payed_at", DateTime.now().toString("yyyy-MM-dd hh:mm:ss"));
    return this.update();
  }

  public List<Order> findByBranch(String where, Object... paras) {
    String sql = "SELECT `order`.* FROM ord_order `order` " + getWhere(where);
    return dao.find(sql, paras);
  }

  public Page<Order> paginateByBranch(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = " SELECT `order`.* ";
    String fromSql = " FROM ord_order `order`";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }

  public List<Order> findByRegion(String where, Object... paras) {
    String sql = "SELECT `order`.* FROM ord_order `order`" +
        " LEFT JOIN ord_branch `branch` ON(`order`.branch_id=`branch`.id)" + getWhere(where);
    return dao.find(sql, paras);
  }

  public Page<Order> paginateByRegion(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = " SELECT `order`.* ";
    String fromSql = " FROM ord_order `order`" +
        " LEFT JOIN ord_branch `branch` ON(`order`.branch_id=`branch`.id)" ;
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }

}
