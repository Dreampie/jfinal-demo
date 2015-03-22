package cn.dreampie.common;

import cn.dreampie.ValidateKit;
import cn.dreampie.mail.Mailer;
import cn.dreampie.mail.MailerPlugin;
import cn.dreampie.template.freemarker.FreemarkerLoader;
import com.jfinal.kit.PathKit;
import org.apache.commons.mail.HtmlEmail;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.util.regex.Pattern;

/**
 * Created by ice on 14-11-13.
 */
public class MailerTest {

  @Before
  public void setUp() throws Exception {
    MailerPlugin mailerPlugin = new MailerPlugin();
    mailerPlugin.start();
  }

  @Test
  public void testSendMail() throws Exception {
//    Mailer.sendHtml("测试", "<a href='www.dreampie.cn'>Dreampie</a>", "173956022@qq.com");
//    AkkaMailer.sendHtml("测试", "<a href='www.dreampie.cn'>Dreampie</a>", "173956022@qq.com");
//    System.out.println(new FreemarkerLoader("src/main/webapp/template/", "mail/signup_email.ftl").setValue("full_name", "sss").setValue("safe_url", "sss").getHtml());

//      String telcheck = "^(\\d{3,4}-?\\d{7,9})|(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$";
//      Pattern pattern = Pattern.compile(telcheck,  Pattern.CASE_INSENSITIVE);
//
//      if (pattern.matcher("11111111111").find()) {
//          System.out.println("true");
//      }
//      System.out.println(ValidateKit.isPhone("11111111111")+"");

    HtmlEmail htmlEmail = Mailer.getHtmlEmail("测试", "173956022@qq.com");
    String cid1 = htmlEmail.embed(new File(PathKit.getWebRootPath() + "/src/main/webapp/image/favicon.ico"), "1");
    String cid2 = htmlEmail.embed(new File(PathKit.getWebRootPath() + "/src/main/webapp/image/app/logo.png"), "2");
    htmlEmail.setHtmlMsg("<a href='www.dreampie.cn'>Dreampie</a><img src=\"cid:" + cid1 + "\"'/><img src=\"cid:" + cid2 + "\"'/>");
    htmlEmail.send();
  }

}
