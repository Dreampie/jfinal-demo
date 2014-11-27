USE jfinal_demo;
-- create role--

INSERT INTO sec_role(id,name, value, intro, pid,left_code,right_code,created_at)
VALUES (1,'超级管理员','R_ADMIN','',0,1,8, current_timestamp),
       (2,'系统管理员','R_MANAGER','',1,2,7,current_timestamp),
       (3,'总部','R_MEMBER','',2,3,4,current_timestamp),
       (4,'分部','R_USER','',2,5,6,current_timestamp);

-- create permission--
INSERT INTO sec_permission(id, name, value, url, intro,pid,left_code,right_code, created_at)
VALUES (1,'管理员目录','P_D_ADMIN','/admin/**','',0,1,22,current_timestamp),
       (2,'角色权限管理','P_ROLE','/admin/role/**','',1,2,3,current_timestamp),
       (3,'用户管理','P_USER','/admin/user/**','',1,4,5,current_timestamp),
       (4,'总部目录','P_D_MEMBER','/member/**','',0,9,10,current_timestamp),
       (5,'分部目录','P_D_USER','/user/**','',0,11,16,current_timestamp),
       (6,'订单','P_ORDER','/order/**','',0,12,19,current_timestamp),
       (7,'订单处理','P_ORDER_CONTROL','/order/deliver**','',6,13,14,current_timestamp),
       (8,'订单更新','P_ORDER_UPDATE','/order/update**','',6,15,16,current_timestamp),
       (9,'支部订单','P_ORDER_BRANCH','/order/branch**','',6,17,18,current_timestamp),
       (10,'收货地址','P_Address','/address/**','',0,20,21,current_timestamp),
       (11,'用户处理','P_USER_CONTROL','/user/branch**','',6,17,18,current_timestamp);


INSERT INTO sec_role_permission(id,role_id, permission_id)
VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),
       (12,2,1),(13,2,3),(14,2,4),(15,2,5),(16,2,6),(17,2,7),(18,2,8),(19,2,9),(20,2,10),(21,2,11),
       (22,3,4),(23,3,5),(24,3,6),(25,3,8),(26,3,9),(27,3,10),(28,3,11),
       (29,4,5),(30,4,6),(31,4,8),(32,4,10);

-- user data--
-- create  admin--
INSERT INTO sec_user(id,username, providername, email, phone, password, hasher, salt, avatar_url, first_name, last_name, full_name, created_at)
VALUES (1,'admin','shengmu','wangrenhui1990@gmail.com','18611434500','$shiro1$SHA-256$500000$iLqsOFPx5bjMGlB0JiNjQQ==$1cPTj9gyPGmYcKGQ8aw3shybrNF1ixdMCm/akFkn71o=','default_hasher','','','仁辉','王','王.仁辉',current_timestamp);

-- create user_info--
INSERT INTO sec_user_info(id,user_id, creator_id, gender,province_id,city_id,county_id,street,created_at)
VALUES (1,1,0,0,1,2,3,'人民大学',current_timestamp);

-- create user_role--
INSERT INTO sec_user_role(id, user_id, role_id)
VALUES (1,1,1);