package com.shengmu.function.common;

import cn.dreampie.tree.TreeNodeKit;
import com.jfinal.plugin.ehcache.CacheName;
import com.shengmu.common.config.AppConstants;
import com.shengmu.common.web.controller.Controller;
import com.shengmu.function.common.model.Area;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class AreaController extends Controller {

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void query() {
    String where = "";
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
      setAttr("areas", TreeNodeKit.toTree(Area.dao.findBy(where,parent.getLong("left_code"),parent.getLong("right_code"))));
    } else {
      setAttr("areas", Area.dao.findBy(where,parent.getLong("left_code"),parent.getLong("right_code")));
    }
    render("/view/index.ftl");
  }
}
