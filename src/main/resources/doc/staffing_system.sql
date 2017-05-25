/*
Navicat MySQL Data Transfer

Source Server         : 本地服务器
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : staffing_system

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-05-25 18:20:48
*/

SET FOREIGN_KEY_CHECKS=0;

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
  `entryTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '入职时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `beFormalTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '转正时间',
  `userName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '员工登录名',
  PRIMARY KEY (`empId`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_emp
-- ----------------------------
INSERT INTO `staffing_emp` VALUES ('35', '徐长友', '18039211881', null, '1', null, '2017-05-25 13:56:02', '2015-07-01 00:00:00', '2017-05-25 13:56:02', '2015-12-01 00:00:00', 'xcy');
INSERT INTO `staffing_emp` VALUES ('36', '杨光', '18638692720', null, '1', null, '2017-05-25 13:57:00', '2016-07-01 00:00:00', '2017-05-25 13:57:00', '2016-12-01 00:00:00', 'yg');

-- ----------------------------
-- Table structure for staffing_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `staffing_enterprise`;
CREATE TABLE `staffing_enterprise` (
  `enterpriseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `enterpriseName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '企业名称',
  `enterpriseCode` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  PRIMARY KEY (`enterpriseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_enterprise
-- ----------------------------

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
  `enterpriseId` int(11) NOT NULL COMMENT '企业ID',
  PRIMARY KEY (`orgId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org
-- ----------------------------
INSERT INTO `staffing_org` VALUES ('1', '多态科技有限公司', '0', '2017-05-08 09:03:26', '2017-05-25 17:35:21', '1', '0');
INSERT INTO `staffing_org` VALUES ('2', '多态积分研发部', '1', '2017-05-08 09:03:37', '2017-05-09 15:09:59', '2', '0');
INSERT INTO `staffing_org` VALUES ('3', '市场部', '1', '2017-05-08 09:03:49', '2017-05-08 09:06:02', '2', '0');
INSERT INTO `staffing_org` VALUES ('4', '人事部', '1', '2017-05-09 14:31:56', '2017-05-25 15:46:21', '2', '0');
INSERT INTO `staffing_org` VALUES ('5', '财务部', '1', '2017-05-09 14:33:54', '2017-05-09 14:33:54', '2', '0');
INSERT INTO `staffing_org` VALUES ('12', '市场一部', '3', '2017-05-25 18:02:16', '2017-05-25 18:02:16', '2', '0');

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
  PRIMARY KEY (`orgId`,`empId`),
  KEY `org_emp_id` (`empId`),
  CONSTRAINT `emp_org_id` FOREIGN KEY (`orgId`) REFERENCES `staffing_org` (`orgId`),
  CONSTRAINT `org_emp_id` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org_emp
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_permission
-- ----------------------------
INSERT INTO `staffing_permission` VALUES ('1', '组织架构管理', ' ', '1', 'zmdi zmdi-city-alt zmdi-hc-fw', '0', '', '2017-05-09 17:02:10', '1');
INSERT INTO `staffing_permission` VALUES ('2', '员工管理', ' ', '2', 'zmdi zmdi-account zmdi-hc-fw', '1', '/emp/index', '2017-05-09 17:14:39', '1');
INSERT INTO `staffing_permission` VALUES ('3', '部门管理', ' ', '2', 'zmdi zmdi-accounts-list', '1', '/org/index', '2017-05-09 17:35:24', '1');
INSERT INTO `staffing_permission` VALUES ('4', '权限资源管理', ' ', '1', 'zmdi zmdi-lock-outline', '0', '', '2017-05-09 17:52:00', '1');
INSERT INTO `staffing_permission` VALUES ('5', '权限管理', ' ', '2', 'zmdi zmdi-lock-outline', '4', '/permission/index', '2017-05-09 17:52:53', '1');

-- ----------------------------
-- Table structure for staffing_post
-- ----------------------------
DROP TABLE IF EXISTS `staffing_post`;
CREATE TABLE `staffing_post` (
  `postId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `postName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '岗位名称',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  PRIMARY KEY (`postId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_post
-- ----------------------------

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
  KEY `post_emp_id` (`empId`),
  CONSTRAINT `emp_post_id` FOREIGN KEY (`postId`) REFERENCES `staffing_post` (`postId`),
  CONSTRAINT `post_emp_id` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_post_emp
-- ----------------------------

-- ----------------------------
-- Table structure for staffing_role
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role`;
CREATE TABLE `staffing_role` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `roleName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `enterpriseId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_role
-- ----------------------------

-- ----------------------------
-- Table structure for staffing_role_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role_emp`;
CREATE TABLE `staffing_role_emp` (
  `roleId` int(11) NOT NULL,
  `empId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_role_emp
-- ----------------------------

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
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('2', '123', '123123');
