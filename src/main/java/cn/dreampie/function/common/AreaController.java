package cn.dreampie.function.common;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.common.model.Area;
import cn.dreampie.tree.TreeNodeKit;
import com.jfinal.plugin.ehcache.CacheName;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class AreaController extends Controller {

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void query() {
    String where = "";
    String ids = getPara("ids");
    if (ids != null) {
      where += " `area`.id in(" + ids + ")";
      setAttr("areas", Area.dao.findBy(where));
    } else {
      Integer id = getParaToInt("id");
      if (id != null && id > 0) {
        where += " `area`.id =" + id;
      }
      Area parent = Area.dao.findFirstBy(where);
      where = " `area`.left_code>=? AND `area`.right_code<=?";
      Boolean isdelete = getParaToBoolean("isdelete");
      if (isdelete == null || !isdelete) {
        where += " AND `area`.deleted_at is NULL";
      }
      Boolean istree = getParaToBoolean("istree");
      if (istree != null && istree) {
        setAttr("areas", TreeNodeKit.toTree(Area.dao.findBy(where, parent.getLong("left_code"), parent.getLong("right_code"))));
      } else {
        setAttr("areas", Area.dao.findBy(where, parent.getLong("left_code"), parent.getLong("right_code")));
      }
    }
    render("/view/area/index.ftl");
  }
}
