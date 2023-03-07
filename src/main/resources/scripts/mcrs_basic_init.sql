-- 基地数据
INSERT INTO `base_matrix_info` VALUES ('1', '0', '基地1', 'CS-0001', '江苏省常州市溧阳市环园西路328号', 'sysadmin', '2023-01-31 09:51:39', 'admin', '2023-03-05 13:49:07');
-- 工厂信息
INSERT INTO `base_factory_info` VALUES ('1', '1', 'CS1', 'F-0001', '江苏省常州市溧阳市环园西路328号', 'sysadmin', '2023-01-31 09:53:30', 'admin', '2023-03-05 13:49:29');
INSERT INTO `base_factory_info` VALUES ('2', '1', 'CS2', 'F-0002', '江苏省常州市溧阳市环园西路328号', 'sysadmin', '2023-02-08 11:30:48', 'admin', '2023-03-05 13:49:41');
INSERT INTO `base_factory_info` VALUES ('3', '1', 'CS3', 'F-0003', '江苏省常州市溧阳市环园西路328号', 'sysadmin', '2023-02-08 11:31:51', 'admin', '2023-03-05 13:49:48');
INSERT INTO `base_factory_info` VALUES ('4', '1', 'CS2-3', 'F-0004', '江苏省常州市溧阳市环园西路328号', 'sysadmin', '2023-02-08 13:29:01', 'admin', '2023-03-05 13:52:22');

-- 工序信息
INSERT INTO `base_process_info` VALUES ('1', '1', '冷压', 'P-0001', '冷压', 'sysadmin', '2023-01-31 09:57:57', '系统管理员', '2023-01-31 09:58:25');
INSERT INTO `base_process_info` VALUES ('2', '1', '模切', 'P-0002', '模切', 'sysadmin', '2023-01-31 09:58:27', null, null);
INSERT INTO `base_process_info` VALUES ('3', '1', '涂布', 'P-0003', '涂布', 'sysadmin', '2023-01-31 10:06:05', null, null);
INSERT INTO `base_process_info` VALUES ('4', '1', '贴胶', 'P-0004', '贴胶', 'sysadmin', '2023-02-08 11:32:47', null, null);
INSERT INTO `base_process_info` VALUES ('5', '2', '冷压', 'P-0005', '冷压', 'sysadmin', '2023-02-08 11:32:06', null, null);
INSERT INTO `base_process_info` VALUES ('6', '2', '模切', 'P-0006', '模切', 'sysadmin', '2023-02-08 11:33:00', null, null);
INSERT INTO `base_process_info` VALUES ('7', '2', '涂布', 'P-0007', '涂布', 'sysadmin', '2023-02-08 11:33:12', null, null);
INSERT INTO `base_process_info` VALUES ('8', '3', '冷压', 'P-0008', '冷压', 'sysadmin', '2023-02-08 11:35:33', null, null);
INSERT INTO `base_process_info` VALUES ('9', '3', '模切', 'P-0009', '模切', 'sysadmin', '2023-02-08 11:36:16', null, null);
INSERT INTO `base_process_info` VALUES ('10', '3', '涂布', 'P-0010', '涂布', 'sysadmin', '2023-02-08 11:36:25', '系统管理员', '2023-02-08 11:36:46');
INSERT INTO `base_process_info` VALUES ('11', '3', '卷绕', 'P-0011', '卷绕', 'sysadmin', '2023-02-08 11:36:54', null, null);
INSERT INTO `base_process_info` VALUES ('12', '4', '涂布', 'P-0012', '涂布', 'sysadmin', '2023-02-08 13:29:53', null, null);

