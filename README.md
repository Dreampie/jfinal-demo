jfinal_demo [在线访问](http://jf_demo.jd-app.com)
===========

推荐java的restful框架：[Resty](https://github.com/Dreampie/resty)

jfinal+bootstrap+coffeescript+lesscss+jfinal-dreampie(jfinal插件集)

jfinal demo  程序，使用bootstrap+本人编写的多款插件

如使用coffeescript-maven-plugin编译coffeescript代码

使用lesscsss-maven-plugin编译lesscss代码

使用flyway-maven-plugin运行数据库脚本，支持多种定制功能。

运行指南：

1.在mysql里创建数据库jfinal_demo,运行maven插件 cn.dreampie:flyway-maven-plugin:1.0:clean和cn.dreampie:flyway-maven-plugin:1.0:migrate  生成数据库表结构

2.使用jetty运行项目，运行maven插件jetty:run

3.admin密码shengmu

4.学习使用Maven，[我的Blog](http://my.oschina.net/wangrenhui1990/blog/337583)

基本功能如下：

1.使用jfinal-shiro实现数据库级别的权限灵活定制，和freemarker的权限标签

2.使用jfinal-captcha实现验证码

3.使用jfinal-web实现根据ajax请求返回json数据，其他返回默认数据，支持继承JFController使用getModels获取对象列表，继承Model封装，避免写大量重复的sql代码，使用ehcache缓存等多个特性

4.使用jfinal-sqlinxml实现在xml里管理sql语句

还有很多功能大家可以运行之后 慢慢体验


![JFINAL_DEMO](http://static.oschina.net/uploads/space/2014/1127/185853_6800_946569.png "JFINAL_DEMO")

![JFINAL_DEMO](http://static.oschina.net/uploads/space/2014/1127/185913_J9zy_946569.png "JFINAL_DEMO")

