package cn.dreampie.common.resource;

import freemarker.core.Environment;
import freemarker.template.*;

import java.io.IOException;
import java.util.Map;

/**
 * Created by wangrenhui on 14-4-10.
 */
public abstract class DefaultTag implements TemplateDirectiveModel {
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        verifyParameters(params);
        render(env, params, body);
    }

    public abstract void render(Environment env, Map params, TemplateDirectiveBody body) throws IOException, TemplateException;

    protected String getParam(Map params, String name) {
        Object value = params.get(name);

        if (value instanceof SimpleScalar) {
            return ((SimpleScalar) value).getAsString();
        }

        return null;
    }


    protected void verifyParameters(Map params) throws TemplateModelException {
    }

    protected void renderBody(Environment env, TemplateDirectiveBody body) throws IOException, TemplateException {
        if (body != null) {
            body.render(env.getOut());
        }
    }
}

