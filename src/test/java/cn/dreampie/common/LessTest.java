package cn.dreampie.common;

import cn.dreampie.coffeescript.CoffeeScriptPlugin;
import cn.dreampie.lesscss.LessCssPlugin;
import com.jfinal.kit.PathKit;
import org.junit.Test;

/**
 * Created by ice on 14-11-13.
 */
public class LessTest {
  @Test
  public void testCompileLess() throws Exception {
    LessCssPlugin lessCssPlugin = new LessCssPlugin("/src/main/webapp/lesscss/", "/src/main/webapp/style/");
//    lessCssPlugin.start();

  }

}