-- 设备类型数据
INSERT INTO `base_equip_info` VALUES ('1', null, '0001', '101', '浩能', '冷压机', '欧姆龙', 'CIP', '10.133.14.1', '', 'admin', '2023-02-26 21:11:33', null, null);
INSERT INTO `base_equip_info` VALUES ('2', null, '0002', '101', '赢合', '冷压机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:22:09', null, null);
INSERT INTO `base_equip_info` VALUES ('3', null, '0003', '101', '嘉拓', '涂布机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:25:08', null, null);
INSERT INTO `base_equip_info` VALUES ('4', null, '0004', '101', '吉阳', '模切机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:25:54', null, null);
INSERT INTO `base_equip_info` VALUES ('5', null, '0005', '101', '海目星', '模切机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:26:29', null, null);
INSERT INTO `base_equip_info` VALUES ('6', null, '0006', '101', '时代上汽', '涂布机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:28:45', null, null);
INSERT INTO `base_equip_info` VALUES ('7', null, '0007', '101', '时代上汽', '涂布机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:29:54', null, null);
INSERT INTO `base_equip_info` VALUES ('8', null, '0008', '101', '时代上汽', '冷压机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:30:49', null, null);
INSERT INTO `base_equip_info` VALUES ('9', null, '0009', '101', '先导智能', '模切机', '倍福', 'ADS', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:31:55', null, null);
INSERT INTO `base_equip_info` VALUES ('10', null, '0010', '101', '先导智能', '在线贴胶机', '倍福', 'ADS', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:32:31', null, null);
INSERT INTO `base_equip_info` VALUES ('11', null, '0011', '101', '利元亨', '离线贴胶机', '汇川', 'Modbus-tcp', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:33:44', null, null);
INSERT INTO `base_equip_info` VALUES ('12', null, '0012', '101', '利元亨', '离线贴胶机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:34:56', null, null);
INSERT INTO `base_equip_info` VALUES ('13', null, '0013', '101', '吉阳', '离线贴胶机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:35:27', null, null);
INSERT INTO `base_equip_info` VALUES ('14', null, '0014', '101', '赢合', '涂布机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:36:44', null, null);
INSERT INTO `base_equip_info` VALUES ('15', null, '0015', '101', '易鸿', '冷压机', '西门子', 'S7-1500', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:37:23', null, null);
INSERT INTO `base_equip_info` VALUES ('16', null, '0016', '101', '先导智能', '模切机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:38:01', null, null);
INSERT INTO `base_equip_info` VALUES ('17', null, '0017', '101', '吉阳', '卷绕机', '欧姆龙', 'CIP', '10.133.14.1', '', 'sysadmin', '2023-03-05 11:38:34', null, null);


-- 接入点信息数据
INSERT INTO `base_access_info` VALUES ('1', '1', 'A-0001', 'CS1冷压', '101', 'admin', '2023-03-05 14:38:57', null, null);
INSERT INTO `base_access_info` VALUES ('2', '2', 'A-0002', 'CS1模切', '101', 'admin', '2023-03-05 14:40:35', null, null);
INSERT INTO `base_access_info` VALUES ('3', '3', 'A-0003', 'CS1涂布', '101', 'admin', '2023-03-05 14:41:04', null, null);
INSERT INTO `base_access_info` VALUES ('4', '4', 'A-0004', 'CS1贴胶', '101', 'admin', '2023-03-05 14:41:36', null, null);
INSERT INTO `base_access_info` VALUES ('5', '5', 'A-0005', 'CS2冷压', '101', 'admin', '2023-03-05 14:43:22', null, null);
INSERT INTO `base_access_info` VALUES ('6', '6', 'A-0006', 'CS2模切', '101', 'admin', '2023-03-05 14:43:40', null, null);
INSERT INTO `base_access_info` VALUES ('7', '7', 'A-0007', 'CS2涂布', '101', 'admin', '2023-03-05 14:43:59', null, null);
INSERT INTO `base_access_info` VALUES ('8', '8', 'A-0008', 'CS3冷压', '101', 'admin', '2023-03-05 14:46:09', null, null);
INSERT INTO `base_access_info` VALUES ('9', '9', 'A-0009', 'CS3模切', '101', 'admin', '2023-03-05 14:46:26', null, null);
INSERT INTO `base_access_info` VALUES ('10', '10', 'A-0010', 'CS3涂布', '101', 'admin', '2023-03-05 14:46:41', null, null);
INSERT INTO `base_access_info` VALUES ('11', '11', 'A-0011', 'CS3卷绕', '101', 'admin', '2023-03-05 14:46:58', null, null);
INSERT INTO `base_access_info` VALUES ('12', '12', 'A-0012', 'CS2-3涂布', '101', 'admin', '2023-03-05 14:48:47', null, null);
