package cn.dreampie.function.order.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

/**
 * Created by ice on 14-10-29.
 */
@TableBind(tableName = "ord_user_branch")
public class UserBranch extends Model<UserBranch> {
  public static UserBranch dao=new UserBranch();
}
