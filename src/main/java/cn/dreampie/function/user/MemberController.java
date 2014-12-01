package cn.dreampie.function.user;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.order.model.Branch;
import cn.dreampie.function.order.model.UserBranch;
import cn.dreampie.function.user.model.Role;
import cn.dreampie.function.user.model.UserRole;
import cn.dreampie.shiro.core.SubjectKit;
import cn.dreampie.shiro.hasher.HasherInfo;
import cn.dreampie.shiro.hasher.HasherKit;
import cn.dreampie.web.cache.CacheRemove;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import cn.dreampie.function.order.model.Region;
import cn.dreampie.function.user.model.User;
import org.apache.commons.lang3.StringUtils;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class MemberController extends Controller {

  public void index() {
    branch();
  }

  public void query() {
    User user = SubjectKit.getUser();
    User u = getModel(User.class);
    if (u.getLong("id") != null) {
      setAttr("user", User.dao.findFirstBranchBy("`user`.id=? AND `userRole`.role_id in (" + user.getRoleChildrenIdsStr() + ")", u.get("id")));
    }
    render("/view/app/user/detail.ftl");
  }

  public void branch() {
    User user = SubjectKit.getUser();
    keepPara();
    Integer pageNum = getParaToInt(0, 1);
    Integer pageSize = getParaToInt("pageSize", 15);
    String where = " `userRole`.role_id in (" + user.getRoleChildrenIdsStr() + ") ";
    //branch
    Page<User> users = null;
    if (getParaToLong("branch_id") == null) {
      //region
      Long regionId = getParaToLong("region_id");
      if (regionId == null)
        users = User.dao.paginateByBranch(pageNum, pageSize, where);
      else
        users = User.dao.paginateByRegion(pageNum, pageSize, where + " AND `branch`.region_id=?", regionId);
    } else
      users = User.dao.paginateByBranch(pageNum, pageSize, where + " AND `userBranch`.branch_id=?", getParaToLong("branch_id"));

    setAttr("regions", Region.dao.findBy("`region`.deleted_at is null"));
    setAttr("users", users);
    render("/view/app/user/branch.ftl");
  }

  @CacheRemove(name = AppConstants.DEFAULT_CACHENAME)
  @Before({Tx.class, MemberValidator.class})
  public void control() {
    User user = getModel(User.class);
    String todo = getPara("do");
    boolean result = false;
    if (todo != null) {
      if (todo.equals("delete") && user.getLong("id") != null) {
        result = user.set("deleted_at", new Timestamp(new Date().getTime())).update();
      } else if (todo.equals("save") && getParaToLong("branch_id") != null) {
        HasherInfo hasher = HasherKit.hash(user.getStr("password"));

        if (user.getStr("first_name") == null)
          user.set("first_name", "");

        user.set("password", hasher.getHashResult()).set("salt", hasher.getSalt())
            .set("hasher", hasher.getHasher().value()).set("providername", "shengmu")
            .set("full_name", user.getStr("last_name") + "." + user.getStr("first_name"));
        result = user.save();
        user.addUserInfo(null).addRole(null).addBranch(Branch.dao.findById(getParaToLong("branch_id")));
      } else if (todo.equals("update") && user.getLong("id") != null) {
        //空内容不更新
        user.removeNullValueAttrs();
        if (getParaToLong("branch_id") != null && !user.getBranchId().equals(getParaToLong("branch_id")))
          UserBranch.dao.updateBy("SET branch_id=?", "user_id=?", getParaToLong("branch_id"), user.get("id"));
        Boolean reuse = getParaToBoolean("reuse");
        if (reuse != null && reuse)
          user.set("deleted_at", null);

        if(user.get("last_name")!=null)
          user.set("full_name",user.get("last_name")+"."+user.get("first_name",""));
        result = user.update();
      }
    }
    if (result) {
      setAttr("user", user);
      setSuccess();
    } else
      setError();
    render("/view/app/user/detail.ftl");
  }
}
