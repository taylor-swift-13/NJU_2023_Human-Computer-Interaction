INSERT INTO `bank`.`sub_bank` (`bank_name`, `bank_location`, `asset`) VALUES ('xx1支行', '合肥', '20000000');
INSERT INTO `bank`.`sub_bank` (`bank_name`, `bank_location`, `asset`) VALUES ('xx2支行', '上海', '20000000');

INSERT INTO `bank`.`department` (`depart_no`, `bank_name`, `depart_name`, `depart_type`) VALUES ('1', 'xx1支行', '服务部门', '服务');
INSERT INTO `bank`.`department` (`depart_no`, `bank_name`, `depart_name`, `depart_type`) VALUES ('2', 'xx1支行', '记账部门', '记账');
INSERT INTO `bank`.`department` (`depart_no`, `bank_name`, `depart_name`, `depart_type`) VALUES ('3', 'xx2支行', '服务部门', '服务');
INSERT INTO `bank`.`department` (`depart_no`, `bank_name`, `depart_name`, `depart_type`) VALUES ('4', 'xx2支行', '记账部门', '记账');

INSERT INTO `bank`.`member` (`id`, `depart_no`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('1', '1', '1', 'xx1支行', 'b', 'M', '100000000000000001', '10000000001', 'abcD1-2-304', '100000', '2019-1-1', '7');
INSERT INTO `bank`.`member` (`id`, `depart_no`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('2', '2', '2', 'xx1支行', 'c', 'W', '100000000000000000', '20000000000', 'ac 4-5-607', '100000', '2018-01-01', '8');
INSERT INTO `bank`.`member` (`id`, `depart_no`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('3', '3', '3', 'xx2支行', 'x', 'W', '200000000000000000', '12300000001', '下北泽', '900000', '2018-07-01', '7');
INSERT INTO `bank`.`member` (`id`, `depart_no`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('4', '4', '4', 'xx2支行', 'y', 'M', '200000000000000001', '12300000002', '编不出来了', '900000', '2018-08-01', '7');
INSERT INTO `bank`.`member` (`id`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('100', '1', 'xx1支行', 'a', 'M', '100000000000000011', '10000000000', 'abc1-2-304', '5000', '2023-05-29', '1');
INSERT INTO `bank`.`member` (`id`, `dep_depart_no`, `bank_name`, `name`, `sex`, `person_id`, `phone`, `address`, `salary`, `begin_date`, `level`) VALUES ('200', '4', 'xx2支行', 'z', 'W', '200000000000000022', '12300000000', '电波塔', '6000', '2022-04-02',  '2');

UPDATE `bank`.`department` SET `id` = '1' WHERE (`depart_no` = '1');
UPDATE `bank`.`department` SET `id` = '2' WHERE (`depart_no` = '2');
UPDATE `bank`.`department` SET `id` = '3' WHERE (`depart_no` = '3');
UPDATE `bank`.`department` SET `id` = '4' WHERE (`depart_no` = '4');

INSERT INTO client (client_id, real_name, client_phone, client_address, client_email)
VALUES
('A001','Taylor Swift','+1-13-0123-4567','123 Main St, New York, USA','taylorswift13@example.com'),
('J001', '后藤一里', '+81-90-1234-5678', '東京都港区芝公園1-1-1', 'bocchi@example.com'),
('J002', '伊地知虹夏', '+81-80-5678-1234', '大阪市中央区難波1-2-3', 'nijika@example.com'),
('J003', '喜多郁代', '+81-90-8765-4321', '京都市左京区岡崎1-1-1', 'ikuyo@example.com'),
('J004', '山田凉', '+81-80-5432-1098', '横浜市中区山下公園2-2-2', 'ryo@example.com'),
('C000', '李娟', '+86-138-1234-5678', '上海市黄浦区南京东路123号', 'lijuan@example.com'),
('C001', '王伟', '+86-139-5678-1234', '北京市朝阳区建国路456号', 'wangwei@example.com'),
('C002', '张丽', '+86-137-8765-4321', '广州市天河区珠江新城789号', 'zhangli@example.com'),
('C003', '刘强', '+86-136-9876-5432', '深圳市福田区莲花山890号', 'liuqiang@example.com'),
('C004', '陈娜', '+86-135-8765-4321', '成都市锦江区春熙路567号', 'chenna@example.com'),
('C005', '杨洋', '+86-158-7654-3210', '重庆市渝中区解放碑901号', 'yangyang@example.com'),
('C006', '徐浩', '+86-139-6543-2109', '南京市玄武区中山路345号', 'xuhao@example.com'),
('C007', '张敏', '+86-159-8765-4321', '武汉市江岸区长江大道678号', 'zhangmin@example.com'),
('C008', '赵刚', '+86-137-5432-1098', '上海市浦东新区张江123号', 'zhaogang@example.com'),
('C009', '王丽', '+86-138-9876-5432', '广州市荔湾区沙面456号', 'wangli@example.com'),
('C010', '陈勇', '+86-136-8765-4321', '成都市武侯区太平洋百货890号', 'chenyong@example.com'),
('C011', '许雅楠', '+86-135-6543-2109', '北京市西城区西单大街123号', 'xuyanan@example.com'),
('C012', '姜雪', '+86-158-8765-4321', '上海市静安区南京西路456号', 'jiangxue@example.com'),
('C013', '黄勇', '+86-137-8765-4321', '广州市越秀区东风东路789号', 'huangyong@example.com'),
('C014', '朱敏', '+86-136-1234-5678', '深圳市南山区深南大道234号', 'zhumin@example.com'),
('C015', '马强', '+86-139-5678-1234', '重庆市江北区北城天街567号', 'maqiang@example.com'),
('C016', '吕梅', '+86-158-7654-3210', '南京市鼓楼区中山北路901号', 'lvmei@example.com'),
('C017', '宋磊', '+86-139-6543-2109', '武汉市汉阳区解放大道345号', 'songlei@example.com'),
('C018', '冯婷', '+86-159-8765-4321', '上海市徐汇区漕溪北路678号', 'fengting@example.com'),
('C019', '孙伟', '+86-137-5432-1098', '广州市海珠区新港西路123号', 'sunwei@example.com');

INSERT INTO `bank`.`loan` (`loan_id`, `client_id`, `bank_name`, `loan_total`, `remain_loan`, `loan_date`, `loan_rate`) VALUES ('10', '302300000000000000', 'xx1支行', '10000', '10000', '2022-11-11', '0.05');

INSERT INTO `bank`.`pay_status` (`pay_id`, `loan_id`, `pay_money`, `pay_date`) VALUES ('11', '10', '1000', '2022-12-12');
INSERT INTO `bank`.`pay_status` (`pay_id`, `loan_id`, `pay_money`, `pay_date`) VALUES ('12', '10', '3000', '2023-3-1');

INSERT INTO `bank`.`credit_account` (`account_id`, `client_id`, `bank_name`, `password`, `remaining`, `open_date`, `overdraft`) VALUES ('1', '123123200203150000', 'xx1支行', '123123', '3000', '2023-3-1', '10000');

INSERT INTO `bank`.`saving_account` (`account_id`, `client_id`, `bank_name`, `password`, `remaining`, `open_date`, `interest_rate`) VALUES ('2', '280800000000000000', 'xx1支行', '123456', '5000', '2023-2-1', '0.03');

CREATE table user
(  
   name            char(20)                       not null,
   password        char(20)                       not null,
   constraint pk_user primary key (name)
) ;

INSERT INTO `bank`.`user` (`name`, `password`) VALUES ('admin', '123456');
INSERT INTO `bank`.`user` (`name`, `password`) VALUES ('user', '111111');
