package cn.dreampie.common;

import cn.dreampie.ValidateKit;
import cn.dreampie.flyway.FlywayPlugin;
import cn.dreampie.template.freemarker.FreemarkerLoader;
import org.junit.Before;
import org.junit.Test;

import java.util.regex.Pattern;

/**
 * Created by ice on 14-11-13.
 */
public class FlywayTest {
  @Test
  public void testInitDB() throws Exception {
    FlywayPlugin flywayPlugin = new FlywayPlugin();
//    flywayPlugin.start();
  }

}
