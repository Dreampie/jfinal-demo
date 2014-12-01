package cn.dreampie.function.order;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.common.model.State;
import cn.dreampie.function.order.model.*;
import cn.dreampie.shiro.core.SubjectKit;
import cn.dreampie.web.cache.CacheRemove;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.plugin.ehcache.CacheName;
import cn.dreampie.function.user.model.User;
import org.joda.time.DateTime;

import java.util.List;

/**
 * Created by ice on 14-10-30.
 */
public class OrderController extends Controller {
  static String indexView = "/view/app/order/index.ftl";

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void index() {
    User user = SubjectKit.getUser();
    Integer pageNum = getParaToInt(0, 1);
    Integer pageSize = getParaToInt("pageSize", 15);
    Page<Order> orders = user.getOrders(pageNum, pageSize);
    setAttr("orders", orders);
    setAttr("states", State.dao.findBy("`state`.type=? AND `state`.deleted_at is null", "order.state"));
    render(indexView);
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void query() {
    Order o = getModel(Order.class);
    if (o != null && o.get("id") != null) {
      Order result = Order.dao.findFirstBy("`order`.id=?", o.get("id"));
      result.getAddress();
      result.getProducts();
      setAttr("order", result);
    }
    render(indexView);
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void build() {
    setAttr("products", Product.dao.findBy("deleted_at is null"));
    List<Address> addresses = Address.dao.findBy(" `address`.user_id=? AND deleted_at is null", SubjectKit.getUser().get("id"));
    for (Address address : addresses)
      if (address.getInt("is_default") == 1)
        setAttr("order", new Order().set("address_id", address.get("id")));
    setAttr("addresses", addresses);
    render("/view/app/order/build.ftl");
  }

  @CacheRemove(name = AppConstants.DEFAULT_CACHENAME)
  @Before({Tx.class, OrderValidator.class})
  public void save() {
    User user = SubjectKit.getUser();
    Order order = getModel(Order.class);
    OrderProduct orderProduct = getModel(OrderProduct.class);
    order.set("user_id", user.get("id"));
    Product product = Product.dao.findFirstBy("`product`.id=?", orderProduct.get("product_id"));
    Long total_pay = product.getLong("price") * orderProduct.getInt("num");
    order.set("code", DateTime.now().toString("yyMMddhhmmssms"));
    order.set("total_pay", total_pay);
    order.set("actual_pay", total_pay);
    order.set("branch_id", user.getBranchId());
    if (order.save()) {
      orderProduct.set("order_id", order.get("id"));
      if (orderProduct.save())
        setSuccess();
      else
        setError();
    } else
      setError();
    redirect("/order");
  }

  @CacheRemove(name = AppConstants.DEFAULT_CACHENAME)
  @Before({Tx.class, OrderValidator.class})
  public void control() {
    Order order = getModel(Order.class);
    String todo = getPara("do");
    boolean result = false;
    if (todo != null) {
      if (todo.equals("receive"))
        result = order.receive();
      if (todo.equals("deliver"))
        result = order.deliver();
    }
    if (result) {
      setAttr("order", order);
      setSuccess();
    } else
      setError();
    render("/view/app/order/detail.ftl");
  }


  @CacheRemove(name = AppConstants.DEFAULT_CACHENAME)
  @Before({Tx.class, OrderValidator.class})
  public void update() {
    Order order = getModel(Order.class);
    String todo = getPara("do");
    boolean result = false;
    if (todo == null) {
      if (order.getInt("state") == -1 || order.getInt("state") == 1)
        result = new Order().set("id", order.get("id")).set("state", order.get("state")).update();
    } else {
      if (todo.equals("receipt"))
        result = order.receipt();
    }
    if (result) {
      setAttr("order", order);
      setSuccess();
    } else
      setError();
    render("/view/app/order/detail.ftl");
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void region() {
    keepPara("region_id", "state", "started_at");
    //region
    Long regionId = getParaToLong("region_id");
    if (regionId == null) regionId = 1L;

    Integer state = getParaToInt("state");
    String where = "`branch`.region_id=? AND";
    String started_at = getPara("started_at");
    List<Order> orders = null;
    if (started_at == null) {
      started_at = DateTime.now().toString("yyyy-MM");
      setAttr("started_at", started_at);
    }
    if (state == null) {
      where += " DATE_FORMAT(`order`.receipted_at,'%Y-%m')=? OR DATE_FORMAT(`order`.payed_at,'%Y-%m')=? ";
      orders = Order.dao.sumByRegion(where, regionId, started_at, started_at);
    } else {
      if (state == 1) {
        where += " DATE_FORMAT(`order`.receipted_at,'%Y-%m')=? AND `order`.payed_at is null ";
      } else {
        where += " DATE_FORMAT(`order`.payed_at,'%Y-%m')=? ";
      }
      orders = Order.dao.sumByRegion(where, regionId, started_at);
    }
/**
 * SELECT `branch`.name branch_name,SUM(`order`.total_pay) total_pay,SUM(`order`.actual_pay) actual_pay,
 * SUM(IF(`orderProduct`.product_id=1,`orderProduct`.num,0)) as product_1
 * FROM ord_order `order`  LEFT JOIN ord_order_product `orderProduct` ON(`order`.id=`orderProduct`.order_id)
 * LEFT JOIN ord_branch `branch` ON(`order`.branch_id=`branch`.id)
 * WHERE `branch`.region_id=? AND DATE_FORMAT(`order`.receipted_at,'%Y-%m')=? OR DATE_FORMAT(`order`.payed_at,'%Y-%m')=?
 */
    setAttr("regions", Region.dao.findBy("`region`.deleted_at is null"));
    setAttr("orders", orders);
    setAttr("products", Product.dao.findBy("`product`.deleted_at is null"));
    render("/view/app/order/region.ftl");
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void branch() {
    keepModel(Order.class);
    keepPara();
    Integer pageNum = getParaToInt(0, 1);
    Integer pageSize = getParaToInt("pageSize", 15);
    Order order = getModel(Order.class);
    String where = "";

    if (order.getInt("state") != null) {
      where = "`order`.state=" + order.getInt("state") + " AND ";
    }
    String orderby=" ORDER BY `order`.created_at DESC ";
    //branch
    Page<Order> orders = null;
    if (order.get("branch_id") == null) {
      //region
      Long regionId = getParaToLong("region_id");
      if (regionId == null)
        orders = Order.dao.paginateBy(pageNum, pageSize, where + " `order`.deleted_at is null "+orderby);
      else
        orders = Order.dao.paginateByRegion(pageNum, pageSize, where + " `branch`.region_id=? "+orderby, regionId);
    } else
      orders = Order.dao.paginateByBranch(pageNum, pageSize, where + " `order`.branch_id=? "+orderby, order.get("branch_id"));

    setAttr("states", State.dao.findBy("`state`.type=? AND `state`.deleted_at is null", "order.state"));
    setAttr("regions", Region.dao.findBy("`region`.deleted_at is null"));
    setAttr("orders", orders);
    render("/view/app/order/branch.ftl");
  }

}
