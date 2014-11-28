package cn.dreampie.function.user;

import cn.dreampie.ValidateKit;
import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.shiro.core.SubjectKit;
import cn.dreampie.shiro.hasher.Hasher;
import cn.dreampie.shiro.hasher.HasherInfo;
import cn.dreampie.shiro.hasher.HasherKit;
import cn.dreampie.web.cache.CacheRemove;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import cn.dreampie.function.user.model.User;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class UserController extends Controller {

  public void index() {
//    render("/view/app/user/branch.ftl");
    redirect("/user/center");
  }

  @CacheRemove(name = AppConstants.DEFAULT_CACHENAME)
  @Before({UserValidator.class, Tx.class})
  public void updatePwd() {
    keepModel(User.class);
    User upUser = getModel(User.class);
    User user = SubjectKit.getUser();
    upUser.set("id", user.get("id"));
    HasherInfo passwordInfo = HasherKit.hash(upUser.getStr("password"), Hasher.DEFAULT);
    upUser.set("password", passwordInfo.getHashResult());
    upUser.set("hasher", passwordInfo.getHasher().value());
    upUser.set("salt", passwordInfo.getSalt());

    if (upUser.update()) {
      SubjectKit.getSubject().logout();
      setAttr("state", "success");
      redirect("/tosignin");
      return;
    } else
      setAttr("state", "failure");
    render("/view/app/user/center.ftl");
  }

  public void center() {
    User user = SubjectKit.getUser();
    if (!ValidateKit.isNullOrEmpty(user)) {
      setAttr("user", user);
    }
    render("/view/app/user/center.ftl");
  }
}
