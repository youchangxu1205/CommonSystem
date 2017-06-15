/*
Navicat MySQL Data Transfer

Source Server         : 本地centos服务器
Source Server Version : 50717
Source Host           : 192.168.217.129:3306
Source Database       : staffing_system

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-06-15 18:28:54
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
-- Records of multiplescore_emp_range
-- ----------------------------
INSERT INTO `multiplescore_emp_range` VALUES ('35', '35', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '36', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '37', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '38', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '39', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '40', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '41', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '42', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '43', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('35', '44', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '35', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '36', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '37', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '38', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '39', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '40', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '41', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '42', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '43', '1');
INSERT INTO `multiplescore_emp_range` VALUES ('36', '44', '1');

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
-- Records of multiplescore_event
-- ----------------------------
INSERT INTO `multiplescore_event` VALUES ('1', '微信分享', '1', null, '12', '2', '2017-06-08 05:55:45', '2017-06-08 06:09:14', '1', '微信分享', '1');
INSERT INTO `multiplescore_event` VALUES ('2', '状态五度', '1', null, '12', '1', '2017-06-11 03:36:53', '2017-06-11 03:43:43', '2', '状态五度', '1');
INSERT INTO `multiplescore_event` VALUES ('3', '状态', '12', null, '123', '1', '2017-06-11 03:44:27', '2017-06-11 03:44:57', '2', '1123', '1');
INSERT INTO `multiplescore_event` VALUES ('4', '玖零分享', '12', null, '123', '1', '2017-06-11 03:45:16', '2017-06-11 03:45:16', '1', '玖零分享', '1');
INSERT INTO `multiplescore_event` VALUES ('5', '财务奖励', '1', null, '122', '1', '2017-06-11 04:35:12', '2017-06-11 04:35:12', '5', '财务奖励', '1');

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
-- Records of multiplescore_event_range
-- ----------------------------
INSERT INTO `multiplescore_event_range` VALUES ('35', '1', '1');

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
-- Records of multiplescore_eventcategory
-- ----------------------------
INSERT INTO `multiplescore_eventcategory` VALUES ('1', '分享类', '2017-06-08 06:06:01', '2017-06-08 06:06:01', '分享类', '1');
INSERT INTO `multiplescore_eventcategory` VALUES ('2', '状态五度类', '2017-06-08 06:06:21', '2017-06-11 04:34:03', '状态五度类', '1');
INSERT INTO `multiplescore_eventcategory` VALUES ('5', '财务类', '2017-06-11 04:34:56', '2017-06-11 04:34:56', '财务类', '1');

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
-- Records of multiplescore_post_event_range
-- ----------------------------
INSERT INTO `multiplescore_post_event_range` VALUES ('1', '1', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('1', '2', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('1', '3', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('1', '4', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('1', '5', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('2', '1', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('2', '2', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('2', '3', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('2', '4', '1');
INSERT INTO `multiplescore_post_event_range` VALUES ('2', '5', '1');

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
-- Records of multiplescore_post_range
-- ----------------------------
INSERT INTO `multiplescore_post_range` VALUES ('1', '1', '1');
INSERT INTO `multiplescore_post_range` VALUES ('1', '2', '1');
INSERT INTO `multiplescore_post_range` VALUES ('1', '3', '1');
INSERT INTO `multiplescore_post_range` VALUES ('2', '1', '1');
INSERT INTO `multiplescore_post_range` VALUES ('2', '2', '1');
INSERT INTO `multiplescore_post_range` VALUES ('3', '1', '1');
INSERT INTO `multiplescore_post_range` VALUES ('3', '2', '1');
INSERT INTO `multiplescore_post_range` VALUES ('3', '3', '1');

-- ----------------------------
-- Table structure for multiplescore_scorebill
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_scorebill`;
CREATE TABLE `multiplescore_scorebill` (
  `scoreBillId` bigint(20) NOT NULL AUTO_INCREMENT,
  `scoreBillNo` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `drawerId` bigint(20) DEFAULT NULL,
  `scoreBillDesc` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `scoreBillStatus` tinyint(4) DEFAULT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  `isEnable` tinyint(1) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`scoreBillId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of multiplescore_scorebill
-- ----------------------------
INSERT INTO `multiplescore_scorebill` VALUES ('1', null, '35', '管理事务', '1', '1', '1', '2017-06-14 11:34:37', '2017-06-14 11:34:37');
INSERT INTO `multiplescore_scorebill` VALUES ('2', null, '35', '', '1', null, '0', '2017-06-15 17:39:58', '2017-06-15 17:39:58');
INSERT INTO `multiplescore_scorebill` VALUES ('3', null, '35', '', '1', null, '0', '2017-06-15 17:40:32', '2017-06-15 17:40:32');
INSERT INTO `multiplescore_scorebill` VALUES ('4', null, '35', '测试信息', '1', null, '0', '2017-06-15 17:43:12', '2017-06-15 17:43:12');
INSERT INTO `multiplescore_scorebill` VALUES ('5', null, '35', '', '1', null, '1', '2017-06-15 17:44:52', '2017-06-15 17:44:52');
INSERT INTO `multiplescore_scorebill` VALUES ('6', null, '35', '', '1', null, '1', '2017-06-15 17:48:37', '2017-06-15 17:48:37');
INSERT INTO `multiplescore_scorebill` VALUES ('7', null, '35', '', '1', null, '1', '2017-06-15 17:51:11', '2017-06-15 17:51:11');
INSERT INTO `multiplescore_scorebill` VALUES ('8', null, '35', '', '1', null, '1', '2017-06-15 17:53:42', '2017-06-15 17:53:42');
INSERT INTO `multiplescore_scorebill` VALUES ('9', null, '35', '', '1', '1', '1', '2017-06-15 17:56:43', '2017-06-15 17:56:43');
INSERT INTO `multiplescore_scorebill` VALUES ('10', null, '44', '', '1', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51');
INSERT INTO `multiplescore_scorebill` VALUES ('11', null, '35', '', '1', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19');
INSERT INTO `multiplescore_scorebill` VALUES ('12', null, '35', '', '1', '1', '1', '2017-06-15 18:22:05', '2017-06-15 18:22:05');
INSERT INTO `multiplescore_scorebill` VALUES ('13', null, '35', '', '1', '1', '1', '2017-06-15 18:23:05', '2017-06-15 18:23:05');

-- ----------------------------
-- Table structure for multiplescore_scorebill_detail
-- ----------------------------
DROP TABLE IF EXISTS `multiplescore_scorebill_detail`;
CREATE TABLE `multiplescore_scorebill_detail` (
  `scoreBillDetailId` bigint(20) NOT NULL AUTO_INCREMENT,
  `drawerId` bigint(20) DEFAULT NULL,
  `draweeId` bigint(20) DEFAULT NULL,
  `eventId` bigint(20) DEFAULT NULL,
  `scoreBillDetailScore` float DEFAULT NULL,
  `scoreBillDetailDesc` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `isEnable` tinyint(2) DEFAULT NULL,
  `enterpriseId` bigint(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scoreBillId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`scoreBillDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of multiplescore_scorebill_detail
-- ----------------------------
INSERT INTO `multiplescore_scorebill_detail` VALUES ('1', '35', '35', '1', '1', '测测', '1', '1', '2017-06-15 17:43:16', '2017-06-15 17:57:23', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('2', '35', '35', '2', '1', '测测', '1', '1', '2017-06-15 17:43:16', '2017-06-15 17:57:24', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('3', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 17:44:55', '2017-06-15 17:57:25', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('4', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 17:44:55', '2017-06-15 17:57:25', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('5', '35', '35', '3', '1', '无', '1', '1', '2017-06-15 17:44:55', '2017-06-15 17:57:26', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('6', '35', '35', '4', '1', '无', '1', '1', '2017-06-15 17:44:55', '2017-06-15 17:57:26', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('7', '35', '35', '5', '1', '无', '1', '1', '2017-06-15 17:44:55', '2017-06-15 17:57:27', '1');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('8', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 17:48:37', '2017-06-15 17:57:27', '6');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('9', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 17:48:37', '2017-06-15 17:57:28', '6');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('10', '35', '35', '3', '1', '无', '1', '1', '2017-06-15 17:48:37', '2017-06-15 17:57:28', '6');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('11', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 17:52:09', '2017-06-15 17:57:29', '7');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('12', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 17:52:09', '2017-06-15 17:57:30', '7');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('13', '35', '35', '3', '1', '无', '1', '1', '2017-06-15 17:52:09', '2017-06-15 17:57:30', '7');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('14', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 17:53:52', '2017-06-15 17:57:31', '8');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('15', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 17:53:52', '2017-06-15 17:57:32', '8');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('16', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 17:56:44', '2017-06-15 17:56:44', '9');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('17', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 17:56:44', '2017-06-15 17:56:44', '9');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('18', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 17:56:44', '2017-06-15 17:56:44', '9');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('19', '44', '35', '1', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('20', '44', '35', '2', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('21', '44', '35', '3', '12', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('22', '44', '35', '4', '12', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('23', '44', '35', '5', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('24', '44', '44', '1', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('25', '44', '44', '2', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('26', '44', '44', '3', '12', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('27', '44', '44', '4', '12', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('28', '44', '44', '5', '1', '无', '1', '1', '2017-06-15 18:18:51', '2017-06-15 18:18:51', '10');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('29', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('30', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('31', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('32', '35', '35', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('33', '35', '35', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('34', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('35', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('36', '35', '44', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('37', '35', '44', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('38', '35', '44', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('39', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('40', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('41', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('42', '35', '35', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('43', '35', '35', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('44', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('45', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('46', '35', '44', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('47', '35', '44', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('48', '35', '44', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('49', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('50', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('51', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('52', '35', '35', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('53', '35', '35', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('54', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('55', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('56', '35', '44', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('57', '35', '44', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('58', '35', '44', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('59', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('60', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('61', '35', '35', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('62', '35', '35', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('63', '35', '35', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('64', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('65', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('66', '35', '44', '3', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('67', '35', '44', '4', '12', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('68', '35', '44', '5', '1', '无', '1', '1', '2017-06-15 18:20:19', '2017-06-15 18:20:19', '11');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('69', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:22:05', '2017-06-15 18:22:05', '12');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('70', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:22:05', '2017-06-15 18:22:05', '12');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('71', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:22:05', '2017-06-15 18:22:05', '12');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('72', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:22:05', '2017-06-15 18:22:05', '12');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('73', '35', '35', '1', '1', '无', '1', '1', '2017-06-15 18:23:06', '2017-06-15 18:23:06', '13');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('74', '35', '35', '2', '1', '无', '1', '1', '2017-06-15 18:23:06', '2017-06-15 18:23:06', '13');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('75', '35', '44', '1', '1', '无', '1', '1', '2017-06-15 18:23:06', '2017-06-15 18:23:06', '13');
INSERT INTO `multiplescore_scorebill_detail` VALUES ('76', '35', '44', '2', '1', '无', '1', '1', '2017-06-15 18:23:06', '2017-06-15 18:23:06', '13');

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
-- Records of staffing_emp
-- ----------------------------
INSERT INTO `staffing_emp` VALUES ('35', '徐长友', '18039211881', null, '1', null, '2017-05-25 13:56:02', '2015-07-01 00:00:00', '2017-06-07 22:51:46', '2015-12-01 00:00:00', 'xcy', '0b01879281e3c4bbf5360219b3cfd0a6', '03f8ad3c96a649f943a02cd1d6de38c1');
INSERT INTO `staffing_emp` VALUES ('36', '杨光', '18638692720', null, '1', null, '2017-05-25 13:57:00', '2016-07-01 00:00:00', '2017-05-26 17:10:47', '2016-12-01 00:00:00', 'yg', 'eea7de5143ecf4154e1d82c545e0e028', 'a0390845c6b057cdd235ed821731f319');
INSERT INTO `staffing_emp` VALUES ('37', '臧飞', '15538003366', null, '1', null, '2017-05-26 15:29:21', '2017-05-26 00:00:00', '2017-05-26 15:29:21', '2017-05-26 00:00:00', 'zangfei', 'c12ab1fefe85f559d73018297d3e6bf2', 'a61af7c6e805df71941436014742a0bf');
INSERT INTO `staffing_emp` VALUES ('38', '刘知行', '18637829090', null, '1', null, '2017-05-26 17:45:37', '2017-05-26 00:00:00', '2017-05-26 17:45:37', '2017-05-26 00:00:00', 'liuzhixing', '0beb3dce6189167618c65daf69b1c7f5', '1c92b9be6fd163fad4761080039f7575');
INSERT INTO `staffing_emp` VALUES ('39', '李康', '13523013867', null, '1', null, '2017-05-31 12:47:26', '2017-05-31 00:00:00', '2017-05-31 12:47:26', '2017-05-31 00:00:00', 'likang', '4a0f49d4f98f28692fb7680870950aa3', 'dc2105f2032a530e733b79183cdb432f');
INSERT INTO `staffing_emp` VALUES ('40', '安然', '12345613867', null, '1', null, '2017-05-31 15:48:45', '2017-05-31 00:00:00', '2017-05-31 15:48:45', '2017-05-31 00:00:00', 'anran', 'f618ba664278c284626ca658a6b2b9fc', '3046736a7ac4d070e73dc46286682839');
INSERT INTO `staffing_emp` VALUES ('41', '超级管理员', '18039211882', null, '1', null, '2017-06-01 09:55:13', '2017-06-01 00:00:00', '2017-06-06 16:05:37', '2017-06-01 00:00:00', 'admin', '1b06b436ccd4923f4809763b09338ab5', '86be7eefb61bca4a2bc7857bbe1530c2');
INSERT INTO `staffing_emp` VALUES ('42', '超级管理员', '18039211883', null, '1', null, '2017-06-01 10:25:58', '2017-06-01 00:00:00', '2017-06-06 16:05:40', '2017-06-01 00:00:00', 'superadmin', 'cea4c0c447b48617fd3c94de3696b49e', '244f88f63364147e31b0c51acec0c591');
INSERT INTO `staffing_emp` VALUES ('43', 'root', '18039211884', null, '1', null, '2017-06-01 10:26:27', '2017-06-01 00:00:00', '2017-06-06 16:05:43', '2017-06-01 00:00:00', 'root', 'ea3f2e9f0c8b1a1148b8541fb8d2061a', '5070f799aff633f8e3c60796d16299e2');
INSERT INTO `staffing_emp` VALUES ('44', 'superoot', '18039211885', null, '1', null, '2017-06-01 10:28:22', '2017-06-01 00:00:00', '2017-06-06 16:05:46', '2017-06-01 00:00:00', 'superroot', '06e01eb850c2e70e0c15178642da67ff', '667e688c7b4390a6089288b2c411bce3');
INSERT INTO `staffing_emp` VALUES ('45', '111', '18039211886', null, '1', null, '2017-06-02 11:18:07', '2017-06-02 00:00:00', '2017-06-06 16:05:50', '2017-06-02 00:00:00', 'youchangxu', 'e19061c85fc56b52da59bff13e7ada45', '0d744b33616931e3d1a0b9994b95f028');
INSERT INTO `staffing_emp` VALUES ('46', '胡坤龙', '15535002233', null, '1', null, '2017-06-02 15:35:44', '2017-06-02 00:00:00', '2017-06-02 15:35:44', '2017-06-02 00:00:00', 'hukunlong', '3c635ef1e4bd6c19c1474bafa75b6ba4', 'def862e85103f7b7d6f5150f2bb466d8');
INSERT INTO `staffing_emp` VALUES ('47', '123456', '123', null, '1', null, '2017-06-02 17:04:11', '2017-06-02 00:00:00', '2017-06-02 17:04:11', '2017-06-02 00:00:00', '12345', '463aea0d2809e01ac7460200e56a9f90', '863bbee0d5fdd616c7376ba8d52fa0c7');
INSERT INTO `staffing_emp` VALUES ('48', '1', '1', null, '1', null, '2017-06-02 17:39:23', '2017-06-02 00:00:00', '2017-06-02 17:39:23', '2017-06-02 00:00:00', '1', '08b1b84219ca9954800d7ff9bb2eb4b9', 'd2bb0636c8825c3716ba7dd4597be600');
INSERT INTO `staffing_emp` VALUES ('49', '财务1', '18039211887', null, '1', null, '2017-06-02 17:53:43', '2017-06-02 00:00:00', '2017-06-06 16:05:54', '2017-06-02 00:00:00', 'caiwu1', 'd9d18519bb2538e650bc6e081764eb40', '1f97a81a678a1434ec70180c05551743');
INSERT INTO `staffing_emp` VALUES ('52', '系统管理员', 'saiyousystem', null, '0', null, '2017-06-05 10:59:33', '2017-06-05 10:59:32', '2017-06-05 10:59:33', '2017-06-05 10:59:32', 'saiyousystem', '459f6f00c31b6a5e6fa715b48b0964ad', 'f1f0871f1c409e25d67695ae46359a7c');
INSERT INTO `staffing_emp` VALUES ('53', '系统管理员', 'guangguangsystem', null, '1', null, '2017-06-05 11:04:10', '2017-06-05 11:04:10', '2017-06-05 11:14:51', '2017-06-05 11:04:10', 'guangguangsystem', '611adf8acb1d2ce4934aa3552a48823c', '2897de18e5a284baf6fd77dee453b93f');
INSERT INTO `staffing_emp` VALUES ('54', '123', '123', null, '1', null, '2017-06-05 11:20:55', '2017-06-05 00:00:00', '2017-06-05 11:20:55', '2017-06-05 00:00:00', 'qwe', '3bfce5a8ae0a0e9b44044cd446ac6f9f', '174ea470a8f24e5d5a542feabb63b911');
INSERT INTO `staffing_emp` VALUES ('55', 'caafdfasdf', '123', null, '1', null, '2017-06-05 11:49:53', '2017-06-05 00:00:00', '2017-06-05 11:49:53', '2017-06-05 00:00:00', 'caiwusystem', 'b921e6d1919ce4e77e3d151343d68d68', 'f092947f2ec682b079cdc42a506a49c5');
INSERT INTO `staffing_emp` VALUES ('56', '124142354', '12314155', null, '1', null, '2017-06-05 16:47:27', '2017-06-05 00:00:00', '2017-06-05 16:47:27', '2017-06-05 00:00:00', '12342423', '18497a9ec4a42a50b5db81ffe6c55c05', 'cb7b7af6ad2868802217872ec30ab824');
INSERT INTO `staffing_emp` VALUES ('57', 'Admin231231', '123123123', null, '1', null, '2017-06-05 16:55:38', '2017-06-05 00:00:00', '2017-06-05 16:55:38', '2017-06-05 00:00:00', 'Admin1', 'cd9514f65936cad17c2128db4af65611', '6f1bd58acff71a715ce20854e8371b79');
INSERT INTO `staffing_emp` VALUES ('58', '系统管理员', 'baidusystem', null, '1', null, '2017-04-12 19:39:47', '2017-04-12 19:39:48', '2017-04-12 19:39:47', '2017-04-12 19:39:48', 'baidusystem', '329dd80c00a63a7686778ccdd7f804cb', 'a407e1cd2ed05ef9c38071840d6a780f');
INSERT INTO `staffing_emp` VALUES ('59', '市场部经理', '15538003366', null, '1', null, '2017-04-12 19:44:42', '2017-06-06 00:00:00', '2017-04-12 19:44:42', '2017-06-06 00:00:00', '市场部经理', 'f81cb8f75a156a19578bcfa8575b0f82', '58c0d538ae209d75dd25448341d56c30');
INSERT INTO `staffing_emp` VALUES ('60', '请问', '15555', null, '1', null, '2017-04-13 00:24:30', '2017-06-06 00:00:00', '2017-04-13 00:24:30', '2017-06-06 00:00:00', 'qwe', '48516ac8d35ea627aeaa4b3454b4c4ee', 'da8d781d40b0e5c4d2c085f237225b9f');

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
-- Records of staffing_enterprise
-- ----------------------------
INSERT INTO `staffing_enterprise` VALUES ('1', '多态科技有限公司', 'dtkj');
INSERT INTO `staffing_enterprise` VALUES ('2', '卡车团', 'kct');
INSERT INTO `staffing_enterprise` VALUES ('5', '赛优', 'saiyou');
INSERT INTO `staffing_enterprise` VALUES ('6', '光光', 'guangguang');
INSERT INTO `staffing_enterprise` VALUES ('7', '百度', 'baidu');

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
-- Records of staffing_enterprise_emp
-- ----------------------------
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '35', '1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '36', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '37', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '38', '1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '39', '1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '40', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '41', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '42', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '43', '-1', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('1', '44', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '45', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '46', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '47', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '48', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('2', '49', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('5', '52', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '53', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '54', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '55', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '56', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '57', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('6', '60', '0', '48516ac8d35ea627aeaa4b3454b4c4ee', 'da8d781d40b0e5c4d2c085f237225b9f', 'qwe');
INSERT INTO `staffing_enterprise_emp` VALUES ('7', '58', '0', null, null, null);
INSERT INTO `staffing_enterprise_emp` VALUES ('7', '59', '0', null, null, null);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of staffing_log
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
  `enterpriseId` bigint(11) NOT NULL COMMENT '企业ID',
  `orgPath` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `orgManagerId` bigint(20) DEFAULT NULL COMMENT '部门负责人',
  PRIMARY KEY (`orgId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org
-- ----------------------------
INSERT INTO `staffing_org` VALUES ('1', '多态科技有限公司', '0', '2017-05-08 09:03:26', '2017-06-10 22:00:10', '1', '1', '1', null);
INSERT INTO `staffing_org` VALUES ('2', '多态积分研发部', '1', '2017-05-08 09:03:37', '2017-06-10 22:00:16', '2', '1', '1,2', null);
INSERT INTO `staffing_org` VALUES ('3', '市场部', '1', '2017-05-08 09:03:49', '2017-06-10 22:00:22', '2', '1', '1,3', null);
INSERT INTO `staffing_org` VALUES ('4', '人事部', '1', '2017-05-09 14:31:56', '2017-06-10 22:00:30', '2', '1', '1,4', null);
INSERT INTO `staffing_org` VALUES ('5', '财务部', '1', '2017-05-09 14:33:54', '2017-06-10 22:00:37', '2', '1', '1,5', null);
INSERT INTO `staffing_org` VALUES ('12', '市场一部', '3', '2017-05-25 18:02:16', '2017-06-10 22:25:14', '2', '1', '1,3,12', null);
INSERT INTO `staffing_org` VALUES ('13', '卡车团', '0', '2017-06-02 11:33:36', '2017-06-10 22:00:58', '1', '2', '13', null);
INSERT INTO `staffing_org` VALUES ('14', '人事部', '13', '2017-06-02 17:12:58', '2017-06-10 22:01:04', '2', '2', '13,14', null);
INSERT INTO `staffing_org` VALUES ('15', '财务部', '14', '2017-06-02 17:40:04', '2017-06-10 22:01:11', '2', '2', '13,14,15', null);
INSERT INTO `staffing_org` VALUES ('18', '赛优', '0', '2017-06-05 10:59:32', '2017-06-10 22:01:16', '1', '5', '18', null);
INSERT INTO `staffing_org` VALUES ('19', '光光', '0', '2017-06-05 11:04:10', '2017-06-10 22:01:21', '1', '6', '19', null);
INSERT INTO `staffing_org` VALUES ('20', '财务部', '19', '2017-06-05 11:35:04', '2017-06-10 22:01:26', '2', '6', '19,20', null);
INSERT INTO `staffing_org` VALUES ('21', '市场部', '19', '2017-06-05 11:45:49', '2017-06-10 22:01:32', '2', '6', '19,21', null);
INSERT INTO `staffing_org` VALUES ('22', '研发部', '19', '2017-06-05 11:46:21', '2017-06-10 22:01:38', '2', '6', '19,22', null);
INSERT INTO `staffing_org` VALUES ('23', '人事部', '19', '2017-06-05 11:46:59', '2017-06-10 22:01:50', '2', '6', '19,23', null);
INSERT INTO `staffing_org` VALUES ('24', '行政部', '19', '2017-06-05 11:47:54', '2017-06-10 22:01:56', '2', '6', '19,24', null);
INSERT INTO `staffing_org` VALUES ('25', '财务一部', '20', '2017-06-05 16:49:44', '2017-06-10 22:02:02', '2', '6', '19,20,25', null);
INSERT INTO `staffing_org` VALUES ('26', '百度', '0', '2017-04-12 19:39:47', '2017-06-10 22:02:09', '1', '7', '26', null);
INSERT INTO `staffing_org` VALUES ('27', '市场部', '26', '2017-04-12 19:43:43', '2017-06-10 22:02:15', '2', '7', '26,27', null);

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
  `isMaster` tinyint(1) DEFAULT NULL COMMENT '是否是主属部门',
  PRIMARY KEY (`orgId`,`empId`,`enterpriseId`),
  KEY `org_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_org_emp_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `staffing_org` (`orgId`),
  CONSTRAINT `staffing_org_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_org_emp
-- ----------------------------
INSERT INTO `staffing_org_emp` VALUES ('1', '35', '1', '2017-06-15 16:31:54', '2017-06-15 16:31:54', '1', null);
INSERT INTO `staffing_org_emp` VALUES ('1', '44', '1', '2017-06-15 18:18:27', '2017-06-15 18:18:27', '1', null);
INSERT INTO `staffing_org_emp` VALUES ('13', '45', '1', '2017-06-02 14:13:12', '2017-06-07 22:29:45', '2', null);
INSERT INTO `staffing_org_emp` VALUES ('13', '47', '1', '2017-06-02 17:04:12', '2017-06-07 22:29:46', '2', null);
INSERT INTO `staffing_org_emp` VALUES ('14', '48', '1', '2017-06-02 17:39:26', '2017-06-07 22:29:48', '2', null);
INSERT INTO `staffing_org_emp` VALUES ('15', '49', '1', '2017-06-02 17:53:43', '2017-06-07 22:30:01', '2', null);
INSERT INTO `staffing_org_emp` VALUES ('18', '52', '1', '2017-06-05 10:59:33', '2017-06-07 22:30:11', '5', null);
INSERT INTO `staffing_org_emp` VALUES ('19', '53', '1', '2017-06-05 11:04:10', '2017-06-07 22:30:23', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('19', '54', '1', '2017-06-05 11:20:55', '2017-06-07 22:30:24', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('19', '60', '1', '2017-04-13 00:24:30', '2017-06-07 22:30:25', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('20', '55', '1', '2017-06-05 11:49:53', '2017-06-07 22:30:26', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('21', '56', '1', '2017-06-05 16:47:28', '2017-06-07 22:30:27', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('25', '57', '1', '2017-06-05 16:55:38', '2017-06-07 22:30:28', '6', null);
INSERT INTO `staffing_org_emp` VALUES ('26', '58', '1', '2017-04-12 19:39:47', '2017-06-07 22:30:29', '7', null);
INSERT INTO `staffing_org_emp` VALUES ('27', '59', '1', '2017-04-12 19:44:42', '2017-06-07 22:30:30', '7', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
INSERT INTO `staffing_permission` VALUES ('16', '系统日志', '', '1', 'zmdi zmdi-more', '0', '', '2017-06-05 17:54:31', '1');
INSERT INTO `staffing_permission` VALUES ('17', '系统日志', '', '2', '', '16', '/log/index', '2017-06-05 17:54:55', '1');
INSERT INTO `staffing_permission` VALUES ('18', '积分管理', '', '1', 'zmdi zmdi-dot-circle-alt zmdi-hc-fw', '0', '', '2017-06-08 05:41:31', '1');
INSERT INTO `staffing_permission` VALUES ('19', '事件管理', 'staffing:event:read', '2', '', '18', '/event/index', '2017-06-08 05:41:56', '0');
INSERT INTO `staffing_permission` VALUES ('20', '岗位管理', '', '2', '', '1', '/post/index', '2017-06-10 13:36:41', '1');
INSERT INTO `staffing_permission` VALUES ('21', '单据管理', '', '2', '', '18', '/scorebill/index', '2017-06-14 11:31:41', '0');

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
-- Records of staffing_post
-- ----------------------------
INSERT INTO `staffing_post` VALUES ('1', '管理岗', '2017-06-10 13:35:16', '2017-06-10 14:39:37', '1', null, '1', '1');
INSERT INTO `staffing_post` VALUES ('2', '研发经理', '2017-06-10 14:33:24', '2017-06-10 14:39:38', '2', null, '0', '1');
INSERT INTO `staffing_post` VALUES ('3', '研发组长', '2017-06-10 14:42:11', '2017-06-10 14:42:11', '2', null, '0', '1');

-- ----------------------------
-- Table structure for staffing_post_emp
-- ----------------------------
DROP TABLE IF EXISTS `staffing_post_emp`;
CREATE TABLE `staffing_post_emp` (
  `postId` bigint(20) NOT NULL COMMENT '岗位ID',
  `empId` bigint(20) NOT NULL COMMENT '员工ID',
  `status` tinyint(1) DEFAULT '1' COMMENT '是否有效 1 有效 0 无效',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `enterpriseId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`postId`,`empId`),
  KEY `post_emp_id` (`empId`) USING BTREE,
  CONSTRAINT `staffing_post_emp_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `staffing_post` (`postId`),
  CONSTRAINT `staffing_post_emp_ibfk_2` FOREIGN KEY (`empId`) REFERENCES `staffing_emp` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of staffing_post_emp
-- ----------------------------
INSERT INTO `staffing_post_emp` VALUES ('1', '35', '0', '2017-06-15 16:31:54', '2017-06-15 16:31:54', '1');
INSERT INTO `staffing_post_emp` VALUES ('1', '44', '0', '2017-06-15 18:18:27', '2017-06-15 18:18:27', '1');

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
-- Records of staffing_role
-- ----------------------------
INSERT INTO `staffing_role` VALUES ('1', '超级管理员', '1');
INSERT INTO `staffing_role` VALUES ('2', '积分管理员', '2');
INSERT INTO `staffing_role` VALUES ('3', '组织架构管理员', '2');
INSERT INTO `staffing_role` VALUES ('4', '组织架构管理员', '1');
INSERT INTO `staffing_role` VALUES ('6', '系统管理员', '-1');
INSERT INTO `staffing_role` VALUES ('9', '系统管理员', '6');
INSERT INTO `staffing_role` VALUES ('10', '系统管理员', '7');

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
-- Records of staffing_role_emp
-- ----------------------------
INSERT INTO `staffing_role_emp` VALUES ('1', '35', '1');
INSERT INTO `staffing_role_emp` VALUES ('1', '39', '1');
INSERT INTO `staffing_role_emp` VALUES ('1', '41', '1');
INSERT INTO `staffing_role_emp` VALUES ('1', '44', '1');
INSERT INTO `staffing_role_emp` VALUES ('2', '36', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '37', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '38', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '40', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '41', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '44', '2');
INSERT INTO `staffing_role_emp` VALUES ('2', '45', '2');
INSERT INTO `staffing_role_emp` VALUES ('4', '35', '1');
INSERT INTO `staffing_role_emp` VALUES ('9', '53', '6');
INSERT INTO `staffing_role_emp` VALUES ('9', '54', '6');
INSERT INTO `staffing_role_emp` VALUES ('10', '58', '7');
INSERT INTO `staffing_role_emp` VALUES ('10', '59', '7');

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
INSERT INTO `staffing_role_permission` VALUES ('1', '16');
INSERT INTO `staffing_role_permission` VALUES ('1', '17');
INSERT INTO `staffing_role_permission` VALUES ('1', '18');
INSERT INTO `staffing_role_permission` VALUES ('1', '19');
INSERT INTO `staffing_role_permission` VALUES ('1', '20');
INSERT INTO `staffing_role_permission` VALUES ('1', '21');
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
INSERT INTO `staffing_role_permission` VALUES ('10', '1');
INSERT INTO `staffing_role_permission` VALUES ('10', '2');
INSERT INTO `staffing_role_permission` VALUES ('10', '3');
INSERT INTO `staffing_role_permission` VALUES ('10', '9');
INSERT INTO `staffing_role_permission` VALUES ('10', '10');
INSERT INTO `staffing_role_permission` VALUES ('10', '11');
INSERT INTO `staffing_role_permission` VALUES ('10', '12');
INSERT INTO `staffing_role_permission` VALUES ('10', '13');
INSERT INTO `staffing_role_permission` VALUES ('10', '15');

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
