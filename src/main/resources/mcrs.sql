/*
Navicat MySQL Data Transfer

Source Server         : mysql5
Source Server Version : 50550
Source Host           : localhost:3305
Source Database       : mcrs

Target Server Type    : MYSQL
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
    `OPERATOR_ID` int(18) NOT NULL AUTO_INCREMENT,
    `TENANT_ID` varchar(64) DEFAULT NULL,
    `USER_ID` varchar(64) NOT NULL,
    `PASSWORD` varchar(100) DEFAULT NULL,
    `INVAL_DATE` date DEFAULT NULL,
    `USER_NAME` varchar(64) DEFAULT NULL,
    `AUTH_MODE` varchar(255) DEFAULT NULL,
    `STATUS` varchar(16) DEFAULT NULL,
    `UNLOCK_TIME` datetime NOT NULL,
    `MENU_TYPE` varchar(255) DEFAULT NULL,
    `LAST_LOGIN` datetime NOT NULL,
    `ERR_COUNT` int(10) DEFAULT NULL,
    `START_DATE` date DEFAULT NULL,
    `END_DATE` date DEFAULT NULL,
    `VALID_TIME` varchar(255) DEFAULT NULL,
    `MAC_CODE` varchar(128) DEFAULT NULL,
    `IP_ADDRESS` varchar(128) DEFAULT NULL,
    `EMAIL` varchar(255) DEFAULT NULL,
    `CREATEOR` varchar(64) DEFAULT NULL,
    `CREATE_TIME` datetime NOT NULL,
    PRIMARY KEY (`OPERATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cap_user
-- ----------------------------
INSERT INTO `cap_user` VALUES ('1', 'default', 'sysadmin', 'k2xvHUmCHWw=', '2028-06-10', '系统管理员', 'local', '1', '2013-03-16 11:58:31', 'default', '2013-03-16 11:58:31', null, null, null, null, null, null, null, 'sysadmin', '2013-03-16 11:58:31');


-- ----------------------------
-- Table structure for dev_rollback
-- ----------------------------
DROP TABLE IF EXISTS `dev_rollback`;
CREATE TABLE `dev_rollback` (
    `device_rollback_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
    `equipment_int` int(255) DEFAULT NULL COMMENT '设备主键',
    `device_id` int(255) DEFAULT NULL COMMENT '终端主键',
    `upload_id` int(255) DEFAULT NULL COMMENT '更新包主键',
    `upgrade_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
    `upgrade_status` varchar(255) DEFAULT NULL COMMENT '升级状态',
    `version_rollback_people` varchar(255) DEFAULT NULL COMMENT '版本更改人',
    `version_rollback_time` varchar(255) DEFAULT NULL COMMENT '版本更改时间',
    PRIMARY KEY (`device_rollback_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for dev_upgrade
-- ----------------------------
DROP TABLE IF EXISTS `dev_upgrade`;
CREATE TABLE `dev_upgrade` (
    `device_upgrade_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
    `equipment_int` int(255) DEFAULT NULL COMMENT '设备主键',
    `device_id` int(255) DEFAULT NULL COMMENT '终端主键',
    `upload_id` int(255) DEFAULT NULL COMMENT '更新包主键',
    `upgrade_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
    `upgrade_status` varchar(255) DEFAULT NULL COMMENT '升级状态',
    `version_updater` varchar(255) DEFAULT NULL COMMENT '版本更改人',
    `version_update_time` varchar(255) DEFAULT NULL COMMENT '版本更改时间',
    PRIMARY KEY (`device_upgrade_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
CREATE TABLE `eqi_device` (
    `device_id` int(255) NOT NULL AUTO_INCREMENT COMMENT '终端主键',
    `app_id` varchar(255) DEFAULT NULL COMMENT 'APPId',
    `version` varchar(255) DEFAULT NULL COMMENT '版本号',
    `need_update` varchar(255) DEFAULT '' COMMENT '是否需要更新',
    `device_software_type` varchar(255) DEFAULT NULL COMMENT '终端软件类型',
    `device_name` varchar(255) DEFAULT NULL COMMENT '终端名称',
    `assess_name` varchar(255) DEFAULT NULL COMMENT '接入点名称',
    `factory_name` varchar(255) DEFAULT NULL COMMENT '工厂名称',
    `assess_type` varchar(255) DEFAULT NULL COMMENT '接入点种类',
    `assess_ip` varchar(255) DEFAULT NULL COMMENT '接入点Ip',
    `equipment_id` varchar(255) DEFAULT NULL COMMENT '设备资源号',
    `assess_attributes` varchar(255) DEFAULT NULL COMMENT '接入点属性',
    `assess_install_location` varchar(255) DEFAULT NULL COMMENT '接入点安装位置',
    `access_method` varchar(255) DEFAULT NULL COMMENT '接入方式',
    `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
    `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time` varchar(255) DEFAULT NULL COMMENT '创建时间',
    `enable` varchar(255) DEFAULT NULL COMMENT '是否启用',
    `create_role` varchar(255) DEFAULT NULL COMMENT '创建角色',
    `updater` varchar(255) DEFAULT NULL COMMENT '修改角色',
    `update_time` varchar(255) DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for eqi_equipment
-- ----------------------------
DROP TABLE IF EXISTS `eqi_equipment`;
CREATE TABLE `eqi_equipment` (
    `equipment_int` int(255) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) DEFAULT NULL,
    `equipment_name` varchar(255) DEFAULT NULL,
    `enabled_state` varchar(255) DEFAULT NULL,
    `equipment_properties` varchar(255) DEFAULT NULL,
    `mes_continue_ip` varchar(255) DEFAULT NULL,
    `equipment_install_location` varchar(255) DEFAULT NULL,
    `equipment_continue_port` varchar(255) DEFAULT NULL,
    `create_time` varchar(255) DEFAULT NULL,
    `remarks` varchar(255) DEFAULT NULL,
    `creator` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`equipment_int`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for rep_abn_prod_prcs
-- ----------------------------
DROP TABLE IF EXISTS `rep_abn_prod_prcs`;
CREATE TABLE `rep_abn_prod_prcs` (
    `abn_PP_id` int(11) NOT NULL AUTO_INCREMENT,
    `site_id` varchar(255) NOT NULL,
    `roll_id` varchar(255) NOT NULL,
    `equipment_id` varchar(255) NOT NULL,
    `axis_name` varchar(255) NOT NULL,
    `vehicle_code` varchar(255) NOT NULL,
    `prod_SFC_id` varchar(255) NOT NULL,
    `end_EA_number` int(11) NOT NULL,
    `perform_step` varchar(255) NOT NULL,
    `is_end` varchar(255) NOT NULL,
    `create_time` datetime NOT NULL,
    `update_time` datetime NOT NULL,
    PRIMARY KEY (`abn_PP_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_blanking
-- ----------------------------
DROP TABLE IF EXISTS `rep_blanking`;
CREATE TABLE `rep_blanking` (
    `blanking_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) NOT NULL,
    `axis_name` varchar(255) NOT NULL,
    `antenna_loc` varchar(255) NOT NULL,
    `vehicle_code` varchar(255) NOT NULL,
    `prod_SFC_id` varchar(255) NOT NULL,
    `end_EA_number` int(11) NOT NULL,
    `in_rice_number` int(11) NOT NULL,
    `is_end` varchar(255) NOT NULL,
    `create_time` datetime NOT NULL,
    `start_prod_time` datetime NOT NULL,
    `end_prod_time` datetime NOT NULL,
    PRIMARY KEY (`blanking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_feeding
-- ----------------------------
DROP TABLE IF EXISTS `rep_feeding`;
CREATE TABLE `rep_feeding` (
    `feeding_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) NOT NULL,
    `axis_name` varchar(255) NOT NULL,
    `in_SFC_id` varchar(255) NOT NULL,
    `vehicle_code` varchar(255) NOT NULL,
    `prod_SFC_id` varchar(255) NOT NULL,
    `prod_number` int(11) NOT NULL,
    `create_time` datetime NOT NULL,
    `start_prod_time` datetime NOT NULL,
    `end_prod_time` datetime NOT NULL,
    PRIMARY KEY (`feeding_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_rfid
-- ----------------------------
DROP TABLE IF EXISTS `rep_rfid`;
CREATE TABLE `rep_rfid` (
    `rfid_read_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) NOT NULL,
    `RFID_id` varchar(255) NOT NULL,
    `antenna_id` varchar(255) NOT NULL,
    `read_rate` int(11) NOT NULL,
    `record_time` datetime NOT NULL,
    PRIMARY KEY (`rfid_read_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for war_alarm_event
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_event`;
CREATE TABLE `war_alarm_event`  (
    `alarm_event_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '预警事件编码',
    `alarm_event_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警事件标题',
    `enable_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用',
    `alarm_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警级别',
    `upper_limit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上限',
    `lower_limit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下限',
    `alarm_event_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预警信息内容',
    `alarm_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警类型',
    `make_form_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单人',
    `make_form_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '制单时间',
    `update_people` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `update_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`alarm_event_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for war_alarm_rule
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_rule`;
CREATE TABLE `war_alarm_rule` (
    `alarm_rule_id` int(10) NOT NULL COMMENT '预警规则编码',
    `alarm_rule_title` varchar(255) DEFAULT NULL COMMENT '预警规则标题',
    `enable` varchar(255) DEFAULT NULL COMMENT '是否启用',
    `monitor_level` varchar(255) DEFAULT NULL COMMENT '监控层级',
    `alarm_event_id` int(255) DEFAULT NULL COMMENT '预警事件编码',
    `monitor_object` varchar(255) DEFAULT NULL COMMENT '监控对象',
    `alarm_rule_describe` varchar(255) DEFAULT NULL COMMENT '预警规则描述',
    `rule_make_form_people` varchar(255) DEFAULT NULL COMMENT '制单人',
    `rule_make_form_time` varchar(255) DEFAULT NULL COMMENT '制单时间',
    `rule_update_people` varchar(255) DEFAULT NULL COMMENT '修改人',
    `rule_update_time` varchar(255) DEFAULT NULL COMMENT 'ruleUpdateTime',
    PRIMARY KEY (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for mon_access_status
-- ----------------------------
DROP TABLE IF EXISTS `mon_access_status`;
CREATE TABLE `mon_access_status` (
     `access_id` int(11) NOT NULL AUTO_INCREMENT,
     `equipment_id` varchar(255) NOT NULL,
     `APPId` varchar(255) NOT NULL,
     `access_type` varchar(255) NOT NULL,
     `access_status` varchar(255) NOT NULL,
     `antenna_status` varchar(255) DEFAULT NULL,
     `device_so_type` varchar(255) NOT NULL,
     `device_so_runtime` varchar(255) NOT NULL,
     `cpu_rate` varchar(255) NOT NULL,
     `storage_rate` varchar(255) NOT NULL,
     `occur_time` datetime NOT NULL,
     `error_rate` varchar(255) NOT NULL,
     `warning_title` varchar(255) NOT NULL,
     `warning_type` varchar(255) NOT NULL,
     `warning_level` varchar(255) NOT NULL,
     `warning_content` varchar(255) NOT NULL,
     `remarks` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`access_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;