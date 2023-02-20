/*
Navicat MySQL Data Transfer

Source Server         : mysql5
Source Server Version : 50550
Source Host           : localhost:3305
Source Database       : mcrs

Target Server Type    : MYSrQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2022-12-15 09:22:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_application
-- ----------------------------
DROP TABLE IF EXISTS `app_application`;
CREATE TABLE `app_application` (
   `app_id` int(9) NOT NULL AUTO_INCREMENT,
   `app_code` varchar(32) DEFAULT NULL,
   `app_name` varchar(50) DEFAULT NULL,
   `app_type` varchar(32) DEFAULT NULL,
   `display_order` int(6) DEFAULT NULL,
   `is_open` char(1) DEFAULT NULL,
   `open_date` date DEFAULT NULL,
   `protocol_type` varchar(64) DEFAULT NULL,
   `ip_addr` varchar(50) DEFAULT NULL,
   `ip_port` varchar(10) DEFAULT NULL,
   `url` varchar(256) DEFAULT NULL,
   `app_desc` varchar(512) DEFAULT NULL,
   `app_info` varchar(64) DEFAULT NULL,
   `tenant_id` varchar(64) NOT NULL,
   PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_function
-- ----------------------------
DROP TABLE IF EXISTS `app_function`;
CREATE TABLE `app_function` (
    `func_code` varchar(64) NOT NULL,
    `func_name` varchar(128) NOT NULL,
    `func_desc` varchar(512) DEFAULT NULL,
    `func_action` varchar(256) DEFAULT NULL,
    `para_info` varchar(256) DEFAULT NULL,
    `is_check` char(1) DEFAULT NULL,
    `func_type` varchar(32) DEFAULT '1',
    `display_order` int(6) DEFAULT NULL,
    `is_menu` char(1) DEFAULT NULL,
    `app_info` varchar(64) DEFAULT NULL,
    `tenant_id` varchar(64) NOT NULL,
    `func_group_id` int(9) DEFAULT NULL,
    PRIMARY KEY (`func_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_func_group
-- ----------------------------
DROP TABLE IF EXISTS `app_func_group`;
CREATE TABLE `app_func_group` (
  `func_group_id` int(9) NOT NULL AUTO_INCREMENT,
  `app_id` int(9) NOT NULL,
  `func_group_name` varchar(40) DEFAULT NULL,
  `parent_func_group_id` int(9) DEFAULT NULL,
  `group_level` int(9) DEFAULT NULL,
  `func_group_seq` varchar(256) DEFAULT NULL,
  `display_order` int(6) DEFAULT NULL,
  `is_leaf` char(1) DEFAULT NULL,
  `sub_count` int(9) DEFAULT NULL,
  `app_info` varchar(64) DEFAULT NULL,
  `tenant_id` varchar(64) NOT NULL,
  PRIMARY KEY (`func_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=921 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_func_resource
-- ----------------------------
DROP TABLE IF EXISTS `app_func_resource`;
CREATE TABLE `app_func_resource` (
 `res_id` int(9) NOT NULL AUTO_INCREMENT,
 `func_code` varchar(64) DEFAULT NULL,
 `res_type` varchar(64) DEFAULT NULL,
 `res_path` varchar(256) DEFAULT NULL,
 `com_pack_name` varchar(64) DEFAULT NULL,
 `res_name` varchar(64) DEFAULT NULL,
 `app_info` varchar(64) DEFAULT NULL,
 `tenant_id` varchar(64) NOT NULL,
 PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu` (
    `MENU_ID` int(9) NOT NULL,
    `PARENT_MENU_ID` varchar(40) DEFAULT NULL,
    `MENU_NAME` varchar(40) NOT NULL,
    `MENU_LABEL` varchar(40) NOT NULL,
    `MENU_CODE` varchar(40) DEFAULT NULL,
    `IS_LEAF` varchar(1) DEFAULT NULL,
    `PARAMETER` varchar(256) DEFAULT NULL,
    `MENU_LEVEL` smallint(6) DEFAULT NULL,
    `DISPLAY_ORDER` smallint(6) DEFAULT NULL,
    `IMAGE_PATH` varchar(100) DEFAULT NULL,
    `EXPAND_PATH` varchar(100) DEFAULT NULL,
    `MENU_SEQ` varchar(256) DEFAULT NULL,
    `OPEN_MODE` varchar(255) DEFAULT NULL,
    `SUB_COUNT` decimal(10,0) DEFAULT NULL,
    `APP_ID` decimal(10,0) DEFAULT NULL,
    `FUNC_CODE` varchar(255) DEFAULT NULL,
    `APP_INFO` varchar(64) DEFAULT NULL,
    `TENANT_ID` varchar(64) DEFAULT NULL,
    PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_cols_filter
-- ----------------------------
DROP TABLE IF EXISTS `base_cols_filter`;
CREATE TABLE `base_cols_filter` (
    `FUN_NAME` varchar(30) NOT NULL,
    `FIELD` varchar(20) NOT NULL,
    `USER_ID` varchar(64) DEFAULT NULL,
    PRIMARY KEY (`FUN_NAME`,`FIELD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for cap_party_auth
-- ----------------------------
DROP TABLE IF EXISTS `cap_party_auth`;
CREATE TABLE `cap_party_auth` (
    `ROLE_TYPE` varchar(64) NOT NULL,
    `PARTY_ID` varchar(64) NOT NULL,
    `PARTY_TYPE` varchar(64) NOT NULL,
    `ROLE_ID` varchar(64) NOT NULL,
    `TENANT_ID` varchar(64) DEFAULT NULL,
    `CREATE_USER` varchar(64) DEFAULT NULL,
    `CREATE_TIME` datetime NOT NULL,
    PRIMARY KEY (`ROLE_TYPE`,`PARTY_ID`,`PARTY_TYPE`,`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cap_res_auth
-- ----------------------------
DROP TABLE IF EXISTS `cap_res_auth`;
CREATE TABLE `cap_res_auth` (
    `PARTY_ID` varchar(64) NOT NULL,
    `PARTY_TYPE` varchar(64) NOT NULL,
    `RES_ID` varchar(255) NOT NULL,
    `RES_TYPE` varchar(64) NOT NULL,
    `TENANT_ID` varchar(64) DEFAULT NULL,
    `RES_STATE` varchar(512) NOT NULL,
    `PARTY_SCOPE` varchar(1) DEFAULT '0',
    `CREATE_USER` varchar(64) DEFAULT NULL,
    `CREATE_TIME` datetime DEFAULT NULL,
    PRIMARY KEY (`PARTY_ID`,`PARTY_TYPE`,`RES_ID`,`RES_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cap_role
-- ----------------------------
DROP TABLE IF EXISTS `cap_role`;
CREATE TABLE `cap_role` (
    `role_id` int(9) NOT NULL AUTO_INCREMENT,
    `role_code` varchar(32) DEFAULT NULL,
    `role_name` varchar(255) DEFAULT NULL,
    `role_desc` varchar(255) DEFAULT NULL,
    `creator` varchar(255) DEFAULT NULL,
    `create_time` datetime DEFAULT NULL,
    PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cap_user
-- ----------------------------
DROP TABLE IF EXISTS `cap_user`;
CREATE TABLE `cap_user` (
    `OPERATOR_ID` int(9) NOT NULL AUTO_INCREMENT,
    `TENANT_ID` varchar(64) DEFAULT NULL,
    `USER_ID` varchar(64) NOT NULL,
    `PASSWORD` varchar(100) DEFAULT NULL,
    `INVAL_DATE` date DEFAULT NULL,
    `USER_NAME` varchar(64) DEFAULT NULL,
    `AUTH_MODE` varchar(255) DEFAULT NULL,
    `STATUS` varchar(16) DEFAULT NULL,
    `UNLOCK_TIME` datetime DEFAULT NULL,
    `MENU_TYPE` varchar(255) DEFAULT NULL,
    `LAST_LOGIN` datetime DEFAULT NULL,
    `ERR_COUNT` decimal(10,0) DEFAULT NULL,
    `START_DATE` date DEFAULT NULL,
    `END_DATE` date DEFAULT NULL,
    `VALID_TIME` varchar(255) DEFAULT NULL,
    `MAC_CODE` varchar(128) DEFAULT NULL,
    `IP_ADDRESS` varchar(128) DEFAULT NULL,
    `EMAIL` varchar(255) DEFAULT NULL,
    `CREATOR` varchar(64) DEFAULT NULL,
    `CREATE_TIME` datetime NOT NULL,
    `USER_TYPE` varchar(64) DEFAULT NULL,
    `USER_PHONE` varchar(255) DEFAULT NULL,
    `USER_DESCRIPTION` varchar(255) DEFAULT NULL,
    `UPDATER` varchar(64) DEFAULT NULL,
    `UPDATE_TIME` datetime DEFAULT NULL,
    PRIMARY KEY (`OPERATOR_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cap_user
-- ----------------------------
INSERT INTO `cap_user` VALUES ('1', 'default', 'sysadmin', 'k2xvHUmCHWw=', '2028-06-10', '系统管理员', 'local', '102', '2013-03-16 11:58:31', 'default', '2013-03-16 11:58:31', null, null, null, null, null, null, null, 'sysadmin', '2013-03-16 11:58:31', '101', null, null, null, null);

-- ----------------------------
-- Table structure for dev_rollback
-- ----------------------------
DROP TABLE IF EXISTS `dev_rollback`;
CREATE TABLE `dev_rollback` (
    `device_rollback_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
    `equipment_int` int(255) DEFAULT NULL COMMENT '设备主键',
    `device_id` int(255) DEFAULT NULL COMMENT '终端主键',
    `upload_id` int(255) DEFAULT NULL COMMENT '更新包主键',
    `rollback_before_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
    `upgrade_status` varchar(255) DEFAULT NULL COMMENT '升级状态',
    `version_rollback_people` varchar(255) DEFAULT NULL COMMENT '版本更改人',
    `version_rollback_time` varchar(255) DEFAULT NULL COMMENT '版本更改时间',
    PRIMARY KEY (`device_rollback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for dev_upgrade
-- ----------------------------
DROP TABLE IF EXISTS `dev_upgrade`;
CREATE TABLE `dev_upgrade` (
   `device_upgrade_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
   `equipment_int` int(255) DEFAULT NULL COMMENT '设备主键',
   `device_id` int(255) DEFAULT NULL COMMENT '终端主键',
   `upload_id` int(255) DEFAULT NULL COMMENT '更新包主键',
   `upgrade_before_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
   `upgrade_status` varchar(255) DEFAULT NULL COMMENT '升级状态',
   `version_updater` varchar(255) DEFAULT NULL COMMENT '版本更改人',
   `version_update_time` varchar(255) DEFAULT NULL COMMENT '版本更改时间',
   PRIMARY KEY (`device_upgrade_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


-- ----------------------------
-- Table structure for dict_entry
-- ----------------------------
DROP TABLE IF EXISTS `dict_entry`;
CREATE TABLE `dict_entry` (
    `DICTTYPEID` varchar(128) NOT NULL,
    `DICTID` varchar(128) NOT NULL,
    `DICTNAME` varchar(255) DEFAULT NULL,
    `STATUS` int(11) DEFAULT NULL,
    `SORTNO` int(11) DEFAULT NULL,
    `RANK` int(11) DEFAULT NULL,
    `PARENTID` varchar(255) DEFAULT NULL,
    `SEQNO` varchar(255) DEFAULT NULL,
    `FILTER1` varchar(255) DEFAULT NULL,
    `FILTER2` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`DICTTYPEID`,`DICTID`),
    KEY `ZIMAX_DICT_ENTRYINDEX` (`DICTTYPEID`,`DICTID`,`SEQNO`),
    CONSTRAINT `dict_entry_ibfk_1` FOREIGN KEY (`DICTTYPEID`) REFERENCES `dict_type` (`DICTTYPEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type` (
    `DICTTYPEID` varchar(128) NOT NULL,
    `DICTTYPENAME` varchar(255) DEFAULT NULL,
    `RANK` int(11) DEFAULT NULL,
    `PARENTID` varchar(255) DEFAULT NULL,
    `SEQNO` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`DICTTYPEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eqi_device
-- ----------------------------
DROP TABLE IF EXISTS `eqi_device`;
CREATE TABLE `eqi_device`  (
   `device_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '终端主键',
   `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'APPId',
   `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本号',
   `enable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
   `register_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册状态',
   `device_software_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端软件类型',
   `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端名称',
   `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
   `access_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接入方式',
   `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
   `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
   `program_installation_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端程序安装路径',
   `executor_installation_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端执行程序安装路径',
   PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for eqi_equipment
-- ----------------------------
DROP TABLE IF EXISTS `eqi_equipment`;
CREATE TABLE `eqi_equipment`  (
  `equipment_int` int(9) NOT NULL AUTO_INCREMENT COMMENT '设备主键',
  `equipment_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备资源号',
  `equipment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `equipment_install_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备安装位置',
  `equip_type_id` int(9) NULL DEFAULT NULL COMMENT '设备信息主键',
  `equipment_continue_port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备连接端口',
  `equipment_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备连接IP',
  `acc_point_res_id` int(9) NULL DEFAULT NULL COMMENT '接入点资源维护数据的主键',
  `enable` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`equipment_int`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for rep_abn_prod_prcs
-- ----------------------------
DROP TABLE IF EXISTS `rep_abn_prod_prcs`;
CREATE TABLE `rep_abn_prod_prcs` (
         `abn_PP_id` int(11) NOT NULL AUTO_INCREMENT,
         `site_id` varchar(6) NOT NULL,
         `roll_id` varchar(6) NOT NULL,
         `equipment_id` varchar(64) NOT NULL,
         `axis_name` varchar(64) NOT NULL,
         `vehicle_code` varchar(64) NOT NULL,
         `prod_SFC_id` varchar(128) NOT NULL,
         `end_EA_number` varchar(38) NOT NULL,
         `perform_step` varchar(6) NOT NULL,
         `is_end` varchar(6) NOT NULL,
         `create_time` datetime NOT NULL,
         `update_time` datetime NOT NULL,
         PRIMARY KEY (`abn_PP_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for rep_blanking
-- ----------------------------
DROP TABLE IF EXISTS `rep_blanking`;
CREATE TABLE `rep_blanking` (
    `blanking_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(64) NOT NULL,
    `axis_name` varchar(64) NOT NULL,
    `antenna_loc` varchar(64) NOT NULL,
    `vehicle_code` varchar(64) NOT NULL,
    `prod_SFC_id` varchar(128) NOT NULL,
    `end_EA_number` varchar(38) NOT NULL,
    `in_meter_number` varchar(38) NOT NULL,
    `is_end` varchar(4) NOT NULL,
    `create_time` datetime NOT NULL,
    `start_prod_time` datetime NOT NULL,
    `end_prod_time` datetime NOT NULL,
    PRIMARY KEY (`blanking_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for rep_feeding
-- ----------------------------
DROP TABLE IF EXISTS `rep_feeding`;
CREATE TABLE `rep_feeding` (
       `feeding_id` int(11) NOT NULL AUTO_INCREMENT,
       `equipment_id` varchar(64) NOT NULL,
       `axis_name` varchar(64) NOT NULL,
       `in_SFC_id` varchar(128) NOT NULL,
       `vehicle_code` varchar(128) NOT NULL,
       `prod_SFC_id` varchar(128) NOT NULL,
       `prod_number` varchar(38) NOT NULL,
       `create_time` datetime NOT NULL,
       `start_prod_time` datetime NOT NULL,
       `end_prod_time` datetime NOT NULL,
       PRIMARY KEY (`feeding_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for rep_rfid
-- ----------------------------
DROP TABLE IF EXISTS `rep_rfid`;
CREATE TABLE `rep_rfid` (
    `rfid_read_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(64) NOT NULL,
    `RFID_id` varchar(64) NOT NULL,
    `antenna_id` varchar(64) NOT NULL,
    `read_rate` varchar(6) NOT NULL,
    `record_time` datetime NOT NULL,
    PRIMARY KEY (`rfid_read_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
-- ----------------------------
-- Table structure for war_alarm_event
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_event`;
CREATE TABLE `war_alarm_event`  (
    `alarm_event_int` int(9) NOT NULL AUTO_INCREMENT COMMENT '预警事件主键',
    `alarm_event_id` int(11) NOT NULL COMMENT '预警事件编码',
    `alarm_event_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警事件标题',
    `enable_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
    `alarm_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警级别',
    `upper_limit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上限',
    `lower_limit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下限',
    `alarm_event_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警信息内容',
    `alarm_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警类型',
    `make_form_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单人',
    `make_form_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单时间',
    `update_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `update_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`alarm_event_int`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for war_alarm_rule
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_rule`;
CREATE TABLE `war_alarm_rule`  (
    `alarm_rule_int` int(255) NOT NULL AUTO_INCREMENT COMMENT '预警规则主键',
    `alarm_rule_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警规则编码',
    `alarm_rule_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警规则标题',
    `enable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
    `monitor_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控层级',
    `alarm_event_int` int(255) NULL DEFAULT NULL COMMENT '预警事件主键',
    `alarm_rule_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警规则描述',
    `rule_make_form_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单人',
    `rule_make_form_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单时间',
    `rule_update_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `rule_update_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ruleUpdateTime',
    PRIMARY KEY (`alarm_rule_int`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1250 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for upd_upload
-- ----------------------------
    DROP TABLE IF EXISTS `upd_upload`;
    CREATE TABLE `upd_upload` (
      `upload_id` int(11) NOT NULL AUTO_INCREMENT,
      `upload_number` varchar(255) DEFAULT NULL,
      `version` varchar(255) DEFAULT NULL,
      `device_so_type` varchar(255) DEFAULT NULL,
      `upload_strategy` varchar(255) DEFAULT NULL,
      `file_name` varchar(255) DEFAULT NULL,
      `uploader` varchar(255) DEFAULT NULL,
      `version_upload_time` datetime DEFAULT NULL,
      `remarks` varchar(255) DEFAULT NULL,
      `major_version` varchar(255) DEFAULT NULL,
      `download_url` varchar(255) DEFAULT NULL,
      `upload_uu_id` varchar(255) DEFAULT NULL,
      `upload_file_size` double DEFAULT NULL,
      `upload_file_type` varchar(255) DEFAULT NULL,
      `uuid_file` varchar(255) DEFAULT NULL,
      `updater` varchar(255) DEFAULT NULL,
      `version_update_time` datetime DEFAULT NULL,
      PRIMARY KEY (`upload_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for log_interface_log
-- ----------------------------
DROP TABLE IF EXISTS `log_interface_log`;
CREATE TABLE `log_interface_log`  (
  `interface_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '接口日志主键',
  `interface_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口日志编号',
  `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源',
  `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
  `device_id` int(9) NULL DEFAULT NULL COMMENT '终端主键',
  `interface_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `json_page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JSON包',
  `dispose_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `invoker` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调用者',
  `dispose_time` datetime NULL DEFAULT NULL COMMENT '处理时长',
  `interface_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口类型',
  PRIMARY KEY (`interface_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for log_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `log_operation_log`;
CREATE TABLE `log_operation_log`  (
  `operation_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '操作日志主键',
  `operation_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作日志编号',
  `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `log_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志状态',
  `operation_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `operation_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `operation_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作结果',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `operation_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`operation_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for log_device_exchange_log
-- ----------------------------
DROP TABLE IF EXISTS `log_device_exchange_log`;
CREATE TABLE `log_device_exchange_log`  (
    `device_exchange_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '设备交换日志主键',
    `device_exchange_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备交换日志编号',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
    `device_id` int(9) NULL DEFAULT NULL COMMENT '终端主键',
    `operation_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
    `operation_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
    `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
    `exchange_time` datetime NULL DEFAULT NULL COMMENT '交互时间',
    PRIMARY KEY (`device_exchange_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;


# 编码规则
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for base_coding_serialnumber
-- ----------------------------
DROP TABLE IF EXISTS `base_coding_serialnumber`;
CREATE TABLE `base_coding_serialnumber` (
    `id` int(18) NOT NULL AUTO_INCREMENT,
    `rule_name` varchar(255) DEFAULT NULL,
    `digit` int(18) DEFAULT NULL,
    `startvalue` int(18) DEFAULT NULL,
    `currentvalue` int(18) DEFAULT NULL,
    `note` varchar(255) DEFAULT NULL,
    `function_num` varchar(255) DEFAULT NULL,
    `function_name` varchar(255) DEFAULT NULL,
    `number_rule` varchar(255) DEFAULT NULL,
    `num_basis` varchar(255) DEFAULT NULL,
    `title_rule` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

# plc点位组管理
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dev_plc_group
-- ----------------------------
DROP TABLE IF EXISTS `dev_plc_group`;
CREATE TABLE `dev_plc_group` (
    `plc_group_id` int(9) NOT NULL AUTO_INCREMENT,
    `plc_group_name` varchar(64) DEFAULT NULL,
    `plc_group_type` varchar(32) DEFAULT NULL,
    `plc_group_rname` varchar(32) DEFAULT NULL COMMENT '组映射RFID名称',
    `rfid_num` varchar(32) DEFAULT NULL COMMENT 'rfid天线编码',
    `remarks` varchar(255) DEFAULT NULL,
    `app_id` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`plc_group_id`),
    KEY `app_id` (`app_id`) USING BTREE,
    CONSTRAINT `dev_plc_group_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `dev_point_dispose` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

# plc点位参数
-- ----------------------------
-- Table structure for dev_plcparam_dispose
-- ----------------------------
DROP TABLE IF EXISTS `dev_plcparam_dispose`;
CREATE TABLE `dev_plcparam_dispose` (
    `plc_param_id` int(9) NOT NULL AUTO_INCREMENT,
    `shine_addr` varchar(64) DEFAULT NULL COMMENT '映射地址',
    `lable_name` varchar(64) DEFAULT NULL COMMENT '标签名称',
    `data_type` varchar(32) DEFAULT NULL COMMENT '数据类型',
    `param_len` int(9) DEFAULT NULL COMMENT '参数长度',
    `small_point` int(9) DEFAULT NULL COMMENT '小数位数',
    `chinese_mean` varchar(255) DEFAULT NULL COMMENT '中文释义',
    `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
    `plc_group_id` int(9) DEFAULT NULL,
    PRIMARY KEY (`plc_param_id`),
    KEY `plc_group_id` (`plc_group_id`),
    CONSTRAINT `dev_plcparam_dispose_ibfk_1` FOREIGN KEY (`plc_group_id`) REFERENCES `dev_plc_group` (`plc_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

    # 点位配置
    -- ----------------------------
    -- Table structure for dev_point_dispose
    -- ----------------------------
    DROP TABLE IF EXISTS `dev_point_dispose`;
    CREATE TABLE `dev_point_dispose` (
        `app_id` varchar(255) NOT NULL,
        `down_work` varchar(255) DEFAULT NULL COMMENT '下料执行作业',
        `up_work` varchar(255) DEFAULT NULL COMMENT '上料执行作业',
        `up_model` varchar(255) DEFAULT NULL COMMENT '上料过账模式',
        `down_model` varchar(255) DEFAULT NULL COMMENT '下料过账模式',
        `data_unit` varchar(32) DEFAULT NULL,
        `data_method` varchar(32) DEFAULT NULL COMMENT '数据计算方法',
        `chip_length` int(10) DEFAULT NULL COMMENT '单片机长度',
        `scale` int(10) DEFAULT NULL COMMENT '比例',
        `ratio` int(10) DEFAULT NULL COMMENT '系数',
        `check_param` int(10) DEFAULT NULL COMMENT '检查参数',
        `roll_diameter` int(10) DEFAULT NULL COMMENT '放卷卸料设定',
        `lable_cycle` int(10) DEFAULT NULL,
        `monitor_date` int(9) DEFAULT NULL,
        PRIMARY KEY (`app_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

    # rfid点位组
    -- ----------------------------
    -- Table structure for dev_rfid_group
    -- ----------------------------
    DROP TABLE IF EXISTS `dev_rfid_group`;
    CREATE TABLE `dev_rfid_group` (
        `rfid_group_id` int(9) NOT NULL AUTO_INCREMENT,
        `rfid_num` varchar(32) DEFAULT NULL,
        `ip_addr` varchar(64) DEFAULT NULL,
        `port` varchar(32) DEFAULT NULL,
        `app_id` varchar(255) DEFAULT NULL,
        PRIMARY KEY (`rfid_group_id`),
        KEY `app_id` (`app_id`),
        CONSTRAINT `dev_rfid_group_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `dev_point_dispose` (`app_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

    # rfid点位参数配置
    -- ----------------------------
    -- Table structure for dev_rfidparam_dispose
    -- ----------------------------
    DROP TABLE IF EXISTS `dev_rfidparam_dispose`;
    CREATE TABLE `dev_rfidparam_dispose` (
        `rfid_param_id` int(9) NOT NULL AUTO_INCREMENT,
        `param_name` varchar(32) DEFAULT '' COMMENT '参数名称',
        `param_key` varchar(64) DEFAULT '' COMMENT '参数主键',
        `param_value` varchar(32) DEFAULT NULL COMMENT '参数值',
        `param_mark` varchar(32) DEFAULT NULL COMMENT '参数标记',
        `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
        `rfid_group_id` int(9) DEFAULT NULL,
        PRIMARY KEY (`rfid_param_id`),
        KEY `rfid_group_id` (`rfid_group_id`),
        CONSTRAINT `dev_rfidparam_dispose_ibfk_1` FOREIGN KEY (`rfid_group_id`) REFERENCES `dev_rfid_group` (`rfid_group_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

    -- ----------------------------
-- Table structure for bas_log_delete_rule
-- ----------------------------
DROP TABLE IF EXISTS `bas_log_delete_rule`;
CREATE TABLE `bas_log_delete_rule`  (
    `rule_delete_id` int(9) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志主键',
    `delete_rule_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除规则标题',
    `enable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
    `delete_rule_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志删除规则类型',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `retention_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '保留时间数（天）',
    `updater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`rule_delete_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bas_log_delete_rule
-- ----------------------------
INSERT INTO `bas_log_delete_rule` VALUES (1, '登录日志删除规则', '102', '101', '101', '1', 'sysadmin', '2023-01-30 10:39:07');
INSERT INTO `bas_log_delete_rule` VALUES (2, '接口日志删除规则', '102', '101', '102', '1', 'sysadmin', '2023-01-28 08:49:49');
INSERT INTO `bas_log_delete_rule` VALUES (3, '操作日志删除规则', '102', '101', '103', '1', 'sysadmin', '2023-01-29 16:34:05');
INSERT INTO `bas_log_delete_rule` VALUES (4, '设备交换日志删除规则', '102', '101', '104', '1', 'sysadmin', '2023-01-28 08:49:49');
INSERT INTO `bas_log_delete_rule` VALUES (5, 'PLC交互日志删除规则', '102', '101', '105', '1', 'sysadmin', '2023-01-30 10:29:03');
INSERT INTO `bas_log_delete_rule` VALUES (6, 'RFID交互日志删除规则', '102', '101', '106', '1', 'sysadmin', '2023-01-30 10:23:12');
INSERT INTO `bas_log_delete_rule` VALUES (7, 'MES交互日志删除规则', '102', '101', '107', '1', 'sysadmin', '2023-01-30 10:08:28');
INSERT INTO `bas_log_delete_rule` VALUES (8, '异常日志删除规则', '102', '101', '108', '1', 'sysadmin', '2023-01-30 11:05:02');

SET FOREIGN_KEY_CHECKS = 1;


    -- ----------------------------
    -- Table structure for base_tree
    -- ----------------------------
    DROP TABLE IF EXISTS `base_tree`;
    CREATE TABLE `base_tree` (
        `info_id` int(11) NOT NULL AUTO_INCREMENT,
        `info_name` varchar(40) DEFAULT NULL,
        `display_order` int(11) DEFAULT NULL,
        `info_seq` varchar(255) DEFAULT NULL,
        `sub_count` int(11) DEFAULT NULL,
        `info_type` varchar(255) DEFAULT NULL,
        `parent_id` int(11) DEFAULT NULL,
        `logic_states` int(11) DEFAULT '0',
        PRIMARY KEY (`info_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

    -- ----------------------------
    -- Records of base_tree
    -- ----------------------------
    INSERT INTO `base_tree` VALUES ('1', '业务字典', '1', null, '0', null, null, '0');
    INSERT INTO `base_tree` VALUES ('2', 'MCRS基地信息维护', '2', null, '0', null, null, '0');


-- ----------------------------
-- Table structure for base_coding_serialnumber
-- ----------------------------
DROP TABLE IF EXISTS `base_coding_serialnumber`;
CREATE TABLE `base_coding_serialnumber` (
    `id` int(18) NOT NULL AUTO_INCREMENT,
    `rule_name` varchar(255) DEFAULT NULL,
    `digit` int(18) DEFAULT NULL,
    `startvalue` int(18) DEFAULT NULL,
    `currentvalue` int(18) DEFAULT NULL,
    `note` varchar(255) DEFAULT NULL,
    `function_num` varchar(255) DEFAULT NULL,
    `function_name` varchar(255) DEFAULT NULL,
    `number_rule` varchar(255) DEFAULT NULL,
    `num_basis` varchar(255) DEFAULT NULL,
    `title_rule` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_coding_serialnumber
-- ----------------------------
INSERT INTO `base_coding_serialnumber` VALUES ('1', 'gxCod', '4', '1', '0', '备注', 'gxCod', '更新包单号', '{N}', 'WFprocess', 'GX-{Y}{M}{D}-');
INSERT INTO `base_coding_serialnumber` VALUES ('2', 'sbCod', '4', '1', '0', '备注', 'sbCod', '设备流水', '{N}', 'WFprocess', '_');
INSERT INTO `base_coding_serialnumber` VALUES ('3', 'jdCod', '4', '1', '0', '备注', 'jdCod', '基地编号', '{N}', 'WFprocess', 'CS-');
INSERT INTO `base_coding_serialnumber` VALUES ('4', 'gcCod', '4', '1', '0', '备注', 'gcCod', '工厂编号', '{N}', 'WFprocess', 'F-');
INSERT INTO `base_coding_serialnumber` VALUES ('5', 'gxpCod', '4', '1', '0', '备注', 'gxpCod', '工序编号', '{N}', 'WFprocess', 'P-');
INSERT INTO `base_coding_serialnumber` VALUES ('6', 'jrdCod', '4', '1', '0', '备注', 'jrdCod', '接入点编号', '{N}', 'WFprocess', 'A-');

    -- ----------------------------
    -- Table structure for base_equip_info
    -- ----------------------------
    DROP TABLE IF EXISTS `base_equip_info`;
    CREATE TABLE `base_equip_info` (
       `equip_type_id` int(11) NOT NULL AUTO_INCREMENT,
       `info_id` int(11) DEFAULT NULL,
       `equip_type_code` varchar(255) DEFAULT NULL,
       `equip_type_enable` varchar(255) DEFAULT NULL,
       `manufacturer` varchar(255) DEFAULT NULL,
       `equip_type_name` varchar(255) DEFAULT NULL,
       `equip_controller_model` varchar(255) DEFAULT NULL,
       `protocol_communication` varchar(255) DEFAULT NULL,
       `mes_ip_address` varchar(255) DEFAULT NULL,
       `remarks` varchar(255) DEFAULT NULL,
       `creator` varchar(255) DEFAULT NULL,
       `create_time` datetime DEFAULT NULL,
       `updater` varchar(255) DEFAULT NULL,
       `update_time` datetime DEFAULT NULL,
       PRIMARY KEY (`equip_type_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

    -- ----------------------------
    -- Records of base_equip_info
    -- ----------------------------

    -- ----------------------------
-- ----------------------------
-- Table structure for base_access_info
-- ----------------------------
    DROP TABLE IF EXISTS `base_access_info`;
    CREATE TABLE `base_access_info` (
        `acc_point_res_id` int(11) NOT NULL AUTO_INCREMENT,
        `process_id` int(11) DEFAULT NULL,
        `acc_point_res_code` varchar(255) DEFAULT NULL,
        `acc_point_res_name` varchar(255) DEFAULT NULL,
        `is_enable` varchar(255) DEFAULT NULL,
        `creator` varchar(255) DEFAULT NULL,
        `create_time` datetime DEFAULT NULL,
        `updater` varchar(255) DEFAULT NULL,
        `update_time` datetime DEFAULT NULL,
        PRIMARY KEY (`acc_point_res_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

    -- ----------------------------
    -- Table structure for base_factory_info
    -- ----------------------------
    DROP TABLE IF EXISTS `base_factory_info`;
    CREATE TABLE `base_factory_info` (
         `factory_id` int(11) NOT NULL AUTO_INCREMENT,
         `matrix_id` int(11) DEFAULT NULL,
         `factory_name` varchar(255) DEFAULT NULL,
         `factory_code` varchar(255) DEFAULT NULL,
         `factory_address` varchar(255) DEFAULT NULL,
         `creator` varchar(255) DEFAULT NULL,
         `create_time` datetime DEFAULT NULL,
         `updater` varchar(255) DEFAULT NULL,
         `update_time` datetime DEFAULT NULL,
         PRIMARY KEY (`factory_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

    -- ----------------------------
    -- Table structure for base_matrix_info
    -- ----------------------------
    DROP TABLE IF EXISTS `base_matrix_info`;
    CREATE TABLE `base_matrix_info` (
        `matrix_id` int(11) NOT NULL AUTO_INCREMENT,
        `parent_id` varchar(255) DEFAULT NULL,
        `matrix_name` varchar(255) DEFAULT NULL,
        `matrix_code` varchar(255) DEFAULT NULL,
        `matrix_address` varchar(255) DEFAULT NULL,
        `creator` varchar(255) DEFAULT NULL,
        `create_time` datetime DEFAULT NULL,
        `updater` varchar(255) DEFAULT NULL,
        `update_time` datetime DEFAULT NULL,
        PRIMARY KEY (`matrix_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

    -- ----------------------------
    -- Table structure for base_process_info
    -- ----------------------------
    DROP TABLE IF EXISTS `base_process_info`;
    CREATE TABLE `base_process_info` (
         `process_id` int(11) NOT NULL AUTO_INCREMENT,
         `factory_id` int(11) DEFAULT NULL,
         `process_name` varchar(255) DEFAULT NULL,
         `process_code` varchar(255) DEFAULT NULL,
         `process_remarks` varchar(255) DEFAULT NULL,
         `creator` varchar(255) DEFAULT NULL,
         `create_time` datetime DEFAULT NULL,
         `updater` varchar(255) DEFAULT NULL,
         `update_time` datetime DEFAULT NULL,
         PRIMARY KEY (`process_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;






-- ----------------------------
-- Table structure for upd_record
-- ----------------------------
DROP TABLE IF EXISTS `upd_record`;
CREATE TABLE `upd_record` (
      `record_update_id` int(11) NOT NULL AUTO_INCREMENT,
      `device_id` int(11) DEFAULT NULL,
      `upload_id` int(11) DEFAULT NULL,
      `create_time` datetime DEFAULT NULL,
      `creator` varchar(255) DEFAULT NULL,
      `update_status` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`record_update_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for mon_device_history
-- ----------------------------
DROP TABLE IF EXISTS `mon_device_history`;
CREATE TABLE `mon_device_history` (
      `device_history_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '终端历史状态记录主键',
      `device_name` varchar(64) NOT NULL COMMENT '终端名称\n',
      `access_type` varchar(20) NOT NULL COMMENT '接入类型(plc或rfid)',
      `access_status` varchar(20) NOT NULL COMMENT '接入状态(正常异常)硬件',
      `device_software_status` varchar(20) NOT NULL COMMENT ' 运行状态（软件）',
      `antenna_status` varchar(20) DEFAULT NULL COMMENT ' 天线状态（plc可以可以为空，rfid必填）',
      `warning_content` varchar(128) NOT NULL COMMENT '预警内容',
      `cpu_rate` varchar(20) NOT NULL COMMENT 'cup使用率',
      `storage_rate` varchar(20) NOT NULL COMMENT '内存使用率',
      `error_rate` varchar(20) NOT NULL COMMENT '误读率',
      `occurrence_time` datetime NOT NULL COMMENT '发生时间',
      `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间（服务端时间）,不对外提供',
      PRIMARY KEY (`device_history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mon_device_real
-- ----------------------------
DROP TABLE IF EXISTS `mon_device_real`;
CREATE TABLE `mon_device_real` (
       `app_id` varchar(32) NOT NULL COMMENT 'appid',
       `device_exists` int(11) DEFAULT NULL COMMENT '终端存在情况（0表示不存在，1表示存在）',
       `access_type` varchar(20) DEFAULT NULL COMMENT '接入类型(plc或rfid)',
       `access_status` varchar(20) DEFAULT NULL COMMENT '接入状态(正常异常)硬件',
       `device_software_status` varchar(20) DEFAULT NULL COMMENT '运行状态（软件）',
       `antenna_status` varchar(20) DEFAULT NULL COMMENT '天线状态（plc可以可以为空，rfid必填）',
       `warning_content` varchar(20) DEFAULT NULL COMMENT '预警内容(字典)',
       `cpu_rate` varchar(20) DEFAULT NULL COMMENT 'cup使用率',
       `storage_rate` varchar(20) DEFAULT NULL COMMENT '内存使用率',
       `error_rate` varchar(20) DEFAULT NULL COMMENT '误读率',
       `occurrence_time` datetime DEFAULT NULL COMMENT '发生时间',
       `device_warning_num` int(11) DEFAULT NULL COMMENT '终端预警条数,不对外提供',
       PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for log_abn_log
-- ----------------------------
DROP TABLE IF EXISTS `log_abn_log`;
CREATE TABLE `log_abn_log`  (
    `abn_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '异常日志Id',
    `abn_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '异常日志编号',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `equipment_int` int(255) NULL DEFAULT NULL COMMENT '设备主键',
    `device_id` int(255) NULL DEFAULT NULL COMMENT '终端主键',
    `abn_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警标题',
    `abn_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警类型',
    `abn_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警等级',
    `abn_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警内容',
    `exchange_time` datetime NULL DEFAULT NULL COMMENT '交互时间',
    PRIMARY KEY (`abn_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;




    -- ----------------------------
-- Table structure for war_monitor_equipment
-- ----------------------------
DROP TABLE IF EXISTS `war_monitor_equipment`;
CREATE TABLE `war_monitor_equipment`  (
  `monitor_equipment_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '监控对象主键',
  `alarm_rule_int` int(9) NULL DEFAULT NULL COMMENT '预警规则主键',
  `equipment_int` int(9) NULL DEFAULT NULL COMMENT '监控对象主键（监控对象为设备，即为设备主键）',
  PRIMARY KEY (`monitor_equipment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `dev_config_file`;
CREATE TABLE `dev_config_file` (
    `file_id` int(11) NOT NULL AUTO_INCREMENT,
    `file_name` varchar(255) DEFAULT NULL,
    `file_path` varchar(255) DEFAULT NULL,
    `file_status` varchar(255) DEFAULT NULL,
    `creator` varchar(255) DEFAULT NULL,
    `terminal_time` varchar(255) DEFAULT NULL,
    `web_time` varchar(255) DEFAULT NULL,
    `app_id` varchar(255) DEFAULT NULL,
    `config_path` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


SET FOREIGN_KEY_CHECKS = 1;

    -- ----------------------------
-- Table structure for log_login_log
-- ----------------------------
DROP TABLE IF EXISTS `log_login_log`;
CREATE TABLE `log_login_log`  (
  `login_log_id` int(9) NOT NULL AUTO_INCREMENT,
  `equipment_int` int(9) NULL DEFAULT NULL,
  `device_id` int(9) NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_time` datetime NULL DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`login_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;


    -- ----------------------------
-- Table structure for log_plc_log
-- ----------------------------
DROP TABLE IF EXISTS `log_plc_log`;
CREATE TABLE `log_plc_log`  (
    `plc_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT 'PLC交换日志Id',
    `plc_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PLC交换日志编号',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
    `device_id` int(9) NULL DEFAULT NULL COMMENT '终端主键',
    `plc_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PLC组别名称',
    `group_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组别类型',
    `map_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '映射地址',
    `tag_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签类型',
    `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`plc_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;


    -- ----------------------------
-- Table structure for log_rfid_log
-- ----------------------------
DROP TABLE IF EXISTS `log_rfid_log`;
CREATE TABLE `log_rfid_log`  (
 `rfid_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT 'RFID交换日志Id',
 `rfid_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RFID交换日志编号',
 `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
 `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
 `device_id` int(9) NULL DEFAULT NULL COMMENT '终端主键',
 `rfid_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RFID-ID',
 `parameter_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数名称',
 `parameter_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
 `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
 PRIMARY KEY (`rfid_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

    -- ----------------------------
-- Table structure for log_mes_log
-- ----------------------------
DROP TABLE IF EXISTS `log_mes_log`;
CREATE TABLE `log_mes_log`  (
    `mes_log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT 'RFID交换日志Id',
    `mes_log_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RFID交换日志编号',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
    `device_id` int(255) NULL DEFAULT NULL COMMENT '终端主键',
    `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交互内容',
    `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`mes_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for eqi_work_station
-- ----------------------------
DROP TABLE IF EXISTS `eqi_work_station`;
CREATE TABLE `eqi_work_station`  (
    `work_station_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '工位主键',
    `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
    `work_station_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工位代码',
    PRIMARY KEY (`work_station_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file` (
   `file_id` int(8) NOT NULL,
   `file_name` varchar(255) DEFAULT NULL,
   `version` varchar(64) DEFAULT NULL,
   `download_path` varchar(255) DEFAULT NULL,
   `remark` varchar(255) DEFAULT NULL,
   `creator` varchar(32) DEFAULT NULL,
   `create_time` datetime DEFAULT NULL,
   PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for log_log
-- ----------------------------
DROP TABLE IF EXISTS `log_log`;
CREATE TABLE `log_log`  (
    `log_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
    `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
    `equipment_int` int(9) NULL DEFAULT NULL COMMENT '设备主键',
    `device_id` int(9) NULL DEFAULT NULL COMMENT '终端主键',
    `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源',
    `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户Id(登录日志：用户名称)',
    `login_time` datetime NULL DEFAULT NULL COMMENT '登录事件',
    `interface_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口类型',
    `json` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'json包',
    `result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果(接口日志：处理结果、操作日志：操作结果)',
    `dispose_start_time` datetime NULL DEFAULT NULL COMMENT '处理开始时间',
    `dispose_end_time` datetime NULL DEFAULT NULL COMMENT '处理结束时间',
    `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '使用者（接口日志：调用者、操作日志：操作人）',
    `dispose_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理时长',
    `interface_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口名称',
    `log_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志状态',
    `operation_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
    `operation_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
    `operation_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
    `equipment_exchange_time` datetime NULL DEFAULT NULL COMMENT '设备交互时间',
    `plc_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'plc组别名称',
    `group_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组别类型',
    `map_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '映射地址',
    `tag_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
    `rfid_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RFID-ID\r\nRFID-ID',
    `parameter_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数名称',
    `parameter_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
    `mes_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mes交互内容',
    `abn_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警标题',
    `abn_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警类型',
    `abn_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警等级',
    `abn_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警内容',
    `creator` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

