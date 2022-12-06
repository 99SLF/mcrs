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
