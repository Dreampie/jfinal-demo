package cn.dreampie.common.resource;

import cn.dreampie.PropertiesKit;
import freemarker.core.Environment;
import freemarker.log.Logger;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;

import java.io.IOException;
import java.util.Map;


/**
 * JSP tag that renders the tag body if the current user <em>is not</em> known to the system, either because they
 * haven't logged in yet, or because they have no 'RememberMe' identity.
 * <p/>
 * <p>The logically opposite tag of this one is the {@link DefaultTag}.  Please read that class's JavaDoc as it explains
 * more about the differences between Authenticated/Unauthenticated and User/Guest semantic differences.
 * <p/>
 * <p>Equivalent to {@link org.apache.shiro.web.tags.GuestTag}</p>
 *
 * @since 0.9
 */
public class StaticTag extends DefaultTag {
    private static final Logger log = Logger.getLogger("StaticTag");

    private static String res_static = "";

    public StaticTag() {
        PropertiesKit.me().loadPropertyFile("application.properties");
        res_static = PropertiesKit.me().getProperty("resource.static", "");
    }

    @Override
    public void render(Environment env, Map params, TemplateDirectiveBody body) throws IOException, TemplateException {
//      renderBody(env, body);
        env.getOut().write(res_static);
    }

}
