/*
Navicat MySQL Data Transfer

Source Server         : 本地centos服务器
Source Server Version : 50717
Source Host           : 192.168.217.129:3306
Source Database       : staffing_system

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-06-13 18:04:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for multiplescore_emp_range
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_emp_range`;
CREATE TABLE `multiplescore_emp_range` (
  `higherId` bigint(20) NOT NULL,
  `lowerId` bigint(20) NOT NULL,
  `enterpriseId` bigint(20) NOT NULL,
  PRIMARY KEY (`higherId`,`lowerId`,`enterpriseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='上下级关系表';

-- ----------------------------
-- Table structure for multiplescore_event
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_event`;
CREATE TABLE `multiplescore_event` (
  `eventId` bigint(20) NOT NULL AUTO_INCREMENT,
  `eventName` varchar(255) COLLATE utf8_bin NOT NULL,
  `minScore` int(11) DEFAULT NULL,
  `eventScore` int(11) DEFAULT NULL COMMENT '单人单月最高奖分',
  `maxScore` int(11) DEFAULT NULL,
  `isFixed` tinyint(4) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `eventCategoryId` bigint(20) DEFAULT NULL,
  `eventDesc` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for multiplescore_event_range
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_event_range`;
CREATE TABLE `multiplescore_event_range` (
  `empId` bigint(20) NOT NULL,
  `eventId` bigint(20) NOT NULL,
  `enterpriseId` bigint(20) NOT NULL,
  PRIMARY KEY (`empId`,`eventId`,`enterpriseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for multiplescore_eventcategory
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_eventcategory`;
CREATE TABLE `multiplescore_eventcategory` (
  `eventCategoryId` bigint(20) NOT NULL AUTO_INCREMENT,
  `eventCategoryName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `eventCategoryDesc` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`eventCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for multiplescore_post_event_range
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_post_event_range`;
CREATE TABLE `multiplescore_post_event_range` (
  `postHigherId` bigint(20) NOT NULL,
  `scoreEventId` bigint(20) NOT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`postHigherId`,`scoreEventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for multiplescore_post_range
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_post_range`;
CREATE TABLE `multiplescore_post_range` (
  `postHigherId` bigint(20) NOT NULL,
  `postLowerId` bigint(20) NOT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`postHigherId`,`postLowerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_emp`;
CREATE TABLE `staffing_emp` (
  `empId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `empName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '员工姓名',
  `empPhone` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '员工手机号',
  `empAvatarUrl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '员工头像',
  `empStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '员工状态:-2:离职 -1:试岗离开 1:试岗中 2:在职 3:休长假',
  `otherInfo` text COLLATE utf8_bin COMMENT '员工其他信息,用json格式保存',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `entryTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入职时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `beFormalTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '转正时间',
  `username` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '员工登录名',
  `password` varchar(50) COLLATE utf8_bin NOT NULL,
  `salt` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`empId`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `staffing_enterprise`;
CREATE TABLE `staffing_enterprise` (
  `enterpriseId` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `enterpriseName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '企业名称',
  `enterpriseCode` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  PRIMARY KEY (`enterpriseId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_enterprise_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_enterprise_emp`;
CREATE TABLE `staffing_enterprise_emp` (
  `enterpriseId` bigint(11) NOT NULL,
  `empId` bigint(11) NOT NULL,
  `status` tinyint(11) DEFAULT '-1' COMMENT '是否激活 在企业添加时需要设置为待激活 -1 未激活 1 已激活',
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enterpriseEmpName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`enterpriseId`,`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_log
-- ----------------------------
DROP TABLE IF EXISTS `staffing_log`;
CREATE TABLE `staffing_log` (
  `logId` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `description` varchar(100) DEFAULT NULL COMMENT '操作描述',
  `username` varchar(20) DEFAULT NULL COMMENT '操作用户',
  `startTime` bigint(20) DEFAULT NULL COMMENT '操作时间',
  `spendTime` int(11) DEFAULT NULL COMMENT '消耗时间',
  `basePath` varchar(100) DEFAULT NULL COMMENT '根路径',
  `uri` varchar(200) DEFAULT NULL COMMENT 'URI',
  `url` varchar(200) DEFAULT NULL COMMENT 'URL',
  `method` varchar(10) DEFAULT NULL COMMENT '请求类型',
  `parameter` mediumtext,
  `userAgent` varchar(200) DEFAULT NULL COMMENT '用户标识',
  `ip` varchar(30) DEFAULT NULL COMMENT 'IP地址',
  `result` mediumtext,
  `permissions` varchar(100) DEFAULT NULL COMMENT '权限值',
  PRIMARY KEY (`logId`)
) ENGINE=InnoDB AUTO_INCREMENT=2729 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Table structure for staffing_org
-- ----------------------------
DROP TABLE IF EXISTS `staffing_org`;
CREATE TABLE `staffing_org` (
  `orgId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `orgName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '部门名称',
  `pOrgId` bigint(20) DEFAULT NULL COMMENT '上级部门',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `orgType` tinyint(4) DEFAULT NULL COMMENT '1为企业 2为部门',
  `enterpriseId` bigint(11) NOT NULL COMMENT '企业ID',
  `orgPath` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `orgManagerId` bigint(20) DEFAULT NULL COMMENT '部门负责人',
  PRIMARY KEY (`orgId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_org_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_org_emp`;
CREATE TABLE `staffing_org_emp` (
  `orgId` bigint(20) NOT NULL COMMENT '部门ID',
  `empId` bigint(20) NOT NULL COMMENT '员工ID',
  `status` tinyint(4) DEFAULT '1' COMMENT '是否有效 1有效 2无效',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `enterpriseId` bigint(20) NOT NULL,
  PRIMARY KEY (`orgId`,`empId`,`enterpriseId`),
  KEY `org_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_org_emp_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `staffing_org` (`orgId`),
  CONSTRAINT `staffing_org_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_permission
-- ----------------------------
DROP TABLE IF EXISTS `staffing_permission`;
CREATE TABLE `staffing_permission` (
  `permissionId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限Id',
  `permissionName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '权限名称',
  `permissionValue` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '权限值',
  `permissionType` tinyint(4) NOT NULL COMMENT '权限类型 1 目录 2 菜单 3 按钮',
  `permissionIcon` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '权限图标',
  `pPermissionId` bigint(20) NOT NULL COMMENT '上级权限',
  `permissionUri` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '权限地址',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `permissionStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '权限状态:1 可用 0 不可用',
  PRIMARY KEY (`permissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_post
-- ----------------------------
DROP TABLE IF EXISTS `staffing_post`;
CREATE TABLE `staffing_post` (
  `postId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `postName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '岗位名称',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `orgId` bigint(20) DEFAULT NULL,
  `pathName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `isManager` tinyint(1) DEFAULT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_post_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_post_emp`;
CREATE TABLE `staffing_post_emp` (
  `postId` bigint(20) NOT NULL COMMENT '岗位ID',
  `empId` bigint(20) NOT NULL COMMENT '员工ID',
  `status` tinyint(4) DEFAULT '1' COMMENT '是否有效 1 有效 0 无效',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  PRIMARY KEY (`postId`,`empId`),
  KEY `post_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_post_emp_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `staffing_post` (`postId`),
  CONSTRAINT `staffing_post_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_role
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role`;
CREATE TABLE `staffing_role` (
  `roleId` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `roleName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `enterpriseId` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_role_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role_emp`;
CREATE TABLE `staffing_role_emp` (
  `roleId` bigint(11) NOT NULL,
  `empId` bigint(11) NOT NULL,
  `enterpriseId` bigint(20) NOT NULL,
  PRIMARY KEY (`roleId`,`empId`,`enterpriseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for staffing_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role_permission`;
CREATE TABLE `staffing_role_permission` (
  `roleId` bigint(11) NOT NULL,
  `permissionId` bigint(11) NOT NULL,
  PRIMARY KEY (`roleId`,`permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `age` int(3) DEFAULT NULL COMMENT '用户年龄',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Function structure for getOrgChild
-- ----------------------------
DROP FUNCTION IF EXISTS `getOrgChild`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getOrgChild`(`rootId` int) RETURNS varchar(255) CHARSET utf8 COLLATE utf8_bin
BEGIN
DECLARE sTemp VARCHAR(255);
DECLARE sTempChd VARCHAR (255);
SET sTemp = '';
SET sTempChd = rootId;


WHILE sTempChd IS NOT NULL DO

SET sTemp = concat(sTemp, ',', sTempChd);

SELECT
	group_concat(orgid) INTO sTempChd
FROM
	staffing_org
WHERE
	FIND_IN_SET(pOrgId, sTempChd) > 0;
END
WHILE;

RETURN sTemp;
END
;;
DELIMITER ;
