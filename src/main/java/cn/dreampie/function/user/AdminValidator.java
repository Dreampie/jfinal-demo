package cn.dreampie.function.user;

import cn.dreampie.function.user.model.User;
import cn.dreampie.web.ReturnKit;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class AdminValidator extends Validator {

  @Override
  protected void validate(Controller c) {

    if (getActionKey().equals("/admin/deleteUser")) {

    } else if (getActionKey().equals("/admin/updateRole")) {

    } else if (getActionKey().equals("/admin/roleUpdate")) {

    } else if (getActionKey().equals("/admin/roleSave")) {

    } else if (getActionKey().equals("/admin/rolePerms")) {

    } else if (getActionKey().equals("/admin/rolePerms")) {

    } else if (getActionKey().equals("/admin/roleDrop")) {

    } else if (getActionKey().equals("/admin/permDrop")) {

    } else if (getActionKey().equals("/admin/permSave")) {

    } else if (getActionKey().equals("/admin/permUpdate")) {

    }else if (getActionKey().equals("/admin/permsAdd")) {

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
      if (getActionKey().equals("/admin/deleteUser")) {

      } else if (getActionKey().equals("/admin/updateRole")) {

      } else if (getActionKey().equals("/admin/updatePwd")) {

      } else if (getActionKey().equals("/admin/roleUpdate")) {

      } else if (getActionKey().equals("/admin/roleSave")) {

      } else if (getActionKey().equals("/admin/roleDelete")) {

      } else if (getActionKey().equals("/admin/permDelete")) {

      } else if (getActionKey().equals("/admin/permSave")) {

      } else if (getActionKey().equals("/admin/permUpdate")) {

      }
    }
  }
}
