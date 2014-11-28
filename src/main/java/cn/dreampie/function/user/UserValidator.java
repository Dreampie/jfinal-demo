package cn.dreampie.function.user;

import cn.dreampie.ValidateKit;
import cn.dreampie.function.user.model.User;
import cn.dreampie.shiro.core.SubjectKit;
import cn.dreampie.shiro.hasher.Hasher;
import cn.dreampie.shiro.hasher.HasherKit;
import cn.dreampie.web.ReturnKit;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class UserValidator extends Validator {

  @Override
  protected void validate(Controller c) {

    if (getActionKey().equals("/user/updatePwd")) {
//      boolean idEmpty = ValidateKit.isNullOrEmpty(c.getPara("user.id"));
//      if (idEmpty) addError("user_idMsg", "账户编号丢失");
//      if (!idEmpty && !ValidateKit.isPositiveNumber(c.getPara("user.id")))
//        addError("user_idMsg", "账户编号必须为数字");
//
//      if (ValidateKit.isNullOrEmpty(User.dao.findBy("`user`.id=" + c.getPara("user.id"))))
//        addError("user_idMsg", "账户不存在");
//
//      boolean userEmpty = ValidateKit.isNullOrEmpty(c.getPara("user.username"));
//      if (userEmpty) addError("user_usernameMsg", "账户丢失");
//      if (!userEmpty && !ValidateKit.isUsername(c.getPara("user.username")))
//        addError("user_usernameMsg", "账户为英文字母 、数字和下划线长度为5-18");

      boolean passwordEmpty = ValidateKit.isNullOrEmpty(c.getPara("user.password"));
      if (passwordEmpty) addError("user_passwordMsg", "密码不能为空");
      if (!passwordEmpty && !ValidateKit.isPassword(c.getPara("user.password")))
        addError("user_passwordMsg", "密码为英文字母 、数字和下划线长度为5-18");

      if (!passwordEmpty && !c.getPara("user.password").equals(c.getPara("repassword")))
        addError("repasswordMsg", "重复密码不匹配");


      boolean oldpasswordEmpty = ValidateKit.isNullOrEmpty(c.getPara("oldpassword"));
      if (oldpasswordEmpty) addError("user_oldpasswordMsg", "原始密码不能为空");

      if (!oldpasswordEmpty && !ValidateKit.isPassword(c.getPara("oldpassword")))
        addError("user_oldpasswordMsg", "密码为英文字母 、数字和下划线长度为5-18");

      if (!oldpasswordEmpty) {
        User user = User.dao.findById(SubjectKit.getUser().get("id"));

        if (user != null) {
          boolean match = HasherKit.match(c.getPara("oldpassword"), user.getStr("password"), Hasher.DEFAULT);

          if (!match) {
            addError("user_oldpasswordMsg", "原始密码不匹配");
          }
        } else {
          addError("user_oldpasswordMsg", "用户信息错误");
        }
      }
    }
  }

  @Override
  protected void handleError(Controller c) {
    c.keepModel(User.class);
    c.keepPara();
    c.setAttr("state", "failure");
    if (ReturnKit.isJson(c.getRequest()))
      c.renderJson();
    else {
      if (getActionKey().equals("/user/updatePwd"))
        c.forwardAction("/user/center");
    }
  }
}
