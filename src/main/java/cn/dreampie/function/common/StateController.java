package cn.dreampie.function.common;

import cn.dreampie.ValidateKit;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.common.model.State;
import com.jfinal.plugin.ehcache.CacheName;
import cn.dreampie.common.config.AppConstants;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class StateController extends Controller {

  public void index() {
    render("/view/index.ftl");
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void own() {
    setAttr("states", State.dao.findBy("`state`.deleted_at is NULL"));
    render("/view/index.ftl");
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void one() {
    String type = getPara("state.type");
    String value = getPara("state.value");
    if (!ValidateKit.isNullOrEmpty(type) && !ValidateKit.isNullOrEmpty(value) && ValidateKit.isPositiveNumber(value)) {
      setAttr("state", State.dao.findFirstBy("`state`.type=? AND `state`.value=?", type, value));
    }
    render("/view/index.ftl");
  }
}
