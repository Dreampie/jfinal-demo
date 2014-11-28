
INSERT INTO ord_product(id,name,category,price,created_at)
VALUES (1,'环保装','有机奶',7800,current_timestamp);

INSERT INTO ord_order(id,code,user_id,branch_id,address_id,total_pay,actual_pay,state,note,created_at,delivered_at)
VALUES (1,'141101102102219',1,1,1,7800,7800,0,'',current_timestamp,timestampadd(day, 7, current_timestamp));

INSERT INTO ord_order_product(id,order_id,product_id,num)
VALUES (1,1,1,1);

INSERT INTO ord_address(id,user_id,name,spare_name,province_id,city_id,county_id,street,zip_code,phone,spare_phone,is_default,created_at)
VALUES (1,1,'张测试','李备用',1,2,3,'中关村','100086','15611020012','18922111221',1,current_timestamp);

INSERT INTO ord_region(id,name,note,created_at)
VALUES (1,'中心区','',current_timestamp),
       (2,'西南区','',current_timestamp),
       (3,'东北区','',current_timestamp),
       (4,'西北区','',current_timestamp);

INSERT INTO ord_branch(id,name,pid,region_id,org_code,note,created_at)
VALUES (1,'总行营业部',0,1,'9A01','',current_timestamp),
       (2, '北京正义路支行', 1, 2, '102', '', current_timestamp),
       (3, '北京阜成门支行', 1, 1, '103', '', current_timestamp),
       (4, '北京建国门支行', 1, 2, '104', '', current_timestamp),
       (5, '北京中关村支行', 1, 1, '105', '', current_timestamp),
       (6, '北京工体支行', 1, 2, '106', '', current_timestamp),
       (7, '北京西坝河支行', 1, 2, '107', '', current_timestamp),
       (8, '北京安定门支行', 1, 2, '108', '', current_timestamp),
       (9, '北京万寿路支行', 1, 2, '109', '', current_timestamp),
       (10, '北京上地支行', 1, 4, '110', '', current_timestamp),
       (11, '北京西客站支行', 1, 1, '111', '', current_timestamp),
       (12, '北京国贸支行', 1, 2, '112', '', current_timestamp),
       (13, '北京首体支行', 1, 2, '113', '', current_timestamp),
       (14, '北京金融街支行', 1, 2, '114', '', current_timestamp),
       (15, '北京什刹海支行', 1, 2, '115', '', current_timestamp),
       (16, '北京北太平庄支行', 1, 2, '116', '', current_timestamp),
       (17, '北京广安门支行', 1, 2, '117', '', current_timestamp),
       (18, '北京朝阳门支行', 1, 2, '118', '', current_timestamp),
       (19, '北京方庄支行', 1, 2, '119', '', current_timestamp),
       (20, '北京紫竹支行', 1, 2, '120', '', current_timestamp),
       (21, '北京魏公村支行', 1, 2, '121', '', current_timestamp),
       (22, '北京亚运村支行', 1, 2, '122', '', current_timestamp),
       (23, '北京西直门支行', 1, 1, '123', '', current_timestamp),
       (24, '北京东单支行', 1, 2, '124', '', current_timestamp),
       (25, '北京苏州街支行', 1, 2, '125', '', current_timestamp),
       (26, '北京和平里支行', 1, 2, '126', '', current_timestamp),
       (27, '北京崇文门支行', 1, 2, '127', '', current_timestamp),
       (28, '北京奥运村支行', 1, 2, '128', '', current_timestamp),
       (29, '北京三元支行', 1, 2, '129', '', current_timestamp),
       (30, '北京西单支行', 1, 1, '130', '', current_timestamp),
       (31, '北京劲松支行', 1, 2, '131', '', current_timestamp),
       (32, '北京成府路支行', 1, 2, '132', '', current_timestamp),
       (33, '北京德胜门支行', 1, 2, '133', '', current_timestamp),
       (34, '北京电子城支行', 1, 2, '134', '', current_timestamp),
       (35, '北京首都机场支行', 1, 2, '135', '', current_timestamp),
       (36, '北京西二环支行', 1, 2, '136', '', current_timestamp),
       (37, '北京西长安街支行', 1, 2, '137', '', current_timestamp),
       (38, '北京空港支行', 1, 2, '138', '', current_timestamp),
       (39, '北京南二环支行', 1, 2, '139', '', current_timestamp),
       (40, '北京建国门外支行', 1, 2, '140', '', current_timestamp),
       (41, '北京京广支行', 1, 2, '141', '', current_timestamp),
       (42, '北京航天桥支行', 1, 1, '142', '', current_timestamp),
       (43, '北京中关村西区支行', 1, 2, '143', '', current_timestamp),
       (44, '北京望京支行', 1, 2, '144', '', current_timestamp),
       (45, '北京环保园支行', 1, 2, '145', '', current_timestamp),
       (46, '北京首体南路支行', 1, 2, '146', '', current_timestamp),
       (47, '北京大兴支行', 1, 2, '147', '', current_timestamp),
       (48, '北京东二环支行', 1, 2, '148', '', current_timestamp),
       (49, '北京顺义支行', 1, 3, '149', '', current_timestamp),
       (50, '北京总部基地支行', 1, 2, '150', '', current_timestamp),
       (51, '北京世纪金源支行', 1, 2, '151', '', current_timestamp),
       (52, '北京国奥支行', 1, 2, '152', '', current_timestamp),
       (53, '北京朝阳北路支行', 1, 3, '153', '', current_timestamp),
       (54, '北京亦庄支行', 1, 2, '154', '', current_timestamp),
       (55, '北京通州支行', 1, 3, '155', '', current_timestamp),
       (56, '北京长椿街支行', 1, 2, '156', '', current_timestamp);

INSERT INTO ord_user_branch(id,user_id,branch_id)
VALUES(1,1,1);