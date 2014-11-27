package com.shengmu.function.user.model;

import cn.dreampie.ValidateKit;
import cn.dreampie.sqlinxml.SqlKit;
import cn.dreampie.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Page;
import com.shengmu.function.order.model.Branch;
import com.shengmu.function.order.model.Order;
import com.shengmu.function.order.model.UserBranch;

import java.util.Date;
import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_user")
public class User extends cn.dreampie.shiro.model.User<User> {
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

  public Branch getBranch() {
    return Branch.dao.findById(getBranchId());
  }

  public Long getBranchId() {
    return UserBranch.dao.findFirstBy("`userBranch`.user_id=?", this.get("id")).get("branch_id");
  }

  public List<Order> getOrders() {
    return Order.dao.findBy("`order`.user_id=?", this.get("id"));
  }

  public Page<Order> getOrders(int pageNumber, int pageSize) {
    return Order.dao.paginateBy(pageNumber, pageSize, "`order`.user_id=? ORDER BY `order`.created_at desc", this.get("id"));
  }

  public User findFirstBranchBy(String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.id branch_id,`branch`.region_id region_id ";
    String fromSql = " FROM sec_user `user`  LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.findFirst(selectSql + fromSql + getWhere(where), paras);
  }

  public List<User> findByBranch(String where, Object... paras) {
    String sql = "SELECT `user`.* FROM sec_user `user` LEFT JOIN ord_user_branch `userBranch` ON(`user`.id=`userBranch`.user_id) " + getWhere(where);
    return dao.find(sql, paras);
  }

  public Page<User> paginateInfoBy(int pageNumber, int pageSize, String where, Object... paras) {
    return dao.paginate(pageNumber, pageSize, SqlKit.sql("user.findInfoBySelect"), SqlKit.sql("user.findInfoByExceptSelect") + getWhere(where), paras);
  }

  public User findFirstInfoBy(String where, Object... paras) {
    return dao.findFirst(SqlKit.sql("user.findInfoBySelect") + SqlKit.sql("user.findInfoByExceptSelect") + getWhere(where), paras);
  }

  public Page<User> paginateByRegion(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.name branch_name,`branch`.org_code branch_code ";
    String fromSql = "FROM sec_user `user`  LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }

  public Page<User> paginateByBranch(int pageNumber, int pageSize, String where, Object... paras) {
    String selectSql = "SELECT `user`.*,`branch`.name branch_name,`branch`.org_code branch_code ";
    String fromSql = "FROM sec_user `user`  LEFT JOIN ord_user_branch `userBranch` ON(`userBranch`.user_id=`user`.id) LEFT JOIN ord_branch `branch` ON(`userBranch`.branch_id=`branch`.id) ";
    return dao.paginate(pageNumber, pageSize, selectSql, fromSql + getWhere(where), paras);
  }
}
