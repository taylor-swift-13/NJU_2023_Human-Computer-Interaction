INSERT INTO bank.sub_bank (bank_name, bank_location, asset) VALUES ('北京支行', '北京', 42300000);
INSERT INTO bank.sub_bank (bank_name, bank_location, asset) VALUES ('南京支行', '南京', 24400000);

INSERT INTO bank.sub_bank (bank_name, bank_location, asset) VALUES ('上海支行', '上海', 23300000);
INSERT INTO bank.sub_bank (bank_name, bank_location, asset) VALUES ('浙江支行', '杭州', 20000000);

INSERT INTO bank.sub_bank (bank_name, bank_location, asset) VALUES ('辽宁支行', '沈阳', 20033000);



INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (1, 1, '南京支行', '服务部门', '服务');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (2, 2, '南京支行', '记账部门', '记账');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (3, 3, '北京支行', '服务部门', '服务');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (4, 4, '北京支行', '记账部门', '记账');

INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (5, 5, '上海支行', '风险部门', '风险监控');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (6, 6, '上海支行', '基金部门', '管理基金');

INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (7, 7, '上海支行', '记账部门', '记账');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (8, 8, '浙江支行', '服务部门', '服务');

INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (9, 9, '浙江支行', '股票部门', '股票管理');
INSERT INTO bank.department (depart_no, id, bank_name, depart_name, depart_type) VALUES (10, 10, '辽宁支行', '记账部门', '记账');



INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (1, 1, 1, '南京支行', '李明', 'M', '100000000000000001', '10000000001', 'abcD1-2-304', 100000, '2019-01-01', 7);
INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (2, 2, 2, '南京支行', '王华', 'W', '100000000000000000', '20000000000', 'ac 4-5-607', 100000, '2018-01-01', 8);
INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (3, 3, 3, '北京支行', 'jack', 'W', '200000000000000000', '12300000001', 'No22.Hankou road', 900000, '2018-07-01', 7);
INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (4, 4, 4, '北京支行', 'bob', 'M', '200000000000000001', '12300000002', 'No 21.Hankou road', 900000, '2018-08-01', 7);

INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (8, 5, 5, '上海支行', 'speed', 'M', '100000003560000001', '8726963', '123 Main Street', 100000, '2019-01-01', 9);
INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (28, 8, 8, '浙江支行', '李越', 'W', '123450000000000000', '20000000000', '345 Cherry Lane', 100000, '2018-01-05', 5);
INSERT INTO bank.member (id, depart_no, dep_depart_no, bank_name, name, sex, person_id, phone, address, salary, begin_date, level) VALUES (76, 10, 10, '辽宁支行', '赵四', 'W', '200000000000000000', '12300000001', '沈阳大街12号', 900000, '2015-07-01', 6);



INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('A001', 'Taylor Swift', '11301234567', '123 Main St, New York, USA', 'taylorswift13@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C000', '李娟', '13812345678', '上海市黄浦区南京东路123号', 'lijuan@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C001', '王伟', '13956781234', '北京市朝阳区建国路456号', 'wangwei@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C002', '张丽', '13787654321', '广州市天河区珠江新城789号', 'zhangli@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C003', '刘强', '13698765432', '深圳市福田区莲花山890号', 'liuqiang@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C004', '陈娜', '13587654321', '成都市锦江区春熙路567号', 'chenna@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C005', '杨洋', '15876543210', '重庆市渝中区解放碑901号', 'yangyang@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C006', '徐浩', '13965432109', '南京市玄武区中山路345号', 'xuhao@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C007', '张敏', '15987654321', '武汉市江岸区长江大道678号', 'zhangmin@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C008', '赵刚', '13754321098', '上海市浦东新区张江123号', 'zhaogang@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C009', '王丽', '13898765432', '广州市荔湾区沙面456号', 'wangli@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C010', '陈勇', '13687654321', '成都市武侯区太平洋百货890号', 'chenyong@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C011', '许雅楠', '13565432109', '北京市西城区西单大街123号', 'xuyanan@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C012', '姜雪', '15887654321', '上海市静安区南京西路456号', 'jiangxue@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C013', '黄勇', '13787654321', '广州市越秀区东风东路789号', 'huangyong@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C014', '朱敏', '13612345678', '深圳市南山区深南大道234号', 'zhumin@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C015', '马强', '13956781234', '重庆市江北区北城天街567号', 'maqiang@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C016', '吕梅', '15876543210', '南京市鼓楼区中山北路901号', 'lvmei@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C017', '宋磊', '13965432109', '武汉市汉阳区解放大道345号', 'songlei@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C018', '冯婷', '15987654321', '上海市徐汇区漕溪北路678号', 'fengting@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('C019', '孙伟', '13754321098', '广州市海珠区新港西路123号', 'sunwei@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('J001', '后藤一里', '19012345678', '東京都港区芝公園1-1-1', 'bocchi@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('J002', '伊地知虹夏', '18056781234', '大阪市中央区難波1-2-3', 'nijika@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('J003', '喜多郁代', '19087654321', '京都市左京区岡崎1-1-1', 'ikuyo@example.com');
INSERT INTO bank.client (client_id, real_name, client_phone, client_address, client_email) VALUES ('J004', '山田凉', '18054321098', '横浜市中区山下公園2-2-2', 'ryo@example.com');



INSERT INTO bank.saving_account (account_id, client_id, bank_name, password, remaining, open_date, interest_rate) VALUES (285587, 'A001', '上海支行', '6665555', 200, '2024-01-10', 3);

INSERT INTO bank.saving_account (account_id, client_id, bank_name, password, remaining, open_date, interest_rate) VALUES  (1, 'C001', '上海支行', '123456', 500, '2024-01-02', 2.5), (2, 'C002', '北京支行', '789012', 800, '2024-01-03', 2.8), (3, 'C003', '浙江支行', '345678', 1000, '2024-01-05', 3.2), (4, 'C004', '辽宁支行', '901234', 1200, '2024-01-08', 2.7), (5, 'C005', '上海支行', '567890', 1500, '2024-01-12', 3.5), (6, 'C006', '北京支行', '234567', 1800, '2024-01-15', 2.9), (7, 'C007', '浙江支行', '890123', 2000, '2024-01-18', 3.0), (8, 'C008', '辽宁支行', '456789', 2200, '2024-01-20', 3.3), (9, 'C009', '上海支行', '012345', 2500, '2024-01-22', 2.6), (10, 'C010', '北京支行', '678901', 2800, '2024-01-25', 3.1);



INSERT INTO bank.credit_account (account_id, client_id, bank_name, password, remaining, open_date, overdraft) VALUES  (1, 'C001', '上海支行', '123123', 0, '2023-03-01', 5000), (2, 'C002', '北京支行', '456456', 3000, '2023-03-02', 8000), (3, 'C003', '浙江支行', '789789', 0, '2023-03-03', 6000), (4, 'C004', '辽宁支行', '012012', 3500, '2023-03-04', 7000), (5, 'C005', '上海支行', '345345', 4000, '2023-03-05', 9000), (6, 'C006', '北京支行', '678678', 1500, '2023-03-06', 4000), (7, 'C007', '浙江支行', '901901', 0, '2023-03-07', 3000), (8, 'C008', '辽宁支行', '234234', 3200, '2023-03-08', 7000), (9, 'C009', '上海支行', '567567', 2700, '2023-03-09', 6000), (10, 'C010', '北京支行', '890890', 2200, '2023-03-10', 5000), (11, 'C005', '浙江支行', '123123', 4000, '2023-03-11', 8000), (12, 'C002', '辽宁支行', '456456', 1800, '2023-03-12', 4000), (13, 'C011', '上海支行', '789789', 3500, '2023-03-13', 7000), (14, 'C004', '北京支行', '012012', 2500, '2023-03-14', 6000), (15, 'C005', '浙江支行', '345345', 0, '2023-03-15', 9000);



























