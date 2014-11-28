package cn.dreampie.common.shiro;

import ch.qos.logback.core.util.TimeUtil;
import cn.dreampie.shiro.hasher.Hasher;
import cn.dreampie.shiro.hasher.HasherKit;
import org.joda.time.DateTime;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class HasherKitTest {

  @Test
  public void testHash() {
    System.out.println(HasherKit.hash("shengmu").getHashResult());
    System.out.println(DateTime.now().toString("yyMMddhhmmssms"));
  }
}