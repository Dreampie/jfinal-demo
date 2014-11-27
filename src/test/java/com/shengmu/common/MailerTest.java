package com.shengmu.common;

import cn.dreampie.ValidateKit;
import cn.dreampie.template.freemarker.FreemarkerLoader;
import org.junit.Before;
import org.junit.Test;

import java.util.regex.Pattern;

/**
 * Created by ice on 14-11-13.
 */
public class MailerTest {
  @Test
  public void testSendMail() throws Exception {
//    Mailer.sendHtml("测试", "<a href='www.dreampie.cn'>Dreampie</a>", "173956022@qq.com");
//    AkkaMailer.sendHtml("测试", "<a href='www.dreampie.cn'>Dreampie</a>", "173956022@qq.com");
    System.out.println(new FreemarkerLoader("src/main/webapp/template/","mail/signup_email.ftl").setValue("full_name", "sss").setValue("safe_url", "sss").getHtml());

//      String telcheck = "^(\\d{3,4}-?\\d{7,9})|(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$";
//      Pattern pattern = Pattern.compile(telcheck,  Pattern.CASE_INSENSITIVE);
//
//      if (pattern.matcher("11111111111").find()) {
//          System.out.println("true");
//      }
//      System.out.println(ValidateKit.isPhone("11111111111")+"");
  }

}
