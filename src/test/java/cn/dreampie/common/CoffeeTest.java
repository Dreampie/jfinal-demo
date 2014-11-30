package cn.dreampie.common;

import cn.dreampie.coffeescript.CoffeeScriptPlugin;
import cn.dreampie.flyway.FlywayPlugin;
import org.junit.Test;

/**
 * Created by ice on 14-11-13.
 */
public class CoffeeTest {
  @Test
  public void testCompileCoffee() throws Exception {
    CoffeeScriptPlugin coffeeScriptPlugin = new CoffeeScriptPlugin("/src/main/webapp/coffeescript/", "/src/main/webapp/javascript/");
//    coffeeScriptPlugin.start();
  }

}
