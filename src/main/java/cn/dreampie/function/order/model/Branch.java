package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;
import cn.dreampie.function.user.model.User;

import java.util.List;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_branch")
public class Branch extends Model<Branch> {
  public static Branch dao=new Branch();

  public List<User> getUsers(){
    if(this.get("users")!=null){
      this.set("users",User.dao.findByBranch("`userBranch`.branch_id",this.getLong("id")));
    }
    return this.get("users");
  }
}
