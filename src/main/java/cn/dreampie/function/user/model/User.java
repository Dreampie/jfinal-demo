package cn.dreampie.function.user.model;

import cn.dreampie.ValidateKit;
import cn.dreampie.function.order.model.Address;
import cn.dreampie.function.order.model.Branch;
import cn.dreampie.function.order.model.Order;
import cn.dreampie.function.order.model.UserBranch;
import cn.dreampie.sqlinxml.SqlKit;
import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;
import com.jfinal.plugin.activerecord.Page;
import org.apache.commons.lang3.ArrayUtils;

import java.util.Date;
import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_user")
public class User extends Model<User> {
  public static User dao = new User();

  public User addUserInfo(UserInfo userInfo) {
    if (ValidateKit.isNullOrEmpty(userInfo)) {
      userInfo = new UserInfo();
      userInfo.set("user_id", this.get("id"));
    }
    userInfo.set("created_at", new Date());
    userInfo.save();
    return this;
  }

  public User addRole(Role role) {
    if (ValidateKit.isNullOrEmpty(role)) {
      role = Role.dao.findFirstBy("`role`.value='R_USER'");
      if (ValidateKit.isNullOrEmpty(role)) {
        throw new NullPointerException("角色不存在");
      }
    }
    UserRole userRole = new UserRole();
    userRole.set("user_id", this.get("id"));
    userRole.set("role_id", role.get("id"));
    userRole.save();
    return this;
  }

  public User addBranch(Branch branch) {
    if (ValidateKit.isNullOrEmpty(branch)) {
      branch = Branch.dao.findById(1);
      if (ValidateKit.isNullOrEmpty(branch)) {
        throw new NullPointerException("支行不存在");
      }
    }
    UserBranch userBranch = new UserBranch();
    userBranch.set("user_id", this.get("id"));
    userBranch.set("branch_id", branch.get("id"));
    userBranch.save();
    return this;
  }

  public Role getRole() {
    return Role.dao.findById(getRoleId());
  }

  public Long getRoleId() {
    return UserRole.dao.findFirstBy("`userRole`.user_id=?", this.get("id")).get("role_id");
  }

  public List<Role> getRoleChildren() {
    if (this.get("roleChildren") == null) {
      //查询当前用户的角色
      UserRole userRole = UserRole.dao.findFirstBy("`userRole`.user_id=" + this.get("id"));
      //当前用户的子集角色
      List<Role> roles = Role.dao.findChildrenById("`role`.deleted_at is null", userRole.get("role_id"));
      this.put("roleChildren", roles);
    }
    return this.get("roleChildren");
  }

  public long[] getRoleChildrenIds() {
    if (this.get("roleChildrenIds") == null) {
      List<Role> roles = getRoleChildren();
      long[] roleIds = new long[roles.size()];
      if (roles != null) {
        int i = 0;
        for (Role role : roles) {
          roleIds[i] = role.getLong("id");
          i++;
        }
      }
      this.put("roleChildrenIds", roleIds);
    }
    return (long[]) this.get("roleChildrenIds");
  }

  public String getRoleChildrenIdsStr() {
    if (this.get("roleChildrenIdsStr") == null) {
      long[] ids = getRoleChildrenIds();
      ArrayUtils.toString(ids, ",");
      String idsStr = "";
      int i = 0;
      int size = ids.length;
      for (long id : ids) {
        idsStr += id + "";
        if (i < size - 1) {
          idsStr += ",";
        }
        i++;
      }
      this.put("roleChildrenIdsStr", idsStr);
    }
    return this.get("roleChildrenIdsStr");
  }

  public Branch getBranch() {
    if (this.get("branch") == null)
      this.put("branch", Branch.dao.findById(getBranchId()));
    return this.get("branch");
  }

  public Long getBranchId() {
    return UserBranch.dao.findFirstBy("`userBranch`.user_id=?", this.get("id")).get("branch_id");
  }

  public List<Order> getOrders() {
    return Order.dao.findBy("`order`.user_id=?", this.get("id"));
  }

  public Page<Order> getOrders(int pageNumber, int pageSize) {
    return Order.dao.paginateBy(pageNumber, pageSize, "`order`.user_id=? ORDER BY `order`.created_at DESC", this.get("id"));
  }

  public List<Address> getAddresses() {
    return Address.dao.findBy("`address`.user_id=? AND `address`.deleted_at is null", this.get("id"));
  }

  public User findFirstBranchBy(String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.id branch_id,`branch`.region_id region_id ";
    String fromSql = " FROM sec_user `user` " +
        " LEFT JOIN sec_user_role `userRole` ON(`user`.id=`userRole`.user_id) " +
        " LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.findFirst(selectSql + fromSql + getWhere(where), paras);
  }

  public List<User> findByBranch(String where, Object... paras) {
    String sql = "SELECT `user`.* FROM sec_user `user` " +
        " LEFT JOIN sec_user_role `userRole` ON(`user`.id=`userRole`.user_id) " +
        " LEFT JOIN ord_user_branch `userBranch` ON(`user`.id=`userBranch`.user_id) " + getWhere(where);
    return dao.find(sql, paras);
  }

  public Page<User> paginateInfoBy(int pageNumber, int pageSize, String where, Object... paras) {
    return dao.paginate(pageNumber, pageSize, SqlKit.sql("user.findInfoBySelect"), SqlKit.sql("user.findInfoByFrom") + getWhere(where), paras);
  }

  public User findFirstInfoBy(String where, Object... paras) {
    return dao.findFirst(SqlKit.sql("user.findInfoBySelect") + SqlKit.sql("user.findInfoByFrom") + getWhere(where), paras);
  }

  public Page<User> paginateByRegion(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.id branch_id,`branch`.region_id region_id,`branch`.name branch_name,`branch`.org_code branch_code ";
    String fromSql = "FROM sec_user `user` " +
        " LEFT JOIN sec_user_role `userRole` ON(`user`.id=`userRole`.user_id) " +
        " LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }

  public Page<User> paginateByBranch(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.id branch_id,`branch`.region_id region_id,`branch`.name branch_name,`branch`.org_code branch_code ";
    String fromSql = "FROM sec_user `user` " +
        " LEFT JOIN sec_user_role `userRole` ON(`user`.id=`userRole`.user_id) " +
        " LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }
}
