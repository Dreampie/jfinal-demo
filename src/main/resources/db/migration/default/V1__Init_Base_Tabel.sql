
DROP TABLE IF EXISTS sec_user;
CREATE TABLE sec_user (
  id            BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username      VARCHAR(50)  NOT NULL COMMENT '登录名',
  providername  VARCHAR(50)  NOT NULL COMMENT '提供者',
  email         VARCHAR(200) COMMENT '邮箱',
  phone        VARCHAR(50) COMMENT '联系电话',
  password      VARCHAR(200) NOT NULL COMMENT '密码',
  hasher        VARCHAR(200) NOT NULL COMMENT '加密类型',
  salt          VARCHAR(200) NOT NULL COMMENT '加密盐',
  avatar_url    VARCHAR(255) COMMENT '头像',
  first_name    VARCHAR(10) COMMENT '名字',
  last_name     VARCHAR(10) COMMENT '姓氏',
  full_name     VARCHAR(20) COMMENT '全名',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='用户';

DROP TABLE IF EXISTS sec_user_info;
CREATE TABLE sec_user_info (
  id          BIGINT    NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id     BIGINT    NOT NULL COMMENT '用户id',
  creator_id  BIGINT COMMENT '创建者id',
  gender      INT DEFAULT 0 COMMENT '性别0男，1女',
  province_id BIGINT COMMENT '省id',
  city_id     BIGINT COMMENT '市id',
  county_id   BIGINT COMMENT '县id',
  street      VARCHAR(500) COMMENT '街道',
  zip_code    VARCHAR(50) COMMENT '邮编',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='用户信息';

DROP TABLE IF EXISTS sec_role;
CREATE TABLE sec_role (
  id         BIGINT    NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(50)   NOT NULL COMMENT '名称',
  value      VARCHAR(50)  NOT NULL COMMENT '值',
  intro      VARCHAR(255) COMMENT '简介',
  pid        BIGINT DEFAULT 0 COMMENT '父级id',
  left_code  BIGINT DEFAULT 0 COMMENT '数据左边码',
  right_code BIGINT DEFAULT 0 COMMENT '数据右边码',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='角色';

DROP TABLE IF EXISTS sec_user_role;
CREATE TABLE sec_user_role (
  id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='用户角色';

DROP TABLE IF EXISTS sec_permission;
CREATE TABLE sec_permission (
  id         BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(50) NOT NULL COMMENT '名称',
  value      VARCHAR(50) NOT NULL COMMENT '值',
  url        VARCHAR(255) COMMENT 'url地址',
  intro      VARCHAR(255) COMMENT '简介',
  pid        BIGINT DEFAULT 0 COMMENT '父级id',
  left_code  BIGINT DEFAULT 0 COMMENT '数据左边码',
  right_code BIGINT DEFAULT 0 COMMENT '数据右边码',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='权限';


DROP TABLE IF EXISTS sec_role_permission;
CREATE TABLE sec_role_permission (
  id            BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role_id       BIGINT NOT NULL,
  permission_id BIGINT NOT NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='角色权限';

DROP TABLE IF EXISTS sec_token;
CREATE TABLE sec_token (
  uuid          VARCHAR(255) NOT NULL COMMENT '用户编码' PRIMARY KEY,
  username      VARCHAR(255) NOT NULL COMMENT '用户名',
  created_at    TIMESTAMP    NOT NULL COMMENT '创建时间',
  expiration_at TIMESTAMP    NOT NULL COMMENT '结束时间',
  used_to       INT          NOT NULL COMMENT '0是注册，1是手机验证'
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='认证';

DROP TABLE IF EXISTS com_area;
CREATE TABLE com_area (
  id         BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(50) DEFAULT '' COMMENT '地区名称',
  pinyin     VARCHAR(100) DEFAULT '' COMMENT '拼音',
  pid        BIGINT DEFAULT '0' COMMENT '父级编号',
  area_code  VARCHAR(6) DEFAULT NULL,
  zip_code   VARCHAR(6) DEFAULT NULL COMMENT '邮编',
  left_code  BIGINT DEFAULT '0' COMMENT '左编码',
  right_code BIGINT DEFAULT '0' COMMENT '右编码',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='地区';

DROP TABLE IF EXISTS com_state;
CREATE TABLE com_state (
  id         BIGINT    NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(45) DEFAULT NULL COMMENT '状态名称',
  value      INT DEFAULT '0' COMMENT '状态值',
  intro      TEXT COMMENT '简介',
  type       VARCHAR(45) DEFAULT NULL COMMENT '状态类型',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
) ENGINE =InnoDB DEFAULT CHARSET =utf8 COMMENT ='状态';
