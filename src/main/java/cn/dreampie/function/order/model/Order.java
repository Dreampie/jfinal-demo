package cn.dreampie.function.order.model;

import cn.dreampie.PinyinSortKit;
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

  public Address getAddress(){
    if (this.get("address") == null) {
      this.put("address", Address.dao.findFirstDetailBy("`address`.id=?", this.get("address_id")));
    }
    return this.get("address");
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
        " LEFT JOIN ord_branch `branch` ON(`order`.branch_id=`branch`.id)";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }

  public List<Order> sumByRegion(String where, Object... paras) {

    String selectSql = "SELECT `branch`.name branch_name,SUM(`order`.total_pay) total_pay,SUM(`order`.actual_pay) actual_pay,";
    List<Product> products = Product.dao.findBy("`product`.deleted_at is null");
    int i = 1;
    int size = products.size();
    for (Product product : products) {
      selectSql += "SUM(IF(`orderProduct`.product_id=" + product.get("id") + ",`orderProduct`.num,0)) as product_" + product.get("id");
      if (i != size) {
        selectSql += ",";
      }
      i++;
    }

    String fromSql = " FROM ord_order `order` " +
        " LEFT JOIN ord_order_product `orderProduct` ON(`order`.id=`orderProduct`.order_id) " +
        " LEFT JOIN ord_branch `branch` ON(`order`.branch_id=`branch`.id) ";
    return dao.find(selectSql + fromSql + getWhere(where), paras);
  }

}
