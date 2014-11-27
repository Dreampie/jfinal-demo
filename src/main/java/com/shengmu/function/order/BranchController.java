package com.shengmu.function.order;

import com.jfinal.plugin.ehcache.CacheName;
import com.shengmu.common.config.AppConstants;
import com.shengmu.common.web.controller.Controller;
import com.shengmu.function.order.model.Branch;

/**
 * Created by ice on 14-10-30.
 */
public class BranchController extends Controller {
  static String indexView = "/view/app/branch/index.ftl";

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void index() {
    render(indexView);
  }

  @CacheName(AppConstants.DEFAULT_CACHENAME)
  public void all() {
    setAttr("branches", Branch.dao.findBy("deleted_at is null"));
    render(indexView);
  }
}
