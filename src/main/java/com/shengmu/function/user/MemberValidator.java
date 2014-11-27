package com.shengmu.function.user;

import cn.dreampie.ValidateKit;
import cn.dreampie.shiro.core.SubjectKit;
import cn.dreampie.shiro.hasher.Hasher;
import cn.dreampie.shiro.hasher.HasherKit;
import cn.dreampie.web.ReturnKit;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.shengmu.function.user.model.User;

import java.util.List;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class MemberValidator extends Validator {

  @Override
  protected void validate(Controller c) {

    if (getActionKey().equals("/member/control")) {
      if (c.getPara("do").equals("save")) {
        boolean usernameEmpty = ValidateKit.isNullOrEmpty(c.getPara("user.username"));
        if (usernameEmpty) addError("user_usernameMsg", "登录名不能为空");
        else if (User.dao.findFirstBy("`user`.username=?", c.getPara("user.username")) != null) {
          addError("user_usernameMsg", "登录名已存在");
        }
      } else if (c.getPara("do").equals("update")) {
        if (ValidateKit.isNullOrEmpty(c.getPara("user.id")))
          addError("user_usernameMsg", "用户不存在");
        boolean usernameEmpty = ValidateKit.isNullOrEmpty(c.getPara("user.username"));
        User user = User.dao.findFirstBy("`user`.username=? AND `user`.id <>?", c.getPara("user.username"), c.getPara("user.id"));
        if (!usernameEmpty && user != null) {
          addError("user_usernameMsg", "登录名已存在");
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
      if (getActionKey().equals("/member/control"))
        c.forwardAction("/member");
    }
  }
}
