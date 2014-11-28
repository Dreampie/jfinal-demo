package cn.dreampie.common.resource;

import freemarker.template.SimpleHash;

/**
 * Created by wangrenhui on 14-4-10.
 */
public class ResourceTags extends SimpleHash {
    public ResourceTags() {
        put("static", new StaticTag());
    }
}
