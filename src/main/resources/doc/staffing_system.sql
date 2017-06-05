/*
Navicat MySQL Data Transfer

Source Server         : 本地服务器
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : staffing_system

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-06-05 16:45:00
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
  `username` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '员工登录名',
  `password` varchar(50) COLLATE utf8_bin NOT NULL,
  `salt` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`empId`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_emp
-- ----------------------------
INSERT INTO `staffing_emp` VALUES ('35', '徐长友', '18039211881', null, '3', null, '2017-05-25 13:56:02', '2015-07-01 00:00:00', '2017-06-02 15:21:50', '2015-12-01 00:00:00', 'xcy', '0b01879281e3c4bbf5360219b3cfd0a6', '03f8ad3c96a649f943a02cd1d6de38c1');
INSERT INTO `staffing_emp` VALUES ('36', '杨光', '18638692720', null, '1', null, '2017-05-25 13:57:00', '2016-07-01 00:00:00', '2017-05-26 17:10:47', '2016-12-01 00:00:00', 'yg', 'eea7de5143ecf4154e1d82c545e0e028', 'a0390845c6b057cdd235ed821731f319');
INSERT INTO `staffing_emp` VALUES ('37', '臧飞', '15538003366', null, '1', null, '2017-05-26 15:29:21', '2017-05-26 00:00:00', '2017-05-26 15:29:21', '2017-05-26 00:00:00', 'zangfei', 'c12ab1fefe85f559d73018297d3e6bf2', 'a61af7c6e805df71941436014742a0bf');
INSERT INTO `staffing_emp` VALUES ('38', '刘知行', '18637829090', null, '1', null, '2017-05-26 17:45:37', '2017-05-26 00:00:00', '2017-05-26 17:45:37', '2017-05-26 00:00:00', 'liuzhixing', '0beb3dce6189167618c65daf69b1c7f5', '1c92b9be6fd163fad4761080039f7575');
INSERT INTO `staffing_emp` VALUES ('39', '李康', '13523013867', null, '1', null, '2017-05-31 12:47:26', '2017-05-31 00:00:00', '2017-05-31 12:47:26', '2017-05-31 00:00:00', 'likang', '4a0f49d4f98f28692fb7680870950aa3', 'dc2105f2032a530e733b79183cdb432f');
INSERT INTO `staffing_emp` VALUES ('40', '安然', '12345613867', null, '1', null, '2017-05-31 15:48:45', '2017-05-31 00:00:00', '2017-05-31 15:48:45', '2017-05-31 00:00:00', 'anran', 'f618ba664278c284626ca658a6b2b9fc', '3046736a7ac4d070e73dc46286682839');
INSERT INTO `staffing_emp` VALUES ('41', '超级管理员', '18039211881', null, '1', null, '2017-06-01 09:55:13', '2017-06-01 00:00:00', '2017-06-01 09:55:13', '2017-06-01 00:00:00', 'admin', '1b06b436ccd4923f4809763b09338ab5', '86be7eefb61bca4a2bc7857bbe1530c2');
INSERT INTO `staffing_emp` VALUES ('42', '超级管理员', '18039211881', null, '1', null, '2017-06-01 10:25:58', '2017-06-01 00:00:00', '2017-06-01 10:25:58', '2017-06-01 00:00:00', 'superadmin', 'cea4c0c447b48617fd3c94de3696b49e', '244f88f63364147e31b0c51acec0c591');
INSERT INTO `staffing_emp` VALUES ('43', 'root', '18039211881', null, '1', null, '2017-06-01 10:26:27', '2017-06-01 00:00:00', '2017-06-01 10:26:27', '2017-06-01 00:00:00', 'root', 'ea3f2e9f0c8b1a1148b8541fb8d2061a', '5070f799aff633f8e3c60796d16299e2');
INSERT INTO `staffing_emp` VALUES ('44', 'superoot', '18039211881', null, '1', null, '2017-06-01 10:28:22', '2017-06-01 00:00:00', '2017-06-01 10:28:22', '2017-06-01 00:00:00', 'superroot', '06e01eb850c2e70e0c15178642da67ff', '667e688c7b4390a6089288b2c411bce3');
INSERT INTO `staffing_emp` VALUES ('45', '111', '18039211881', null, '1', null, '2017-06-02 11:18:07', '2017-06-02 00:00:00', '2017-06-02 11:21:22', '2017-06-02 00:00:00', 'youchangxu', 'e19061c85fc56b52da59bff13e7ada45', '0d744b33616931e3d1a0b9994b95f028');
INSERT INTO `staffing_emp` VALUES ('46', '胡坤龙', '15535002233', null, '1', null, '2017-06-02 15:35:44', '2017-06-02 00:00:00', '2017-06-02 15:35:44', '2017-06-02 00:00:00', 'hukunlong', '3c635ef1e4bd6c19c1474bafa75b6ba4', 'def862e85103f7b7d6f5150f2bb466d8');
INSERT INTO `staffing_emp` VALUES ('47', '123456', '123', null, '1', null, '2017-06-02 17:04:11', '2017-06-02 00:00:00', '2017-06-02 17:04:11', '2017-06-02 00:00:00', '12345', '463aea0d2809e01ac7460200e56a9f90', '863bbee0d5fdd616c7376ba8d52fa0c7');
INSERT INTO `staffing_emp` VALUES ('48', '1', '1', null, '1', null, '2017-06-02 17:39:23', '2017-06-02 00:00:00', '2017-06-02 17:39:23', '2017-06-02 00:00:00', '1', '08b1b84219ca9954800d7ff9bb2eb4b9', 'd2bb0636c8825c3716ba7dd4597be600');
INSERT INTO `staffing_emp` VALUES ('49', '财务1', '18039211881', null, '1', null, '2017-06-02 17:53:43', '2017-06-02 00:00:00', '2017-06-02 17:53:43', '2017-06-02 00:00:00', 'caiwu1', 'd9d18519bb2538e650bc6e081764eb40', '1f97a81a678a1434ec70180c05551743');
INSERT INTO `staffing_emp` VALUES ('52', '系统管理员', 'saiyousystem', null, '0', null, '2017-06-05 10:59:33', '2017-06-05 10:59:32', '2017-06-05 10:59:33', '2017-06-05 10:59:32', 'saiyousystem', '459f6f00c31b6a5e6fa715b48b0964ad', 'f1f0871f1c409e25d67695ae46359a7c');
INSERT INTO `staffing_emp` VALUES ('53', '系统管理员', 'guangguangsystem', null, '1', null, '2017-06-05 11:04:10', '2017-06-05 11:04:10', '2017-06-05 11:14:51', '2017-06-05 11:04:10', 'guangguangsystem', '611adf8acb1d2ce4934aa3552a48823c', '2897de18e5a284baf6fd77dee453b93f');
INSERT INTO `staffing_emp` VALUES ('54', '123', '123', null, '1', null, '2017-06-05 11:20:55', '2017-06-05 00:00:00', '2017-06-05 11:20:55', '2017-06-05 00:00:00', 'qwe', '3bfce5a8ae0a0e9b44044cd446ac6f9f', '174ea470a8f24e5d5a542feabb63b911');
INSERT INTO `staffing_emp` VALUES ('55', 'caafdfasdf', '123', null, '1', null, '2017-06-05 11:49:53', '2017-06-05 00:00:00', '2017-06-05 11:49:53', '2017-06-05 00:00:00', 'caiwusystem', 'b921e6d1919ce4e77e3d151343d68d68', 'f092947f2ec682b079cdc42a506a49c5');

-- ----------------------------
-- Table structure for staffing_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `staffing_enterprise`;
CREATE TABLE `staffing_enterprise` (
  `enterpriseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `enterpriseName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '企业名称',
  `enterpriseCode` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  PRIMARY KEY (`enterpriseId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_enterprise
-- ----------------------------
INSERT INTO `staffing_enterprise` VALUES ('1', '多态科技有限公司', 'dtkj');
INSERT INTO `staffing_enterprise` VALUES ('2', '卡车团', 'kct');
INSERT INTO `staffing_enterprise` VALUES ('5', '赛优', 'saiyou');
INSERT INTO `staffing_enterprise` VALUES ('6', '光光', 'guangguang');

-- ----------------------------
-- Table structure for staffing_enterprise_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_enterprise_emp`;
CREATE TABLE `staffing_enterprise_emp` (
  `enterpriseId` int(11) NOT NULL,
  `empId` int(11) NOT NULL,
  `status` tinyint(11) DEFAULT '-1' COMMENT '是否激活 在企业添加时需要设置为待激活 -1 未激活 1 已激活',
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`enterpriseId`,`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_enterprise_emp
-- ----------------------------
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '35', '1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '36', '-1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '37', '-1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '38', '1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '39', '1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '40', '-1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '41', '-1', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '44', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '45', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '46', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '47', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '48', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '49', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('5', '52', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '53', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '54', '0', null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '55', '0', null, null);

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
  `orgPath` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `orgManagerId` bigint(20) DEFAULT NULL COMMENT '部门负责人',
  PRIMARY KEY (`orgId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org
-- ----------------------------
INSERT INTO `staffing_org` VALUES ('1', '多态科技有限公司', '0', '2017-05-08 09:03:26', '2017-06-05 11:10:49', '1', '1', '/0/1/', null);
INSERT INTO `staffing_org` VALUES ('2', '多态积分研发部', '1', '2017-05-08 09:03:37', '2017-06-05 11:10:52', '2', '1', '/0/1/2/', null);
INSERT INTO `staffing_org` VALUES ('3', '市场部', '1', '2017-05-08 09:03:49', '2017-06-05 11:10:55', '2', '1', '/0/1/3/', null);
INSERT INTO `staffing_org` VALUES ('4', '人事部', '1', '2017-05-09 14:31:56', '2017-06-05 11:10:57', '2', '1', '/0/1/4/', null);
INSERT INTO `staffing_org` VALUES ('5', '财务部', '1', '2017-05-09 14:33:54', '2017-06-05 11:11:00', '2', '1', '/0/1/5/', null);
INSERT INTO `staffing_org` VALUES ('12', '市场一部', '3', '2017-05-25 18:02:16', '2017-06-05 11:11:03', '2', '1', '/0/3/12/', null);
INSERT INTO `staffing_org` VALUES ('13', '卡车团', '0', '2017-06-02 11:33:36', '2017-06-05 11:11:06', '1', '2', '/0/13/', null);
INSERT INTO `staffing_org` VALUES ('14', '人事部', '13', '2017-06-02 17:12:58', '2017-06-05 11:11:08', '2', '2', '/0/13/14/', null);
INSERT INTO `staffing_org` VALUES ('15', '财务部', '14', '2017-06-02 17:40:04', '2017-06-05 11:11:12', '2', '2', '/0/13/14/15/', null);
INSERT INTO `staffing_org` VALUES ('18', '赛优', '0', '2017-06-05 10:59:32', '2017-06-05 11:11:21', '1', '5', '/0/18/', null);
INSERT INTO `staffing_org` VALUES ('19', '光光', '0', '2017-06-05 11:04:10', '2017-06-05 11:11:24', '1', '6', '/0/19/', null);
INSERT INTO `staffing_org` VALUES ('20', '财务部', '19', '2017-06-05 11:35:04', '2017-06-05 11:35:04', '2', '6', '/0/19/20/', null);
INSERT INTO `staffing_org` VALUES ('21', '市场部', '19', '2017-06-05 11:45:49', '2017-06-05 11:45:49', '2', '6', '/0/19/21/', null);
INSERT INTO `staffing_org` VALUES ('22', '研发部', '19', '2017-06-05 11:46:21', '2017-06-05 11:46:21', '2', '6', '/0/19/22/', null);
INSERT INTO `staffing_org` VALUES ('23', '人事部', '19', '2017-06-05 11:46:59', '2017-06-05 11:46:59', '2', '6', '/0/19/23/', null);
INSERT INTO `staffing_org` VALUES ('24', '行政部', '19', '2017-06-05 11:47:54', '2017-06-05 11:47:54', '2', '6', '/0/19/24/', null);

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
  KEY `org_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_org_emp_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `staffing_org` (`orgId`),
  CONSTRAINT `staffing_org_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org_emp
-- ----------------------------
INSERT INTO `staffing_org_emp` VALUES ('1', '35', '1', '2017-06-01 16:53:22', '2017-06-01 16:53:22');
INSERT INTO `staffing_org_emp` VALUES ('1', '36', '1', '2017-06-01 17:54:19', '2017-06-01 17:54:19');
INSERT INTO `staffing_org_emp` VALUES ('1', '37', '1', '2017-06-01 17:54:24', '2017-06-01 17:54:24');
INSERT INTO `staffing_org_emp` VALUES ('1', '38', '1', '2017-06-01 17:54:32', '2017-06-01 17:54:32');
INSERT INTO `staffing_org_emp` VALUES ('1', '39', '1', '2017-06-01 17:54:36', '2017-06-01 17:54:36');
INSERT INTO `staffing_org_emp` VALUES ('1', '40', '1', '2017-06-01 17:54:41', '2017-06-01 17:54:41');
INSERT INTO `staffing_org_emp` VALUES ('1', '41', '1', '2017-06-01 17:54:51', '2017-06-01 17:54:51');
INSERT INTO `staffing_org_emp` VALUES ('1', '42', '1', '2017-06-01 17:54:55', '2017-06-01 17:54:55');
INSERT INTO `staffing_org_emp` VALUES ('1', '43', '1', '2017-06-01 17:54:58', '2017-06-01 17:54:58');
INSERT INTO `staffing_org_emp` VALUES ('1', '44', '1', '2017-06-01 17:55:04', '2017-06-01 17:55:04');
INSERT INTO `staffing_org_emp` VALUES ('2', '35', '1', '2017-06-01 17:55:47', '2017-06-01 17:55:47');
INSERT INTO `staffing_org_emp` VALUES ('3', '35', '1', '2017-06-01 18:03:45', '2017-06-01 18:03:45');
INSERT INTO `staffing_org_emp` VALUES ('4', '36', '1', '2017-06-01 18:03:59', '2017-06-01 18:03:59');
INSERT INTO `staffing_org_emp` VALUES ('12', '36', '1', '2017-06-01 18:04:27', '2017-06-01 18:04:27');
INSERT INTO `staffing_org_emp` VALUES ('13', '45', '1', '2017-06-02 14:13:12', '2017-06-02 15:28:06');
INSERT INTO `staffing_org_emp` VALUES ('13', '47', '1', '2017-06-02 17:04:12', '2017-06-02 17:04:12');
INSERT INTO `staffing_org_emp` VALUES ('14', '48', '1', '2017-06-02 17:39:26', '2017-06-02 17:39:26');
INSERT INTO `staffing_org_emp` VALUES ('15', '49', '1', '2017-06-02 17:53:43', '2017-06-02 17:53:43');
INSERT INTO `staffing_org_emp` VALUES ('18', '52', '1', '2017-06-05 10:59:33', '2017-06-05 10:59:33');
INSERT INTO `staffing_org_emp` VALUES ('19', '53', '1', '2017-06-05 11:04:10', '2017-06-05 11:04:10');
INSERT INTO `staffing_org_emp` VALUES ('19', '54', '1', '2017-06-05 11:20:55', '2017-06-05 11:20:55');
INSERT INTO `staffing_org_emp` VALUES ('20', '55', '1', '2017-06-05 11:49:53', '2017-06-05 11:49:53');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_permission
-- ----------------------------
INSERT INTO `staffing_permission` VALUES ('1', '组织架构管理', 'staffing:emp:org:read', '1', 'zmdi zmdi-city-alt zmdi-hc-fw', '0', '', '2017-05-09 17:02:10', '1');
INSERT INTO `staffing_permission` VALUES ('2', '员工管理', 'staffing:emp:read', '2', 'zmdi zmdi-account zmdi-hc-fw', '1', '/emp/index', '2017-05-09 17:14:39', '1');
INSERT INTO `staffing_permission` VALUES ('3', '部门管理', 'staffing:org:read', '2', 'zmdi zmdi-accounts-list', '1', '/org/index', '2017-05-09 17:35:24', '1');
INSERT INTO `staffing_permission` VALUES ('4', '权限资源管理', 'staffing:permission:read', '1', 'zmdi zmdi-lock-outline', '0', '', '2017-05-09 17:52:00', '1');
INSERT INTO `staffing_permission` VALUES ('5', '权限管理', 'staffing:permission:read', '2', 'zmdi zmdi-lock-outline', '4', '/permission/index', '2017-05-09 17:52:53', '1');
INSERT INTO `staffing_permission` VALUES ('6', '企业管理', 'staffing:enterprise:read', '1', 'zmdi zmdi-city zmdi-hc-fw', '0', ' ', '2017-05-26 09:23:40', '1');
INSERT INTO `staffing_permission` VALUES ('7', '企业管理', 'staffing:enterprise:read', '2', 'zmdi zmdi-city zmdi-hc-fw', '6', '/enterprise/index', '2017-05-26 09:24:15', '1');
INSERT INTO `staffing_permission` VALUES ('8', '角色管理', 'staffing:role:read', '2', '', '4', '/role/index', '2017-05-27 11:14:27', '1');
INSERT INTO `staffing_permission` VALUES ('9', '添加员工', 'staffing:emp:create', '3', '', '2', '/emp/create', '2017-05-31 12:20:08', '1');
INSERT INTO `staffing_permission` VALUES ('10', '员工角色', 'staffing:emp:role', '3', '', '2', '/emp/role', '2017-05-31 12:32:06', '1');
INSERT INTO `staffing_permission` VALUES ('11', '修改密码 ', 'staffing:emp:password', '3', '', '2', '/emp/password', '2017-05-31 12:42:45', '1');
INSERT INTO `staffing_permission` VALUES ('12', '编辑员工', 'staffing:emp:update', '3', '', '2', '/emp/update', '2017-05-31 13:10:07', '1');
INSERT INTO `staffing_permission` VALUES ('13', '新增企业', 'staffing:enterprise:create', '3', '', '7', '/enterprise/create', '2017-05-31 17:53:45', '1');
INSERT INTO `staffing_permission` VALUES ('15', '编辑企业', 'staffing:enterprise:update', '3', '', '7', '/enterprise/update', '2017-05-31 20:36:39', '1');

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
  KEY `post_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_post_emp_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `staffing_post` (`postId`),
  CONSTRAINT `staffing_post_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
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
  `enterpriseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_role
-- ----------------------------
INSERT INTO `staffing_role` VALUES ('1', '超级管理员', '1');
INSERT INTO `staffing_role` VALUES ('2', '积分管理员', '2');
INSERT INTO `staffing_role` VALUES ('3', '组织架构管理员', '2');
INSERT INTO `staffing_role` VALUES ('4', '组织架构管理员', '1');
INSERT INTO `staffing_role` VALUES ('6', '系统管理员', '-1');
INSERT INTO `staffing_role` VALUES ('9', '系统管理员', '6');

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
INSERT INTO `staffing_role_emp` VALUES ('1', '39');
INSERT INTO `staffing_role_emp` VALUES ('1', '41');
INSERT INTO `staffing_role_emp` VALUES ('1', '44');
INSERT INTO `staffing_role_emp` VALUES ('2', '36');
INSERT INTO `staffing_role_emp` VALUES ('2', '37');
INSERT INTO `staffing_role_emp` VALUES ('2', '38');
INSERT INTO `staffing_role_emp` VALUES ('2', '40');
INSERT INTO `staffing_role_emp` VALUES ('2', '41');
INSERT INTO `staffing_role_emp` VALUES ('2', '44');
INSERT INTO `staffing_role_emp` VALUES ('2', '45');
INSERT INTO `staffing_role_emp` VALUES ('4', '35');
INSERT INTO `staffing_role_emp` VALUES ('8', '52');
INSERT INTO `staffing_role_emp` VALUES ('9', '53');
INSERT INTO `staffing_role_emp` VALUES ('9', '54');

-- ----------------------------
-- Table structure for staffing_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `staffing_role_permission`;
CREATE TABLE `staffing_role_permission` (
  `roleId` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_role_permission
-- ----------------------------
INSERT INTO `staffing_role_permission` VALUES ('1', '1');
INSERT INTO `staffing_role_permission` VALUES ('1', '2');
INSERT INTO `staffing_role_permission` VALUES ('1', '3');
INSERT INTO `staffing_role_permission` VALUES ('1', '4');
INSERT INTO `staffing_role_permission` VALUES ('1', '5');
INSERT INTO `staffing_role_permission` VALUES ('1', '6');
INSERT INTO `staffing_role_permission` VALUES ('1', '7');
INSERT INTO `staffing_role_permission` VALUES ('1', '8');
INSERT INTO `staffing_role_permission` VALUES ('1', '9');
INSERT INTO `staffing_role_permission` VALUES ('1', '10');
INSERT INTO `staffing_role_permission` VALUES ('1', '11');
INSERT INTO `staffing_role_permission` VALUES ('1', '12');
INSERT INTO `staffing_role_permission` VALUES ('1', '13');
INSERT INTO `staffing_role_permission` VALUES ('1', '15');
INSERT INTO `staffing_role_permission` VALUES ('2', '1');
INSERT INTO `staffing_role_permission` VALUES ('2', '2');
INSERT INTO `staffing_role_permission` VALUES ('2', '3');
INSERT INTO `staffing_role_permission` VALUES ('2', '4');
INSERT INTO `staffing_role_permission` VALUES ('2', '5');
INSERT INTO `staffing_role_permission` VALUES ('2', '6');
INSERT INTO `staffing_role_permission` VALUES ('2', '7');
INSERT INTO `staffing_role_permission` VALUES ('2', '8');
INSERT INTO `staffing_role_permission` VALUES ('2', '9');
INSERT INTO `staffing_role_permission` VALUES ('2', '10');
INSERT INTO `staffing_role_permission` VALUES ('2', '11');
INSERT INTO `staffing_role_permission` VALUES ('2', '12');
INSERT INTO `staffing_role_permission` VALUES ('2', '13');
INSERT INTO `staffing_role_permission` VALUES ('2', '15');
INSERT INTO `staffing_role_permission` VALUES ('4', '1');
INSERT INTO `staffing_role_permission` VALUES ('4', '2');
INSERT INTO `staffing_role_permission` VALUES ('4', '3');
INSERT INTO `staffing_role_permission` VALUES ('4', '9');
INSERT INTO `staffing_role_permission` VALUES ('4', '10');
INSERT INTO `staffing_role_permission` VALUES ('4', '11');
INSERT INTO `staffing_role_permission` VALUES ('4', '12');
INSERT INTO `staffing_role_permission` VALUES ('6', '1');
INSERT INTO `staffing_role_permission` VALUES ('6', '2');
INSERT INTO `staffing_role_permission` VALUES ('6', '3');
INSERT INTO `staffing_role_permission` VALUES ('6', '9');
INSERT INTO `staffing_role_permission` VALUES ('6', '10');
INSERT INTO `staffing_role_permission` VALUES ('6', '11');
INSERT INTO `staffing_role_permission` VALUES ('6', '12');
INSERT INTO `staffing_role_permission` VALUES ('6', '13');
INSERT INTO `staffing_role_permission` VALUES ('6', '15');
INSERT INTO `staffing_role_permission` VALUES ('8', '1');
INSERT INTO `staffing_role_permission` VALUES ('9', '1');
INSERT INTO `staffing_role_permission` VALUES ('9', '2');
INSERT INTO `staffing_role_permission` VALUES ('9', '3');
INSERT INTO `staffing_role_permission` VALUES ('9', '9');
INSERT INTO `staffing_role_permission` VALUES ('9', '10');
INSERT INTO `staffing_role_permission` VALUES ('9', '11');
INSERT INTO `staffing_role_permission` VALUES ('9', '12');
INSERT INTO `staffing_role_permission` VALUES ('9', '13');
INSERT INTO `staffing_role_permission` VALUES ('9', '15');

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
