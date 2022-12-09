/*
Navicat MySQL Data Transfer

Source Server         : mysql5
Source Server Version : 50550
Source Host           : localhost:3305
Source Database       : mcrs

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2022-12-06 15:59:40
*/
-- ----------------------------
-- Table structure for app_application
-- ----------------------------
DROP TABLE IF EXISTS `app_application`;
CREATE TABLE `app_application` (
    `app_id` int(9) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
    `func_group_id` int(9) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_func_resource
-- ----------------------------
DROP TABLE IF EXISTS `app_func_resource`;
CREATE TABLE `app_func_resource` (
    `res_id` int(9) NOT NULL,
    `func_code` varchar(64) DEFAULT NULL,
    `res_type` varchar(64) DEFAULT NULL,
    `res_path` varchar(256) DEFAULT NULL,
    `com_pack_name` varchar(64) DEFAULT NULL,
    `res_name` varchar(64) DEFAULT NULL,
    `app_info` varchar(64) DEFAULT NULL,
    `tenant_id` varchar(64) NOT NULL,
    PRIMARY KEY (`res_id`)
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
    `TENANT_ID` varchar(64) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for app_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu` (
    `menu_id` varchar(40) NOT NULL,
    `parent_menu_id` varchar(40) DEFAULT NULL,
    `menu_name` varchar(40) DEFAULT NULL,
    `menu_label` varchar(40) DEFAULT NULL,
    `menu_code` varchar(40) DEFAULT NULL,
    `is_leaf` varchar(1) DEFAULT NULL,
    `menu_action` varchar(64) DEFAULT NULL,
    `parameter` varchar(256) DEFAULT NULL,
    `menu_level` int(6) DEFAULT NULL,
    `display_order` int(6) DEFAULT NULL,
    `image_path` varchar(100) DEFAULT NULL,
    `expand_path` varchar(100) DEFAULT NULL,
    `menu_seq` varchar(256) DEFAULT NULL,
    `open_mode` varchar(255) DEFAULT NULL,
    `sub_count` int(10) DEFAULT NULL,
    `app_id` int(10) DEFAULT NULL,
    `func_code` varchar(255) DEFAULT NULL,
    `app_info` varchar(64) DEFAULT NULL,
    `tenant_id` varchar(64) DEFAULT NULL,
    PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cap_user
-- ----------------------------
DROP TABLE IF EXISTS `cap_user`;
CREATE TABLE `cap_user` (
    `operator_id` int(18) NOT NULL AUTO_INCREMENT,
    `tenant_id` varchar(64) NOT NULL,
    `user_id` varchar(64) NOT NULL,
    `password` varchar(100) DEFAULT NULL,
    `inval_date` date DEFAULT NULL,
    `user_name` varchar(64) DEFAULT NULL,
    `auth_mode` varchar(255) DEFAULT NULL,
    `status` varchar(16) DEFAULT NULL,
    `unlock_time` date NOT NULL,
    `menu_type` varchar(255) DEFAULT NULL,
    `last_login` date NOT NULL,
    `err_count` int(10) DEFAULT NULL,
    `start_date` date DEFAULT NULL,
    `end_date` date DEFAULT NULL,
    `valid_time` varchar(255) DEFAULT NULL,
    `mac_code` varchar(128) DEFAULT NULL,
    `ip_address` varchar(128) DEFAULT NULL,
    `email` varchar(255) DEFAULT NULL,
    `creator` varchar(64) DEFAULT NULL,
    `create_time` date NOT NULL,
    PRIMARY KEY (`operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dict_entry
-- ----------------------------
DROP TABLE IF EXISTS `dict_entry`;
CREATE TABLE `dict_entry` (
      `dict_Id` varchar(128) NOT NULL,
      `dict_type_Id` varchar(128) NOT NULL,
      `dict_name` varchar(255) DEFAULT NULL,
      `status` int(11) DEFAULT NULL,
      `sort_no` int(11) DEFAULT NULL,
      `rank` int(11) DEFAULT NULL,
      `parent_id` varchar(255) DEFAULT NULL,
      `seq_no` varchar(255) DEFAULT NULL,
      `filter1` varchar(255) DEFAULT NULL,
      `filter2` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`dict_Id`,`dict_type_Id`),
      KEY `DictEntry_DictType` (`dict_type_Id`),
      CONSTRAINT `DictEntry_DictType` FOREIGN KEY (`dict_type_Id`) REFERENCES `dict_type` (`dict_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type` (
     `dict_type_id` varchar(128) NOT NULL,
     `dict_type_name` varchar(255) DEFAULT NULL,
     `rank` int(11) DEFAULT NULL,
     `parent_id` varchar(255) DEFAULT NULL,
     `seq_no` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`dict_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_abn_prod_prcs
-- ----------------------------
DROP TABLE IF EXISTS `rep_abn_prod_prcs`;
CREATE TABLE `rep_abn_prod_prcs` (
     `abn_PP_id` int(11) NOT NULL AUTO_INCREMENT,
     `site_id` varchar(255) DEFAULT NULL,
     `roll_id` varchar(255) DEFAULT NULL,
     `equipment_id` varchar(255) DEFAULT NULL,
     `axis_name` varchar(255) DEFAULT NULL,
     `vehicle_code` varchar(255) DEFAULT NULL,
     `prod_SFC_id` varchar(255) DEFAULT NULL,
     `end_EA_number` int(11) DEFAULT NULL,
     `perform_step` varchar(255) DEFAULT NULL,
     `is_end` varchar(255) DEFAULT NULL,
     `start_prod_time` date DEFAULT NULL,
     `end_prod_time` date DEFAULT NULL,
     PRIMARY KEY (`abn_PP_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_blanking
-- ----------------------------
DROP TABLE IF EXISTS `rep_blanking`;
CREATE TABLE `rep_blanking` (
    `blanking_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) DEFAULT NULL,
    `axis_name` varchar(255) DEFAULT NULL,
    `antenna_loc` varchar(255) DEFAULT NULL,
    `vehicle_code` varchar(255) DEFAULT NULL,
    `prod_SFC_id` varchar(255) DEFAULT NULL,
    `end_EA_number` int(11) DEFAULT NULL,
    `in_rice_number` int(11) DEFAULT NULL,
    `is_end` varchar(255) DEFAULT NULL,
    `start_prod_time` date DEFAULT NULL,
    `end_prod_time` date DEFAULT NULL,
    PRIMARY KEY (`blanking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_feeding
-- ----------------------------
DROP TABLE IF EXISTS `rep_feeding`;
CREATE TABLE `rep_feeding` (
   `feeding_id` int(11) NOT NULL AUTO_INCREMENT,
   `equipment_id` varchar(255) DEFAULT NULL,
   `axis_name` varchar(255) DEFAULT NULL,
   `in_SFC_id` varchar(255) DEFAULT NULL,
   `vehicle_code` varchar(255) DEFAULT NULL,
   `prod_SFC_id` varchar(255) DEFAULT NULL,
   `prod_number` int(11) DEFAULT NULL,
   `create_time` date DEFAULT NULL,
   `start_prod_time` date DEFAULT NULL,
   `end_prod_time` date DEFAULT NULL,
   PRIMARY KEY (`feeding_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_rfid
-- ----------------------------
DROP TABLE IF EXISTS `rep_rfid`;
CREATE TABLE `rep_rfid` (
    `rfid_read_id` int(11) NOT NULL AUTO_INCREMENT,
    `equipment_id` varchar(255) DEFAULT NULL,
    `RFID_id` varchar(255) DEFAULT NULL,
    `antenna_id` varchar(255) DEFAULT NULL,
    `read_rate` varchar(255) DEFAULT NULL,
    `record_time` date DEFAULT NULL,
    PRIMARY KEY (`rfid_read_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for cap_equipment
-- ----------------------------

drop table if exists cap_equipment;

create table cap_equipment (
    equipmentId varchar(255) not null,
    equipmentName varchar(255) not null,
    enabledState varchar(255) not null,
    equipmentType varchar(255) not null,
    useProcess varchar(255) not null,
    equipmentProperties varchar(255) not null,
    equipmentIp varchar(255) not null,
    equipmentInstallLocation varchar(255) not null,
    createTime date not null,
    creator varchar(255) not null,
    primary key (equipmentId)
);ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cap_device
-- ----------------------------
DROP TABLE IF EXISTS `cap_device`;
CREATE TABLE `cap_device`  (
    `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `equipment_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `device_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `assess_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `assess_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `assess_resource_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `assess_attributes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `assess_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `assessInstall_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `device_software_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `use_process` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `registrant` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `register_role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `registration_date` date NOT NULL,
    `enable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `device_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

