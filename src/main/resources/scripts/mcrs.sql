/*
Navicat MySQL Data Transfer

Source Server         : mysql5
Source Server Version : 50550
Source Host           : localhost:3305
Source Database       : mcrs

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001
所有表结构
Date: 2023-03-07 15:50:04
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_application
-- ----------------------------
DROP TABLE IF EXISTS `app_application`;
CREATE TABLE `app_application`
(
    `app_id`        int(9)      NOT NULL AUTO_INCREMENT COMMENT '应用编号',
    `app_code`      varchar(32)  DEFAULT NULL COMMENT '应用代码',
    `app_name`      varchar(50)  DEFAULT NULL COMMENT '应用名称',
    `app_type`      varchar(32)  DEFAULT NULL COMMENT '应用类型',
    `display_order` int(6)       DEFAULT NULL COMMENT '显示顺序',
    `is_open`       char(1)      DEFAULT NULL COMMENT '是否开通',
    `open_date`     date         DEFAULT NULL COMMENT '开通日期',
    `protocol_type` varchar(64)  DEFAULT NULL COMMENT '协议类型',
    `ip_addr`       varchar(50)  DEFAULT NULL COMMENT '应用IP地址',
    `ip_port`       varchar(10)  DEFAULT NULL COMMENT '应用端口',
    `url`           varchar(256) DEFAULT NULL COMMENT '应用上下文',
    `app_desc`      varchar(512) DEFAULT NULL COMMENT '应用描述',
    `app_info`      varchar(64)  DEFAULT NULL COMMENT '应用信息',
    `tenant_id`     varchar(64) NOT NULL COMMENT '租户信息',
    PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for app_func_group
-- ----------------------------
DROP TABLE IF EXISTS `app_func_group`;
CREATE TABLE `app_func_group`
(
    `func_group_id`        int(9)      NOT NULL AUTO_INCREMENT COMMENT '功能组编号',
    `app_id`               int(9)      NOT NULL COMMENT '应用编号',
    `func_group_name`      varchar(40)  DEFAULT NULL COMMENT '功能组名称',
    `parent_func_group_id` int(9)       DEFAULT NULL COMMENT '父功能组编号',
    `group_level`          int(9)       DEFAULT NULL COMMENT '功能组层次',
    `func_group_seq`       varchar(256) DEFAULT NULL COMMENT '功能组序号',
    `display_order`        int(6)       DEFAULT NULL COMMENT '显示顺序',
    `is_leaf`              char(1)      DEFAULT NULL COMMENT '是否为叶子',
    `sub_count`            int(9)       DEFAULT NULL COMMENT '子节点数',
    `app_info`             varchar(64)  DEFAULT NULL COMMENT '应用信息',
    `tenant_id`            varchar(64) NOT NULL COMMENT '租户信息',
    PRIMARY KEY (`func_group_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 925
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for app_func_resource
-- ----------------------------
DROP TABLE IF EXISTS `app_func_resource`;
CREATE TABLE `app_func_resource`
(
    `res_id`        int(9)      NOT NULL AUTO_INCREMENT COMMENT '资源编号',
    `func_code`     varchar(64)  DEFAULT NULL COMMENT '功能编码',
    `res_type`      varchar(64)  DEFAULT NULL COMMENT '资源类型',
    `res_path`      varchar(256) DEFAULT NULL COMMENT '资源路径',
    `com_pack_name` varchar(64)  DEFAULT NULL COMMENT '所属构建包',
    `res_name`      varchar(64)  DEFAULT NULL COMMENT '资源名称',
    `app_info`      varchar(64)  DEFAULT NULL COMMENT '应用信息',
    `tenant_id`     varchar(64) NOT NULL COMMENT '租户信息',
    PRIMARY KEY (`res_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for app_function
-- ----------------------------
DROP TABLE IF EXISTS `app_function`;
CREATE TABLE `app_function`
(
    `func_code`     varchar(64)  NOT NULL COMMENT '功能编码',
    `func_name`     varchar(128) NOT NULL COMMENT '功能名称',
    `func_desc`     varchar(512) DEFAULT NULL COMMENT '功能描述',
    `func_action`   varchar(256) DEFAULT NULL COMMENT '功能URL',
    `para_info`     varchar(256) DEFAULT NULL COMMENT '功能参数信息',
    `is_check`      char(1)      DEFAULT NULL COMMENT '是否验证权限',
    `func_type`     varchar(32)  DEFAULT '1' COMMENT '功能类型',
    `display_order` int(6)       DEFAULT NULL COMMENT '显示顺序',
    `is_menu`       char(1)      DEFAULT NULL COMMENT '是否定义为菜单',
    `app_info`      varchar(64)  DEFAULT NULL COMMENT '应用信息',
    `tenant_id`     varchar(64)  NOT NULL COMMENT '租户信息',
    `func_group_id` int(9)       DEFAULT NULL,
    PRIMARY KEY (`func_code`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for app_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu`
(
    `MENU_ID`        int(9)      NOT NULL COMMENT '菜单编号',
    `PARENT_MENU_ID` varchar(40)    DEFAULT NULL COMMENT '父菜单编号',
    `MENU_NAME`      varchar(40) NOT NULL COMMENT '菜单名称',
    `MENU_LABEL`     varchar(40) NOT NULL COMMENT '菜单显示名称',
    `MENU_CODE`      varchar(40)    DEFAULT NULL COMMENT '菜单代码',
    `IS_LEAF`        varchar(1)     DEFAULT NULL COMMENT '是否为叶子菜单',
    `PARAMETER`      varchar(256)   DEFAULT NULL COMMENT '菜单参数',
    `MENU_LEVEL`     smallint(6)    DEFAULT NULL COMMENT '菜单层次',
    `DISPLAY_ORDER`  smallint(6)    DEFAULT NULL COMMENT '显示顺序',
    `IMAGE_PATH`     varchar(100)   DEFAULT NULL COMMENT '菜单闭合图片路径',
    `EXPAND_PATH`    varchar(100)   DEFAULT NULL COMMENT '菜单展开图片路径',
    `MENU_SEQ`       varchar(256)   DEFAULT NULL COMMENT '菜单序号',
    `OPEN_MODE`      varchar(255)   DEFAULT NULL COMMENT '打开方式',
    `SUB_COUNT`      decimal(10, 0) DEFAULT NULL COMMENT '子菜单数',
    `APP_ID`         decimal(10, 0) DEFAULT NULL COMMENT '应用编号',
    `FUNC_CODE`      varchar(255)   DEFAULT NULL COMMENT '功能代码',
    `APP_INFO`       varchar(64)    DEFAULT NULL COMMENT '应用信息',
    `TENANT_ID`      varchar(64)    DEFAULT NULL COMMENT '租户信息',
    PRIMARY KEY (`MENU_ID`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for bas_log_delete_rule
-- ----------------------------
DROP TABLE IF EXISTS `bas_log_delete_rule`;
CREATE TABLE `bas_log_delete_rule`
(
    `rule_delete_id`    int(9) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
    `delete_rule_title` varchar(255) DEFAULT NULL COMMENT '删除规则标题',
    `enable`            varchar(255) DEFAULT NULL COMMENT '是否启用',
    `delete_rule_type`  varchar(255) DEFAULT NULL COMMENT '日志删除规则类型',
    `log_type`          varchar(255) DEFAULT NULL COMMENT '日志类型',
    `retention_time`    varchar(255) DEFAULT NULL COMMENT '保留时间数（天）',
    `updater`           varchar(255) DEFAULT NULL COMMENT '修改人',
    `update_time`       datetime     DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`rule_delete_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for base_access_info
-- ----------------------------
DROP TABLE IF EXISTS `base_access_info`;
CREATE TABLE `base_access_info`
(
    `acc_point_res_id`   int(11) NOT NULL AUTO_INCREMENT COMMENT '接入点资源',
    `process_id`         int(11)      DEFAULT NULL COMMENT '工序Id',
    `acc_point_res_code` varchar(255) DEFAULT NULL COMMENT '接入点资源编号',
    `acc_point_res_name` varchar(255) DEFAULT NULL COMMENT '接入点资源名字',
    `is_enable`          varchar(255) DEFAULT NULL COMMENT '是否启用',
    `creator`            varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`        datetime     DEFAULT NULL COMMENT '创建时间',
    `updater`            varchar(255) DEFAULT NULL COMMENT '更新人',
    `update_time`        datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`acc_point_res_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for base_coding_serialnumber
-- ----------------------------
DROP TABLE IF EXISTS `base_coding_serialnumber`;
CREATE TABLE `base_coding_serialnumber`
(
    `id`            int(18) NOT NULL AUTO_INCREMENT COMMENT '编码规则主键',
    `rule_name`     varchar(255) DEFAULT NULL COMMENT '编码规则名称',
    `digit`         int(18)      DEFAULT NULL COMMENT '位数',
    `startvalue`    int(18)      DEFAULT NULL COMMENT '起始值',
    `currentvalue`  int(18)      DEFAULT NULL COMMENT '当前值',
    `note`          varchar(255) DEFAULT NULL COMMENT '描述',
    `function_num`  varchar(255) DEFAULT NULL COMMENT '功能编码',
    `function_name` varchar(255) DEFAULT NULL COMMENT '功能名称',
    `number_rule`   varchar(255) DEFAULT NULL COMMENT '流水规则',
    `num_basis`     varchar(255) DEFAULT NULL COMMENT '递增依据',
    `title_rule`    varchar(255) DEFAULT NULL COMMENT '标题规则',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for base_cols_filter
-- ----------------------------
DROP TABLE IF EXISTS `base_cols_filter`;
CREATE TABLE `base_cols_filter`
(
    `FUN_NAME` varchar(64) NOT NULL COMMENT '功能名称',
    `FIELD`    varchar(64) NOT NULL COMMENT '字段名称',
    `USER_ID`  varchar(64) DEFAULT NULL COMMENT '用户ID',
    PRIMARY KEY (`FUN_NAME`, `FIELD`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for base_equip_info
-- ----------------------------
DROP TABLE IF EXISTS `base_equip_info`;
CREATE TABLE `base_equip_info`
(
    `equip_type_id`          int(11) NOT NULL AUTO_INCREMENT COMMENT '设备类型主键',
    `info_id`                int(11)      DEFAULT NULL COMMENT '树节点ID',
    `equip_type_code`        varchar(255) DEFAULT NULL COMMENT '设备类型编码',
    `equip_type_enable`      varchar(255) DEFAULT NULL COMMENT '是否启用',
    `manufacturer`           varchar(255) DEFAULT NULL COMMENT '厂家',
    `equip_type_name`        varchar(255) DEFAULT NULL COMMENT '设备类型名称',
    `equip_controller_model` varchar(255) DEFAULT NULL COMMENT '控制型号',
    `protocol_communication` varchar(255) DEFAULT NULL COMMENT '支持通信协议',
    `mes_ip_address`         varchar(255) DEFAULT NULL COMMENT '连接MES的IP地址',
    `remarks`                varchar(255) DEFAULT NULL COMMENT '备注',
    `creator`                varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`            datetime     DEFAULT NULL COMMENT '创建时间',
    `updater`                varchar(255) DEFAULT NULL COMMENT '更新人',
    `update_time`            datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`equip_type_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 18
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for base_factory_info
-- ----------------------------
DROP TABLE IF EXISTS `base_factory_info`;
CREATE TABLE `base_factory_info`
(
    `factory_id`      int(11) NOT NULL AUTO_INCREMENT COMMENT '工厂信息主键',
    `matrix_id`       int(11)      DEFAULT NULL COMMENT '基地主键',
    `factory_name`    varchar(255) DEFAULT NULL COMMENT '工厂名称',
    `factory_code`    varchar(255) DEFAULT NULL COMMENT '工厂代码',
    `factory_address` varchar(255) DEFAULT NULL COMMENT '工厂地址',
    `creator`         varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`     datetime     DEFAULT NULL COMMENT '创建时间',
    `updater`         varchar(255) DEFAULT NULL COMMENT '更新人',
    `update_time`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`factory_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for base_matrix_info
-- ----------------------------
DROP TABLE IF EXISTS `base_matrix_info`;
CREATE TABLE `base_matrix_info`
(
    `matrix_id`      int(11) NOT NULL AUTO_INCREMENT COMMENT '基地主键Id',
    `parent_id`      varchar(255) DEFAULT NULL COMMENT '上级基地Id',
    `matrix_name`    varchar(255) DEFAULT NULL COMMENT '基地名称',
    `matrix_code`    varchar(255) DEFAULT NULL COMMENT '基地代码',
    `matrix_address` varchar(255) DEFAULT NULL COMMENT '基地地址',
    `creator`        varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`    datetime     DEFAULT NULL COMMENT '创建时间',
    `updater`        varchar(255) DEFAULT NULL COMMENT '更新人',
    `update_time`    datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`matrix_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for base_process_info
-- ----------------------------
DROP TABLE IF EXISTS `base_process_info`;
CREATE TABLE `base_process_info`
(
    `process_id`      int(11) NOT NULL AUTO_INCREMENT COMMENT '工序主键Id',
    `factory_id`      int(11)      DEFAULT NULL COMMENT '工厂主键Id',
    `process_name`    varchar(255) DEFAULT NULL COMMENT '工序名字',
    `process_code`    varchar(255) DEFAULT NULL COMMENT '工序代码',
    `process_remarks` varchar(255) DEFAULT NULL COMMENT '工序备注',
    `creator`         varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`     datetime     DEFAULT NULL COMMENT '创建时间',
    `updater`         varchar(255) DEFAULT NULL COMMENT '更新人',
    `update_time`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`process_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for cap_party_auth
-- ----------------------------
DROP TABLE IF EXISTS `cap_party_auth`;
CREATE TABLE `cap_party_auth`
(
    `ROLE_TYPE`   varchar(64) NOT NULL COMMENT '角色类型',
    `PARTY_ID`    varchar(64) NOT NULL COMMENT '参与者编号',
    `PARTY_TYPE`  varchar(64) NOT NULL COMMENT '参与者类型',
    `ROLE_ID`     varchar(64) NOT NULL COMMENT '角色编号',
    `TENANT_ID`   varchar(64) DEFAULT NULL COMMENT '租户编号',
    `CREATE_USER` varchar(64) DEFAULT NULL COMMENT '创建用户',
    `CREATE_TIME` datetime    NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`ROLE_TYPE`, `PARTY_ID`, `PARTY_TYPE`, `ROLE_ID`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cap_res_auth
-- ----------------------------
DROP TABLE IF EXISTS `cap_res_auth`;
CREATE TABLE `cap_res_auth`
(
    `PARTY_ID`    varchar(64)  NOT NULL COMMENT '参与者编号',
    `PARTY_TYPE`  varchar(64)  NOT NULL COMMENT '参与者类型',
    `RES_ID`      varchar(255) NOT NULL COMMENT '资源编号',
    `RES_TYPE`    varchar(64)  NOT NULL COMMENT '资源类型',
    `TENANT_ID`   varchar(64) DEFAULT NULL COMMENT '租户编号',
    `RES_STATE`   varchar(512) NOT NULL COMMENT '资源状态',
    `PARTY_SCOPE` varchar(1)  DEFAULT '0' COMMENT '参与者范围',
    `CREATE_USER` varchar(64) DEFAULT NULL COMMENT '创建用户',
    `CREATE_TIME` datetime    DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`PARTY_ID`, `PARTY_TYPE`, `RES_ID`, `RES_TYPE`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cap_role
-- ----------------------------
DROP TABLE IF EXISTS `cap_role`;
CREATE TABLE `cap_role`
(
    `role_id`     int(9) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
    `role_code`   varchar(32)  DEFAULT NULL COMMENT '角色代码',
    `role_name`   varchar(255) DEFAULT NULL COMMENT '角色名',
    `role_desc`   varchar(255) DEFAULT NULL COMMENT '角色描述',
    `creator`     varchar(255) DEFAULT NULL COMMENT '创建者',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cap_user
-- ----------------------------
DROP TABLE IF EXISTS `cap_user`;
CREATE TABLE `cap_user`
(
    `OPERATOR_ID`      int(9)      NOT NULL AUTO_INCREMENT,
    `TENANT_ID`        varchar(64)    DEFAULT NULL COMMENT '租户编号',
    `USER_ID`          varchar(64) NOT NULL COMMENT '登录用户名',
    `PASSWORD`         varchar(100)   DEFAULT NULL COMMENT '密码',
    `INVAL_DATE`       date           DEFAULT NULL COMMENT '密码失效日期',
    `USER_NAME`        varchar(64)    DEFAULT NULL COMMENT '用户名称',
    `AUTH_MODE`        varchar(255)   DEFAULT NULL COMMENT '本地密码认证',
    `STATUS`           varchar(16)    DEFAULT NULL COMMENT '状态',
    `UNLOCK_TIME`      datetime       DEFAULT NULL COMMENT '解锁的时间',
    `MENU_TYPE`        varchar(255)   DEFAULT NULL COMMENT '菜单风格',
    `LAST_LOGIN`       datetime       DEFAULT NULL COMMENT '最后登录时间',
    `ERR_COUNT`        decimal(10, 0) DEFAULT NULL COMMENT '密码错误次数',
    `START_DATE`       date           DEFAULT NULL COMMENT '有效开始时间',
    `END_DATE`         date           DEFAULT NULL COMMENT '有效截止时间',
    `VALID_TIME`       varchar(255)   DEFAULT NULL COMMENT '有效时间范围',
    `MAC_CODE`         varchar(128)   DEFAULT NULL COMMENT '设置MAC',
    `IP_ADDRESS`       varchar(128)   DEFAULT NULL COMMENT '设置IP地址',
    `EMAIL`            varchar(255)   DEFAULT NULL COMMENT '邮箱地址',
    `CREATOR`          varchar(64)    DEFAULT NULL COMMENT '创建人',
    `CREATE_TIME`      datetime    NOT NULL COMMENT '创建时间',
    `USER_TYPE`        varchar(64)    DEFAULT NULL COMMENT '用户类型',
    `USER_PHONE`       varchar(255)   DEFAULT NULL COMMENT '用户电话号码',
    `USER_DESCRIPTION` varchar(255)   DEFAULT NULL COMMENT '用户描述',
    `UPDATER`          varchar(64)    DEFAULT NULL COMMENT '更新人',
    `UPDATE_TIME`      datetime       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`OPERATOR_ID`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dev_config_file
-- ----------------------------
DROP TABLE IF EXISTS `dev_config_file`;
CREATE TABLE `dev_config_file`
(
    `file_id`       int(11) NOT NULL AUTO_INCREMENT COMMENT '配置文件主键',
    `file_name`     varchar(255) DEFAULT NULL COMMENT '文件名称',
    `file_path`     varchar(255) DEFAULT NULL COMMENT '获取文件路径（客户端文件保存路径）',
    `file_status`   varchar(255) DEFAULT NULL COMMENT '配置文件状态',
    `creator`       varchar(255) DEFAULT NULL COMMENT '创建人',
    `terminal_time` varchar(255) DEFAULT NULL COMMENT '终端修改时间',
    `web_time`      varchar(255) DEFAULT NULL COMMENT 'web端修改时间',
    `app_id`        varchar(255) DEFAULT NULL COMMENT 'AppId',
    `config_path`   varchar(255) DEFAULT NULL COMMENT '服务器配置文件保存路径',
    PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dev_rollback
-- ----------------------------
DROP TABLE IF EXISTS `dev_rollback`;
CREATE TABLE `dev_rollback`
(
    `device_rollback_id`      int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
    `equipment_int`           int(255)     DEFAULT NULL COMMENT '设备主键',
    `device_id`               int(255)     DEFAULT NULL COMMENT '终端主键',
    `upload_id`               int(255)     DEFAULT NULL COMMENT '更新包主键',
    `rollback_before_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
    `upgrade_status`          varchar(255) DEFAULT NULL COMMENT '升级状态',
    `version_rollback_people` varchar(255) DEFAULT NULL COMMENT '版本更改人',
    `version_rollback_time`   varchar(255) DEFAULT NULL COMMENT '版本更改时间',
    PRIMARY KEY (`device_rollback_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dev_upgrade
-- ----------------------------
DROP TABLE IF EXISTS `dev_upgrade`;
CREATE TABLE `dev_upgrade`
(
    `device_upgrade_id`      int(10) NOT NULL AUTO_INCREMENT COMMENT '终端升级主键',
    `equipment_int`          int(255)     DEFAULT NULL COMMENT '设备主键',
    `device_id`              int(255)     DEFAULT NULL COMMENT '终端主键',
    `upload_id`              int(255)     DEFAULT NULL COMMENT '更新包主键',
    `upgrade_before_version` varchar(255) DEFAULT NULL COMMENT '升级版本号',
    `upgrade_status`         varchar(255) DEFAULT NULL COMMENT '升级状态',
    `version_updater`        varchar(255) DEFAULT NULL COMMENT '版本更改人',
    `version_update_time`    varchar(255) DEFAULT NULL COMMENT '版本更改时间',
    PRIMARY KEY (`device_upgrade_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dict_entry
-- ----------------------------
DROP TABLE IF EXISTS `dict_entry`;
CREATE TABLE `dict_entry`
(
    `DICTTYPEID` varchar(128) NOT NULL COMMENT '字典类型编号',
    `DICTID`     varchar(128) NOT NULL COMMENT '字典编号',
    `DICTNAME`   varchar(255) DEFAULT NULL COMMENT '字典名称',
    `STATUS`     int(11)      DEFAULT NULL COMMENT '状态',
    `SORTNO`     int(11)      DEFAULT NULL COMMENT '排序',
    `RANK`       int(11)      DEFAULT NULL COMMENT 'rank',
    `PARENTID`   varchar(255) DEFAULT NULL COMMENT '父级编号',
    `SEQNO`      varchar(255) DEFAULT NULL COMMENT '序号',
    `FILTER1`    varchar(255) DEFAULT NULL COMMENT '字段1',
    `FILTER2`    varchar(255) DEFAULT NULL COMMENT '字段2',
    PRIMARY KEY (`DICTTYPEID`, `DICTID`) USING BTREE,
    KEY `ZIMAX_DICT_ENTRYINDEX` (`DICTTYPEID`, `DICTID`, `SEQNO`) USING BTREE,
    CONSTRAINT `dict_entry_ibfk_1` FOREIGN KEY (`DICTTYPEID`) REFERENCES `dict_type` (`DICTTYPEID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type`
(
    `DICTTYPEID`   varchar(128) NOT NULL COMMENT '字典类型编号',
    `DICTTYPENAME` varchar(255) DEFAULT NULL COMMENT '字典类型名称',
    `RANK`         int(11)      DEFAULT NULL COMMENT 'rank',
    `PARENTID`     varchar(255) DEFAULT NULL COMMENT '父字典名称主键',
    `SEQNO`        varchar(255) DEFAULT NULL COMMENT '序号',
    PRIMARY KEY (`DICTTYPEID`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for eqi_device
-- ----------------------------
DROP TABLE IF EXISTS `eqi_device`;
CREATE TABLE `eqi_device`
(
    `device_id`                  int(9) NOT NULL AUTO_INCREMENT COMMENT '终端主键',
    `app_id`                     varchar(255) DEFAULT NULL COMMENT 'APPId',
    `version`                    varchar(255) DEFAULT NULL COMMENT '版本号',
    `enable`                     varchar(255) DEFAULT NULL COMMENT '是否启用',
    `register_status`            varchar(255) DEFAULT NULL COMMENT '注册状态',
    `device_software_type`       varchar(255) DEFAULT NULL COMMENT '终端软件类型',
    `device_name`                varchar(255) DEFAULT NULL COMMENT '终端名称',
    `equipment_int`              int(9)       DEFAULT NULL COMMENT '设备主键',
    `access_method`              varchar(255) DEFAULT NULL COMMENT '接入方式',
    `remarks`                    varchar(255) DEFAULT NULL COMMENT '备注',
    `creator`                    varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`                datetime     DEFAULT NULL COMMENT '创建时间',
    `program_installation_path`  varchar(255) DEFAULT NULL COMMENT '终端更新包解压路径',
    `executor_installation_path` varchar(255) DEFAULT NULL COMMENT '终端执行程序安装路径',
    PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for eqi_equipment
-- ----------------------------
DROP TABLE IF EXISTS `eqi_equipment`;
CREATE TABLE `eqi_equipment`
(
    `equipment_int`              int(9) NOT NULL AUTO_INCREMENT COMMENT '设备主键',
    `equipment_id`               varchar(255) DEFAULT NULL COMMENT '设备资源号',
    `equipment_name`             varchar(255) DEFAULT NULL COMMENT '设备名称',
    `equipment_install_location` varchar(255) DEFAULT NULL COMMENT '设备安装位置',
    `equip_type_id`              int(9)       DEFAULT NULL COMMENT '设备信息主键',
    `equipment_continue_port`    varchar(255) DEFAULT NULL COMMENT '设备连接端口',
    `equipment_ip`               varchar(255) DEFAULT NULL COMMENT '设备连接IP',
    `acc_point_res_id`           int(9)       DEFAULT NULL COMMENT '接入点资源维护数据的主键',
    `enable`                     varchar(5)   DEFAULT NULL COMMENT '是否启用',
    `creator`                    varchar(255) DEFAULT NULL COMMENT '创建人',
    `create_time`                datetime     DEFAULT NULL COMMENT '创建时间',
    `remarks`                    varchar(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`equipment_int`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for eqi_work_station
-- ----------------------------
DROP TABLE IF EXISTS `eqi_work_station`;
CREATE TABLE `eqi_work_station`
(
    `work_station_id`  int(9) NOT NULL AUTO_INCREMENT COMMENT '工位主键',
    `equipment_int`    int(9)       DEFAULT NULL COMMENT '设备主键',
    `work_station_num` varchar(255) DEFAULT NULL COMMENT '工位代码',
    PRIMARY KEY (`work_station_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for log_log
-- ----------------------------
DROP TABLE IF EXISTS `log_log`;
CREATE TABLE `log_log`
(
    `log_id`                  int(9) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
    `log_type`                varchar(255) DEFAULT NULL COMMENT '日志类型',
    `equipment_int`           int(9)       DEFAULT NULL COMMENT '设备主键',
    `device_id`               int(9)       DEFAULT NULL COMMENT '终端主键',
    `source`                  varchar(255) DEFAULT NULL COMMENT '来源',
    `user_id`                 varchar(255) DEFAULT NULL COMMENT '用户Id(登录日志：用户名称)',
    `login_time`              datetime     DEFAULT NULL COMMENT '登录事件',
    `interface_type`          varchar(255) DEFAULT NULL COMMENT '接口类型',
    `json`                    varchar(255) DEFAULT NULL COMMENT 'json包',
    `result`                  varchar(255) DEFAULT NULL COMMENT '结果(接口日志：处理结果、操作日志：操作结果)',
    `dispose_start_time`      datetime     DEFAULT NULL COMMENT '处理开始时间',
    `dispose_end_time`        datetime     DEFAULT NULL COMMENT '处理结束时间',
    `user`                    varchar(255) DEFAULT NULL COMMENT '使用者（接口日志：调用者、操作日志：操作人）',
    `dispose_time`            varchar(255) DEFAULT NULL COMMENT '处理时长',
    `interface_name`          varchar(255) DEFAULT NULL COMMENT '接口名称',
    `log_status`              varchar(255) DEFAULT NULL COMMENT '日志状态',
    `operation_type`          varchar(255) DEFAULT NULL COMMENT '操作类型',
    `operation_content`       varchar(255) DEFAULT NULL COMMENT '操作内容',
    `operation_time`          datetime     DEFAULT NULL COMMENT '操作时间',
    `equipment_exchange_time` datetime     DEFAULT NULL COMMENT '设备交互时间',
    `plc_group_name`          varchar(255) DEFAULT NULL COMMENT 'plc组别名称',
    `group_type`              varchar(255) DEFAULT NULL COMMENT '组别类型',
    `map_address`             varchar(255) DEFAULT NULL COMMENT '映射地址',
    `tag_name`                varchar(255) DEFAULT NULL COMMENT '标签名称',
    `rfid_id`                 varchar(255) DEFAULT NULL COMMENT 'RFID-ID\r\nRFID-ID',
    `parameter_name`          varchar(255) DEFAULT NULL COMMENT '参数名称',
    `parameter_num`           varchar(255) DEFAULT NULL COMMENT '参数值',
    `mes_content`             varchar(255) DEFAULT NULL COMMENT 'mes交互内容',
    `abn_title`               varchar(255) DEFAULT NULL COMMENT '预警标题',
    `abn_type`                varchar(255) DEFAULT NULL COMMENT '预警类型',
    `abn_level`               varchar(255) DEFAULT NULL COMMENT '预警等级',
    `abn_content`             varchar(255) DEFAULT NULL COMMENT '预警内容',
    `creator`                 varchar(30)  DEFAULT NULL COMMENT '创建人',
    `create_time`             datetime     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mon_device_alarm
-- ----------------------------
DROP TABLE IF EXISTS `mon_device_alarm`;
CREATE TABLE `mon_device_alarm`
(
    `device_alarm_id`        int(11)     NOT NULL AUTO_INCREMENT COMMENT '预警记录表主键',
    `app_id`                 varchar(32) NOT NULL COMMENT 'AppId',
    `warning_content`        varchar(64) DEFAULT NULL COMMENT '告警内容',
    `access_status`          varchar(12) DEFAULT NULL COMMENT '接入状态',
    `device_software_status` varchar(12) DEFAULT NULL COMMENT '软件运行状态',
    `antennaStatus`          varchar(12) DEFAULT NULL COMMENT '天线状态',
    PRIMARY KEY (`device_alarm_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for mon_device_real
-- ----------------------------
DROP TABLE IF EXISTS `mon_device_real`;
CREATE TABLE `mon_device_real`
(
    `app_id`                 varchar(32) NOT NULL COMMENT 'appid',
    `access_type`            varchar(20) DEFAULT NULL COMMENT '接入类型(plc或rfid)',
    `access_status`          varchar(20) DEFAULT NULL COMMENT '接入状态(正常异常)硬件',
    `device_software_status` varchar(20) DEFAULT NULL COMMENT '运行状态（软件）',
    `antenna_status`         varchar(20) DEFAULT NULL COMMENT '天线状态（plc可以可以为空，rfid必填）',
    `warning_content`        varchar(20) DEFAULT NULL COMMENT '预警内容(字典)',
    `cpu_rate`               varchar(20) DEFAULT NULL COMMENT 'cup使用率',
    `storage_rate`           varchar(20) DEFAULT NULL COMMENT '内存使用率',
    `error_rate`             varchar(20) DEFAULT NULL COMMENT '误读率',
    `occurrence_time`        datetime    DEFAULT NULL COMMENT '发生时间',
    PRIMARY KEY (`app_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for rep_abn_prod_prcs
-- ----------------------------
DROP TABLE IF EXISTS `rep_abn_prod_prcs`;
CREATE TABLE `rep_abn_prod_prcs`
(
    `abn_PP_id`     int(11)      NOT NULL AUTO_INCREMENT,
    `site_id`       varchar(6)   NOT NULL,
    `roll_id`       varchar(6)   NOT NULL,
    `equipment_id`  varchar(64)  NOT NULL,
    `axis_name`     varchar(64)  NOT NULL,
    `vehicle_code`  varchar(64)  NOT NULL,
    `prod_SFC_id`   varchar(128) NOT NULL,
    `end_EA_number` varchar(38)  NOT NULL,
    `perform_step`  varchar(6)   NOT NULL,
    `is_end`        varchar(6)   NOT NULL,
    `create_time`   datetime     NOT NULL,
    `update_time`   datetime     NOT NULL,
    PRIMARY KEY (`abn_PP_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for rep_blanking
-- ----------------------------
DROP TABLE IF EXISTS `rep_blanking`;
CREATE TABLE `rep_blanking`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT '下料报表主键',
    `operation`        text COMMENT '工位',
    `resource`         text COMMENT '设备资源号',
    `axis`             text COMMENT '下料轴',
    `sfcpre`           text COMMENT '来料SFC号',
    `processLot`       text COMMENT '载具号',
    `sfc`              text COMMENT '下料绑定的SFC编码',
    `qty`              text COMMENT 'EA数',
    `metre`            text COMMENT '收卷米数',
    `diamRealityValue` tinytext COMMENT '上料卷径',
    `createdBy`        text COMMENT '创建人',
    `createdTime`      datetime DEFAULT NULL COMMENT '创建时间',
    `updatedBy`        text COMMENT 'updatedBy',
    `updatedTime`      datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for rep_coildiameterrecord
-- ----------------------------
DROP TABLE IF EXISTS `rep_coildiameterrecord`;
CREATE TABLE `rep_coildiameterrecord`
(
    `id`                int(11) NOT NULL AUTO_INCREMENT COMMENT '上下料卷径记录表主键',
    `resource`          text COMMENT '设备资源号',
    `sfcPreData`        text COMMENT '放卷SFC',
    `uDiamRealityValue` text COMMENT '放卷卷径',
    `rAxisName`         text COMMENT '收卷轴名称',
    `rProcessLotPre`    text COMMENT '收卷载具号',
    `sfcData`           text COMMENT '收卷SFC',
    `rDiamRealityValue` text COMMENT '收卷卷径',
    `isLastVolume`      int(11)  DEFAULT NULL COMMENT 'isLastVolume',
    `unwindIsOver`      int(11)  DEFAULT NULL COMMENT '放卷物料是否消耗完成',
    `remark`            text COMMENT '放卷异常信息记录',
    `updatedTime`       datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for rep_feeding
-- ----------------------------
DROP TABLE IF EXISTS `rep_feeding`;
CREATE TABLE `rep_feeding`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT '上料报表主键',
    `operation`        text COMMENT '工位',
    `resource`         text COMMENT '设备资源号',
    `actionType`       int(11)  DEFAULT NULL COMMENT '动作类型',
    `axis`             text COMMENT '上料轴',
    `sfcPre`           text COMMENT '来料SFC号',
    `processLotPre`    text COMMENT '载具号',
    `qty`              text COMMENT '上料数量',
    `sfc`              text COMMENT '校验MES返回的新SFC号',
    `isFinish`         int(1)   DEFAULT NULL COMMENT '放卷是否全部完工',
    `diamRealityValue` tinytext COMMENT '上料卷径',
    `downInfo`         tinytext COMMENT '卸滚筒信息',
    `revision`         tinytext COMMENT '乐观锁',
    `createdBy`        tinytext COMMENT '创建人',
    `createdTime`      datetime DEFAULT NULL COMMENT '创建时间',
    `updatedBy`        text COMMENT '更新人',
    `updatedTime`      datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for rep_rfid
-- ----------------------------
DROP TABLE IF EXISTS `rep_rfid`;
CREATE TABLE `rep_rfid`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT 'rfid读取率报表主键',
    `epcid`       text COMMENT '载具号',
    `readNum`     int(11)  DEFAULT NULL COMMENT '读取次数',
    `reader`      text COMMENT 'RFID读写器',
    `antenna`     text COMMENT 'RFID天线',
    `dBm`         text COMMENT '天线增益',
    `rssi`        text COMMENT 'RSSI',
    `updatedTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for rep_verifyunusual
-- ----------------------------
DROP TABLE IF EXISTS `rep_verifyunusual`;
CREATE TABLE `rep_verifyunusual`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT '防串读报表主键',
    `resource`    text COMMENT '设备资源号',
    `axisName`    text COMMENT '轴名称',
    `rfidReader`  text COMMENT '读写器ID',
    `antenna`     int(11)  DEFAULT NULL COMMENT '天线',
    `processLot`  text COMMENT '已读取标签值',
    `tag`         text COMMENT '替换的标签值',
    `readNum`     int(11)  DEFAULT NULL COMMENT '读取到的次数',
    `sfcPre`      text COMMENT '生产SFC',
    `sfc`         text COMMENT '拆分后SFC',
    `updatedTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file`
(
    `file_id`       int(8) NOT NULL COMMENT '系统文件主键',
    `file_name`     varchar(255) DEFAULT NULL COMMENT '文件名称',
    `version`       varchar(64)  DEFAULT NULL COMMENT '版本',
    `download_path` varchar(255) DEFAULT NULL COMMENT '文件存放路径',
    `remark`        varchar(255) DEFAULT NULL COMMENT '备注',
    `creator`       varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time`   datetime     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for upd_upload
-- ----------------------------
DROP TABLE IF EXISTS `upd_upload`;
CREATE TABLE `upd_upload`
(
    `upload_id`           int(11) NOT NULL AUTO_INCREMENT COMMENT '更新包主键',
    `upload_number`       varchar(255) DEFAULT NULL COMMENT '更新包单号',
    `version`             varchar(255) DEFAULT NULL COMMENT '版本号',
    `device_so_type`      varchar(255) DEFAULT NULL COMMENT '终端软件类型',
    `upload_strategy`     varchar(255) DEFAULT NULL COMMENT '更新策略',
    `file_name`           varchar(255) DEFAULT NULL COMMENT '更新包文件名',
    `uploader`            varchar(255) DEFAULT NULL COMMENT '制单人（上传人）',
    `version_upload_time` datetime     DEFAULT NULL COMMENT '更新包上传时间',
    `remarks`             varchar(255) DEFAULT NULL COMMENT '备注',
    `major_version`       varchar(255) DEFAULT NULL COMMENT '否为主版本号',
    `download_url`        varchar(255) DEFAULT NULL COMMENT '存放路径',
    `upload_uu_id`        varchar(255) DEFAULT NULL COMMENT '资源文件生成的uuid',
    `upload_file_size`    double       DEFAULT NULL COMMENT '文件大小',
    `upload_file_type`    varchar(255) DEFAULT NULL COMMENT '文件类型',
    `uuid_file`           varchar(255) DEFAULT NULL COMMENT 'uui前缀和文件名',
    `updater`             varchar(255) DEFAULT NULL COMMENT '修改人',
    `version_update_time` datetime     DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`upload_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for war_alarm_event
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_event`;
CREATE TABLE `war_alarm_event`
(
    `alarm_event_int`     int(9)      NOT NULL AUTO_INCREMENT COMMENT '预警事件主键',
    `alarm_event_id`      varchar(64) NOT NULL COMMENT '预警事件编码',
    `alarm_event_title`   varchar(255) DEFAULT NULL COMMENT '预警事件标题',
    `enable_status`       varchar(255) DEFAULT NULL COMMENT '是否启用',
    `alarm_level`         varchar(255) DEFAULT NULL COMMENT '预警级别',
    `upper_limit`         varchar(255) DEFAULT NULL COMMENT '上限',
    `lower_limit`         varchar(255) DEFAULT NULL COMMENT '下限',
    `alarm_event_content` varchar(255) DEFAULT NULL COMMENT '预警信息内容',
    `alarm_type`          varchar(255) DEFAULT NULL COMMENT '预警类型',
    `make_form_people`    varchar(255) DEFAULT NULL COMMENT '制单人',
    `make_form_time`      varchar(255) DEFAULT NULL COMMENT '制单时间',
    `update_people`       varchar(255) DEFAULT NULL COMMENT '修改人',
    `update_time`         varchar(255) DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`alarm_event_int`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for war_alarm_rule
-- ----------------------------
DROP TABLE IF EXISTS `war_alarm_rule`;
CREATE TABLE `war_alarm_rule`
(
    `alarm_rule_int`        int(255) NOT NULL AUTO_INCREMENT COMMENT '预警规则主键',
    `alarm_rule_id`         varchar(255) DEFAULT NULL COMMENT '预警规则编码',
    `alarm_rule_title`      varchar(255) DEFAULT NULL COMMENT '预警规则标题',
    `enable`                varchar(255) DEFAULT NULL COMMENT '是否启用',
    `monitor_level`         varchar(255) DEFAULT NULL COMMENT '监控层级',
    `alarm_event_int`       int(255)     DEFAULT NULL COMMENT '预警事件主键',
    `alarm_rule_describe`   varchar(255) DEFAULT NULL COMMENT '预警规则描述',
    `rule_make_form_people` varchar(255) DEFAULT NULL COMMENT '制单人',
    `rule_make_form_time`   varchar(255) DEFAULT NULL COMMENT '制单时间',
    `rule_update_people`    varchar(255) DEFAULT NULL COMMENT '修改人',
    `rule_update_time`      varchar(255) DEFAULT NULL COMMENT 'ruleUpdateTime',
    PRIMARY KEY (`alarm_rule_int`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for war_monitor_equipment
-- ----------------------------
DROP TABLE IF EXISTS `war_monitor_equipment`;
CREATE TABLE `war_monitor_equipment`
(
    `monitor_equipment_id` int(9) NOT NULL AUTO_INCREMENT COMMENT '监控对象主键',
    `alarm_rule_int`       int(9) DEFAULT NULL COMMENT '预警规则主键',
    `equipment_int`        int(9) DEFAULT NULL COMMENT '监控对象主键（监控对象为设备，即为设备主键）',
    PRIMARY KEY (`monitor_equipment_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPACT;
