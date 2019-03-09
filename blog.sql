/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2019-03-09 23:14:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account_emailaddress
-- ----------------------------
DROP TABLE IF EXISTS `account_emailaddress`;
CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_oauth_ouser_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_emailaddress
-- ----------------------------

-- ----------------------------
-- Table structure for account_emailconfirmation
-- ----------------------------
DROP TABLE IF EXISTS `account_emailconfirmation`;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `sent` datetime DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirmation_email_address_id_5b7f8c58_fk` (`email_address_id`),
  CONSTRAINT `account_emailconfirmation_email_address_id_5b7f8c58_fk` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_emailconfirmation
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add 文章', '6', 'add_article');
INSERT INTO `auth_permission` VALUES ('17', 'Can change 文章', '6', 'change_article');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete 文章', '6', 'delete_article');
INSERT INTO `auth_permission` VALUES ('19', 'Can add 图片轮播', '7', 'add_carousel');
INSERT INTO `auth_permission` VALUES ('20', 'Can change 图片轮播', '7', 'change_carousel');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete 图片轮播', '7', 'delete_carousel');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 分类', '8', 'add_category');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 分类', '8', 'change_category');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 分类', '8', 'delete_category');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 友情链接', '9', 'add_friendlink');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 友情链接', '9', 'change_friendlink');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 友情链接', '9', 'delete_friendlink');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 关键词', '10', 'add_keyword');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 关键词', '10', 'change_keyword');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 关键词', '10', 'delete_keyword');
INSERT INTO `auth_permission` VALUES ('31', 'Can add 死链', '11', 'add_silian');
INSERT INTO `auth_permission` VALUES ('32', 'Can change 死链', '11', 'change_silian');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete 死链', '11', 'delete_silian');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 标签', '12', 'add_tag');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 标签', '12', 'change_tag');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 标签', '12', 'delete_tag');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 时间线', '13', 'add_timeline');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 时间线', '13', 'change_timeline');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 时间线', '13', 'delete_timeline');
INSERT INTO `auth_permission` VALUES ('40', 'Can add 大分类', '14', 'add_bigcategory');
INSERT INTO `auth_permission` VALUES ('41', 'Can change 大分类', '14', 'change_bigcategory');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete 大分类', '14', 'delete_bigcategory');
INSERT INTO `auth_permission` VALUES ('43', 'Can add 用户', '15', 'add_ouser');
INSERT INTO `auth_permission` VALUES ('44', 'Can change 用户', '15', 'change_ouser');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete 用户', '15', 'delete_ouser');
INSERT INTO `auth_permission` VALUES ('46', 'Can add 关于自己评论', '16', 'add_aboutcomment');
INSERT INTO `auth_permission` VALUES ('47', 'Can change 关于自己评论', '16', 'change_aboutcomment');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete 关于自己评论', '16', 'delete_aboutcomment');
INSERT INTO `auth_permission` VALUES ('49', 'Can add 文章评论', '17', 'add_articlecomment');
INSERT INTO `auth_permission` VALUES ('50', 'Can change 文章评论', '17', 'change_articlecomment');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete 文章评论', '17', 'delete_articlecomment');
INSERT INTO `auth_permission` VALUES ('52', 'Can add comment user', '18', 'add_commentuser');
INSERT INTO `auth_permission` VALUES ('53', 'Can change comment user', '18', 'change_commentuser');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete comment user', '18', 'delete_commentuser');
INSERT INTO `auth_permission` VALUES ('55', 'Can add 给我留言', '19', 'add_messagecomment');
INSERT INTO `auth_permission` VALUES ('56', 'Can change 给我留言', '19', 'change_messagecomment');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete 给我留言', '19', 'delete_messagecomment');
INSERT INTO `auth_permission` VALUES ('58', 'Can add site', '20', 'add_site');
INSERT INTO `auth_permission` VALUES ('59', 'Can change site', '20', 'change_site');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete site', '20', 'delete_site');
INSERT INTO `auth_permission` VALUES ('61', 'Can add email address', '21', 'add_emailaddress');
INSERT INTO `auth_permission` VALUES ('62', 'Can change email address', '21', 'change_emailaddress');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete email address', '21', 'delete_emailaddress');
INSERT INTO `auth_permission` VALUES ('64', 'Can add email confirmation', '22', 'add_emailconfirmation');
INSERT INTO `auth_permission` VALUES ('65', 'Can change email confirmation', '22', 'change_emailconfirmation');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete email confirmation', '22', 'delete_emailconfirmation');
INSERT INTO `auth_permission` VALUES ('67', 'Can add social account', '23', 'add_socialaccount');
INSERT INTO `auth_permission` VALUES ('68', 'Can change social account', '23', 'change_socialaccount');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete social account', '23', 'delete_socialaccount');
INSERT INTO `auth_permission` VALUES ('70', 'Can add social application', '24', 'add_socialapp');
INSERT INTO `auth_permission` VALUES ('71', 'Can change social application', '24', 'change_socialapp');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete social application', '24', 'delete_socialapp');
INSERT INTO `auth_permission` VALUES ('73', 'Can add social application token', '25', 'add_socialtoken');
INSERT INTO `auth_permission` VALUES ('74', 'Can change social application token', '25', 'change_socialtoken');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete social application token', '25', 'delete_socialtoken');
INSERT INTO `auth_permission` VALUES ('76', 'Can add 公告', '26', 'add_activate');
INSERT INTO `auth_permission` VALUES ('77', 'Can change 公告', '26', 'change_activate');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete 公告', '26', 'delete_activate');

-- ----------------------------
-- Table structure for comment_aboutcomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_aboutcomment`;
CREATE TABLE `comment_aboutcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `author_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `rep_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_aboutcomment_author_id_d11e841e_fk_comment_c` (`author_id`),
  KEY `comment_aboutcomment_parent_id_a12294ac_fk_comment_a` (`parent_id`),
  KEY `comment_aboutcomment_rep_to_id_e44ab5ad_fk_comment_a` (`rep_to_id`),
  CONSTRAINT `comment_aboutcomment_author_id_d11e841e_fk_comment_c` FOREIGN KEY (`author_id`) REFERENCES `comment_commentuser` (`id`),
  CONSTRAINT `comment_aboutcomment_parent_id_a12294ac_fk_comment_a` FOREIGN KEY (`parent_id`) REFERENCES `comment_aboutcomment` (`id`),
  CONSTRAINT `comment_aboutcomment_rep_to_id_e44ab5ad_fk_comment_a` FOREIGN KEY (`rep_to_id`) REFERENCES `comment_aboutcomment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_aboutcomment
-- ----------------------------
INSERT INTO `comment_aboutcomment` VALUES ('1', '2019-03-02 23:40:04', 'dfdf ', '12', null, null);
INSERT INTO `comment_aboutcomment` VALUES ('2', '2019-03-02 23:45:45', 'efefe', '23', null, null);

-- ----------------------------
-- Table structure for comment_articlecomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_articlecomment`;
CREATE TABLE `comment_articlecomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `author_id` int(11) NOT NULL,
  `belong_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `rep_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_articlecomme_author_id_46e6fdb8_fk_comment_c` (`author_id`),
  KEY `comment_articlecomment_belong_id_58e0232c_fk_storm_article_id` (`belong_id`),
  KEY `comment_articlecomme_parent_id_f0ab594d_fk_comment_a` (`parent_id`),
  KEY `comment_articlecomme_rep_to_id_84dab3d5_fk_comment_a` (`rep_to_id`),
  CONSTRAINT `comment_articlecomment_belong_id_58e0232c_fk_storm_article_id` FOREIGN KEY (`belong_id`) REFERENCES `storm_article` (`id`),
  CONSTRAINT `comment_articlecomme_author_id_46e6fdb8_fk_comment_c` FOREIGN KEY (`author_id`) REFERENCES `comment_commentuser` (`id`),
  CONSTRAINT `comment_articlecomme_parent_id_f0ab594d_fk_comment_a` FOREIGN KEY (`parent_id`) REFERENCES `comment_articlecomment` (`id`),
  CONSTRAINT `comment_articlecomme_rep_to_id_84dab3d5_fk_comment_a` FOREIGN KEY (`rep_to_id`) REFERENCES `comment_articlecomment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_articlecomment
-- ----------------------------
INSERT INTO `comment_articlecomment` VALUES ('1', '2019-03-02 17:21:14', '气味芬芳', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('2', '2019-03-02 17:26:46', '肥肥的', '13', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('3', '2019-03-02 17:27:05', '的方式发送', '13', '1', '1', null);
INSERT INTO `comment_articlecomment` VALUES ('4', '2019-03-02 17:27:43', '放热峰', '13', '1', '3', null);
INSERT INTO `comment_articlecomment` VALUES ('5', '2019-03-02 17:28:07', '粉色分', '13', '1', '3', null);
INSERT INTO `comment_articlecomment` VALUES ('6', '2019-03-02 17:28:45', '发射点发生', '12', '1', '4', null);
INSERT INTO `comment_articlecomment` VALUES ('7', '2019-03-02 17:33:51', '放松放松v发', '14', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('8', '2019-03-02 17:48:12', '分分分', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('9', '2019-03-02 17:49:50', '分分', '12', '1', '3', null);
INSERT INTO `comment_articlecomment` VALUES ('10', '2019-03-02 17:50:10', '为非人防', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('11', '2019-03-02 17:51:08', '哥特人感染', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('12', '2019-03-02 18:00:07', '哈哈哈哈哈', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('13', '2019-03-02 18:00:26', '就哈哈哈哈哈', '12', '1', '3', null);
INSERT INTO `comment_articlecomment` VALUES ('14', '2019-03-02 18:06:10', '江河湖海你就回家', '18', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('15', '2019-03-02 18:09:49', '德尔福', '19', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('16', '2019-03-02 18:10:25', '的额', '12', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('17', '2019-03-02 18:18:14', 'de\'d', '21', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('18', '2019-03-02 18:20:19', '放热峰乳房', '22', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('19', '2019-03-02 18:20:37', '沟通', '22', '1', null, null);
INSERT INTO `comment_articlecomment` VALUES ('20', '2019-03-03 21:02:13', '纷纷', '10', '3', null, null);

-- ----------------------------
-- Table structure for comment_commentuser
-- ----------------------------
DROP TABLE IF EXISTS `comment_commentuser`;
CREATE TABLE `comment_commentuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_commentuser
-- ----------------------------
INSERT INTO `comment_commentuser` VALUES ('1', 'stor', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('3', '的', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('4', '打算', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('5', '额为全额', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('6', '热热给', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('7', '对的', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('8', 'ff', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('9', 'fref', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('10', '得分', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('11', '威威', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('12', 'createsuperuser', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('13', 'stor的', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('14', '		方法					', '1414749109@qq.com', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `comment_commentuser` VALUES ('18', 'hhhh', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('19', 'h\'h\'h', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('20', '', '', '');
INSERT INTO `comment_commentuser` VALUES ('21', '3e\'d', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('22', 'de\'f', '1414749109@qq.com', '');
INSERT INTO `comment_commentuser` VALUES ('23', 'creat', '1414749109@qq.com', '');

-- ----------------------------
-- Table structure for comment_messagecomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_messagecomment`;
CREATE TABLE `comment_messagecomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `author_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `rep_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_messagecomme_author_id_0bb97e6c_fk_comment_c` (`author_id`),
  KEY `comment_messagecomme_parent_id_d4633983_fk_comment_m` (`parent_id`),
  KEY `comment_messagecomme_rep_to_id_029597ed_fk_comment_m` (`rep_to_id`),
  CONSTRAINT `comment_messagecomme_author_id_0bb97e6c_fk_comment_c` FOREIGN KEY (`author_id`) REFERENCES `comment_commentuser` (`id`),
  CONSTRAINT `comment_messagecomme_parent_id_d4633983_fk_comment_m` FOREIGN KEY (`parent_id`) REFERENCES `comment_messagecomment` (`id`),
  CONSTRAINT `comment_messagecomme_rep_to_id_029597ed_fk_comment_m` FOREIGN KEY (`rep_to_id`) REFERENCES `comment_messagecomment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_messagecomment
-- ----------------------------
INSERT INTO `comment_messagecomment` VALUES ('1', '2019-02-27 23:57:34', '顶顶顶顶', '1', null, null);
INSERT INTO `comment_messagecomment` VALUES ('2', '2019-02-28 00:02:50', '低端市场', '3', null, null);
INSERT INTO `comment_messagecomment` VALUES ('3', '2019-02-28 00:05:37', '第三党', '4', null, null);
INSERT INTO `comment_messagecomment` VALUES ('4', '2019-02-28 00:06:10', 'e二五v', '4', null, null);
INSERT INTO `comment_messagecomment` VALUES ('5', '2019-02-28 00:07:13', '而维持', '5', null, null);
INSERT INTO `comment_messagecomment` VALUES ('6', '2019-02-28 00:11:39', '割让给外人', '5', null, null);
INSERT INTO `comment_messagecomment` VALUES ('7', '2019-02-28 00:11:58', '非人非如果', '5', null, null);
INSERT INTO `comment_messagecomment` VALUES ('8', '2019-02-28 00:12:26', '微微发热', '6', null, null);
INSERT INTO `comment_messagecomment` VALUES ('9', '2019-02-28 00:13:38', '的的额斐然斐然斐然', '7', null, null);
INSERT INTO `comment_messagecomment` VALUES ('10', '2019-02-28 00:14:03', '四点三十大风车是的', '7', null, null);
INSERT INTO `comment_messagecomment` VALUES ('11', '2019-02-28 00:27:54', 'fds ', '8', null, null);
INSERT INTO `comment_messagecomment` VALUES ('12', '2019-02-28 00:31:25', 'defef', '9', null, null);
INSERT INTO `comment_messagecomment` VALUES ('13', '2019-02-28 00:36:57', '的vv发v旅人', '10', null, null);
INSERT INTO `comment_messagecomment` VALUES ('14', '2019-02-28 00:37:26', '二点五v威威v', '10', null, null);
INSERT INTO `comment_messagecomment` VALUES ('15', '2019-02-28 00:37:57', '热热范围', '11', null, null);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_oauth_ouser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_ouser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2019-03-02 14:12:49', '1', 'python', '1', '[{\"added\": {}}]', '8', '4');
INSERT INTO `django_admin_log` VALUES ('2', '2019-03-02 14:16:02', '1', 'python', '1', '[{\"added\": {}}]', '12', '4');
INSERT INTO `django_admin_log` VALUES ('3', '2019-03-02 14:17:30', '1', 'python', '1', '[{\"added\": {}}]', '10', '4');
INSERT INTO `django_admin_log` VALUES ('4', '2019-03-02 14:18:07', '1', '创建Python虚拟环境——下', '1', '[{\"added\": {}}]', '6', '4');
INSERT INTO `django_admin_log` VALUES ('5', '2019-03-02 15:21:45', '1', 'Python爬虫学习系列教程', '1', '[{\"added\": {}}]', '7', '4');
INSERT INTO `django_admin_log` VALUES ('6', '2019-03-02 15:22:49', '2', '小白学爬虫系列教程', '1', '[{\"added\": {}}]', '7', '4');
INSERT INTO `django_admin_log` VALUES ('7', '2019-03-02 15:50:00', '1', 'Python爬虫学习系列教程', '2', '[{\"changed\": {\"fields\": [\"number\"]}}]', '7', '4');
INSERT INTO `django_admin_log` VALUES ('8', '2019-03-02 15:50:17', '2', '小白学爬虫系列教程', '2', '[{\"changed\": {\"fields\": [\"number\"]}}]', '7', '4');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('21', 'account', 'emailaddress');
INSERT INTO `django_content_type` VALUES ('22', 'account', 'emailconfirmation');
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('16', 'comment', 'aboutcomment');
INSERT INTO `django_content_type` VALUES ('17', 'comment', 'articlecomment');
INSERT INTO `django_content_type` VALUES ('18', 'comment', 'commentuser');
INSERT INTO `django_content_type` VALUES ('19', 'comment', 'messagecomment');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('15', 'oauth', 'ouser');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('20', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('23', 'socialaccount', 'socialaccount');
INSERT INTO `django_content_type` VALUES ('24', 'socialaccount', 'socialapp');
INSERT INTO `django_content_type` VALUES ('25', 'socialaccount', 'socialtoken');
INSERT INTO `django_content_type` VALUES ('26', 'storm', 'activate');
INSERT INTO `django_content_type` VALUES ('6', 'storm', 'article');
INSERT INTO `django_content_type` VALUES ('14', 'storm', 'bigcategory');
INSERT INTO `django_content_type` VALUES ('7', 'storm', 'carousel');
INSERT INTO `django_content_type` VALUES ('8', 'storm', 'category');
INSERT INTO `django_content_type` VALUES ('9', 'storm', 'friendlink');
INSERT INTO `django_content_type` VALUES ('10', 'storm', 'keyword');
INSERT INTO `django_content_type` VALUES ('11', 'storm', 'silian');
INSERT INTO `django_content_type` VALUES ('12', 'storm', 'tag');
INSERT INTO `django_content_type` VALUES ('13', 'storm', 'timeline');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2019-02-27 23:56:14');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2019-02-27 23:56:15');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2019-02-27 23:56:16');
INSERT INTO `django_migrations` VALUES ('11', 'oauth', '0001_initial', '2019-02-27 23:56:18');
INSERT INTO `django_migrations` VALUES ('12', 'account', '0001_initial', '2019-02-27 23:56:18');
INSERT INTO `django_migrations` VALUES ('13', 'account', '0002_email_max_length', '2019-02-27 23:56:19');
INSERT INTO `django_migrations` VALUES ('14', 'admin', '0001_initial', '2019-02-27 23:56:19');
INSERT INTO `django_migrations` VALUES ('15', 'admin', '0002_logentry_remove_auto_add', '2019-02-27 23:56:19');
INSERT INTO `django_migrations` VALUES ('16', 'storm', '0001_initial', '2019-02-27 23:56:22');
INSERT INTO `django_migrations` VALUES ('17', 'storm', '0002_islove', '2019-02-27 23:56:22');
INSERT INTO `django_migrations` VALUES ('18', 'storm', '0003_auto_20190224_1541', '2019-02-27 23:56:23');
INSERT INTO `django_migrations` VALUES ('19', 'storm', '0004_auto_20190224_1931', '2019-02-27 23:56:23');
INSERT INTO `django_migrations` VALUES ('20', 'storm', '0005_auto_20190225_2105', '2019-02-27 23:56:23');
INSERT INTO `django_migrations` VALUES ('21', 'storm', '0006_auto_20190225_2108', '2019-02-27 23:56:24');
INSERT INTO `django_migrations` VALUES ('22', 'storm', '0007_auto_20190225_2117', '2019-02-27 23:56:25');
INSERT INTO `django_migrations` VALUES ('23', 'storm', '0008_auto_20190225_2118', '2019-02-27 23:56:25');
INSERT INTO `django_migrations` VALUES ('24', 'storm', '0009_auto_20190225_2123', '2019-02-27 23:56:26');
INSERT INTO `django_migrations` VALUES ('25', 'comment', '0001_initial', '2019-02-27 23:56:30');
INSERT INTO `django_migrations` VALUES ('26', 'sessions', '0001_initial', '2019-02-27 23:56:30');
INSERT INTO `django_migrations` VALUES ('27', 'sites', '0001_initial', '2019-02-27 23:56:30');
INSERT INTO `django_migrations` VALUES ('28', 'sites', '0002_alter_domain_unique', '2019-02-27 23:56:30');
INSERT INTO `django_migrations` VALUES ('29', 'socialaccount', '0001_initial', '2019-02-27 23:56:32');
INSERT INTO `django_migrations` VALUES ('30', 'socialaccount', '0002_token_max_lengths', '2019-02-27 23:56:33');
INSERT INTO `django_migrations` VALUES ('31', 'socialaccount', '0003_extra_data_default_dict', '2019-02-27 23:56:33');
INSERT INTO `django_migrations` VALUES ('32', 'storm', '0010_activate', '2019-03-01 00:52:42');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('3wsc6krx3rz7ilxy1xvfqec717dqvtj0', 'YWYxZDA1YzFiMjllOTYwOGU2ZDYwOGUyMzI1NTI3MGI5YTYxZTFjYjp7InVzZXJuYW1lIjoiYXNkZmdoIiwiX2F1dGhfdXNlcl9pZCI6IjMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjVjNWM5MDgwNTEyNjFiMmRkMGY0ZmJjOTczMTBiZTU1NzU2MDViNWIifQ==', '2019-03-16 00:26:58');
INSERT INTO `django_session` VALUES ('b78k09ji2epez6puu791krmla2djzecn', 'MGJjOWFhNmNmMDFiZjY3ZmNjNjdjM2JkMzg2MDE0OWZjY2Y5ZTIzNjp7ImlzX3JlYWRfMSI6MTU1MTU5ODI4MC43MjYxOTI1LCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDUzMzc5ZTU2OWZkNzZmNWI0MTA5YzZiMGRiYjU4OGFiNzEyYzRiMSIsIm5pY2siOiJjcmVhdCIsInRpZCI6MjN9', '2019-03-17 15:31:20');
INSERT INTO `django_session` VALUES ('oaua1waqtm0mgimsp3s80chnxy3w4rck', 'MDczYTkyZDg4OWRjNWM5NzhhZjI3YTJjOTFlNmZmOTk4NDkxMjQxYzp7ImlzX3JlYWRfMSI6MTU1MTUzMDY4Ni44MzMwNTl9', '2019-03-16 20:44:47');
INSERT INTO `django_session` VALUES ('oq8oj0rh7tw4cakb8ctzdhq4uck1mkwy', 'MWQ5YTRjNTRlM2UwZDE3ZDcyMWNjN2YyMDYzNDVhODM0NTI0NTk4ZTp7ImlzX3JlYWRfMSI6MTU1MTYxNjEwMC40MzQ1MDgsImlzX3JlYWRfNiI6MTU1MTYxNjEyMC43NDYxNzIyLCJpc19yZWFkXzMiOjE1NTE2MTgyNDIuMzU5NDg5NywibmljayI6Ilx1NWY5N1x1NTIwNiIsInRpZCI6MTB9', '2019-03-17 21:04:02');
INSERT INTO `django_session` VALUES ('qw2y9tgt61k93fpvwx7zqj69yhg2wec1', 'NmZkNDE0YmVlMDk5NWI0MWE1MDYxNGYxNGQ0ODI1ZDBhZjkwOWMzYTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNTMzNzllNTY5ZmQ3NmY1YjQxMDljNmIwZGJiNTg4YWI3MTJjNGIxIiwidXNlcm5hbWUiOiJjcmVhdGVzdXBlcnVzZXIiLCJ1aWQiOjQsIm5pY2siOm51bGwsInRpZCI6bnVsbCwiaXNfcmVhZF8xIjoxNTUxNjk0OTU0LjIxMDk3MDJ9', '2019-03-18 18:22:34');
INSERT INTO `django_session` VALUES ('t4d2m6tfq5soo4si2din95s5iqhn90ys', 'YWI2NTUzNDhhZTgwYmEwODE0N2YzZWM2N2QyNDUyYjYzMDdmM2M1NTp7ImlzX3JlYWRfMSI6MTU1MTYxNTc1My4wNjE0NTE3LCJpc19yZWFkXzQiOjE1NTE2MTU3NjMuNzE3NDgxMSwiaXNfcmVhZF82IjoxNTUxNjE1ODM1LjI2Mzk5Nzh9', '2019-03-17 20:23:55');
INSERT INTO `django_session` VALUES ('uw0xjg2rhi2flcvaw1ntkwtmgosqthbk', 'Y2ViZDNhMWVmNmMyMWM2NGVlZGNlZGM5YjVkNzVjZTE3ODdhY2JmOTp7ImlzX3JlYWRfMSI6MTU1MTUyNDA2Ny41OTIxNTc4LCJuaWNrIjpudWxsLCJ0aWQiOm51bGwsIl9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNTMzNzllNTY5ZmQ3NmY1YjQxMDljNmIwZGJiNTg4YWI3MTJjNGIxIiwidXNlcm5hbWUiOiJjcmVhdGVzdXBlcnVzZXIiLCJ1aWQiOjR9', '2019-03-16 18:55:27');

-- ----------------------------
-- Table structure for django_site
-- ----------------------------
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_site
-- ----------------------------
INSERT INTO `django_site` VALUES ('1', 'example.com', 'example.com');

-- ----------------------------
-- Table structure for oauth_ouser
-- ----------------------------
DROP TABLE IF EXISTS `oauth_ouser`;
CREATE TABLE `oauth_ouser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `link` varchar(200) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_ouser
-- ----------------------------
INSERT INTO `oauth_ouser` VALUES ('1', 'pbkdf2_sha256$36000$P2Mt91Hx3fg2$c0VBYH+zIB2shdRrNT3OidoluZgta/2uTFjAZPfBVIU=', '2019-03-02 00:16:48', '0', 'stormsha', '', '', '1414749109@qq.com', '0', '1', '2019-03-02 00:16:47', '', 'avatar/default.png');
INSERT INTO `oauth_ouser` VALUES ('2', 'pbkdf2_sha256$36000$ZZmzUMz2lTpm$0xadcPRoeFUHZWxNkvh18mklwhjizMAQbhlsUAx0tJ8=', '2019-03-02 00:26:14', '0', 'storm', '', '', '1414749110@qq.com', '0', '1', '2019-03-02 00:22:46', '', 'avatar/default.png');
INSERT INTO `oauth_ouser` VALUES ('3', 'pbkdf2_sha256$36000$O8WvIJBxZqOR$0KbWOH6FUiwk8kFjQ/sGye2riwYi3nJEpXT3VWcGe+8=', '2019-03-02 13:55:17', '0', 'asdfgh', '', '', 'stormsha6@gmail.com', '0', '1', '2019-03-02 00:26:58', '', 'avatar/default.png');
INSERT INTO `oauth_ouser` VALUES ('4', 'pbkdf2_sha256$36000$zNEBARjVIhN3$BXXLsLtWIxfhmEyvOnTmtWFbiQeCnrtW0Jy02Try2jU=', '2019-03-04 15:52:55', '1', 'createsuperuser', '', '', '1414749109@qq.com', '1', '1', '2019-03-02 14:08:45', '', 'avatar/2019/03/02/微信图片_20190301204333.jpg');

-- ----------------------------
-- Table structure for oauth_ouser_groups
-- ----------------------------
DROP TABLE IF EXISTS `oauth_ouser_groups`;
CREATE TABLE `oauth_ouser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ouser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_ouser_groups_ouser_id_group_id_4a9e5409_uniq` (`ouser_id`,`group_id`),
  KEY `oauth_ouser_groups_group_id_ee861e08_fk_auth_group_id` (`group_id`),
  CONSTRAINT `oauth_ouser_groups_group_id_ee861e08_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `oauth_ouser_groups_ouser_id_c543bcdc_fk_oauth_ouser_id` FOREIGN KEY (`ouser_id`) REFERENCES `oauth_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_ouser_groups
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_ouser_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `oauth_ouser_user_permissions`;
CREATE TABLE `oauth_ouser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ouser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_ouser_user_permiss_ouser_id_permission_id_ab6b2ccc_uniq` (`ouser_id`,`permission_id`),
  KEY `oauth_ouser_user_per_permission_id_2b5b927f_fk_auth_perm` (`permission_id`),
  CONSTRAINT `oauth_ouser_user_permissions_ouser_id_12e23549_fk_oauth_ouser_id` FOREIGN KEY (`ouser_id`) REFERENCES `oauth_ouser` (`id`),
  CONSTRAINT `oauth_ouser_user_per_permission_id_2b5b927f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_ouser_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for socialaccount_socialaccount
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialaccount`;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_ouser_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of socialaccount_socialaccount
-- ----------------------------

-- ----------------------------
-- Table structure for socialaccount_socialapp
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialapp`;
CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of socialaccount_socialapp
-- ----------------------------

-- ----------------------------
-- Table structure for socialaccount_socialapp_sites
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of socialaccount_socialapp_sites
-- ----------------------------

-- ----------------------------
-- Table structure for socialaccount_socialtoken
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialtoken`;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of socialaccount_socialtoken
-- ----------------------------

-- ----------------------------
-- Table structure for storm_activate
-- ----------------------------
DROP TABLE IF EXISTS `storm_activate`;
CREATE TABLE `storm_activate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext,
  `is_active` tinyint(1) NOT NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_activate
-- ----------------------------
INSERT INTO `storm_activate` VALUES ('1', '本站源码已经共享在 <a href=\"https://github.com/stormsha\" target=\"_blank\">Github</a> 欢迎 Fork、Star、提建议、发现Bug', '1', '2019-03-06 00:53:46');

-- ----------------------------
-- Table structure for storm_article
-- ----------------------------
DROP TABLE IF EXISTS `storm_article`;
CREATE TABLE `storm_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `summary` longtext NOT NULL,
  `body` longtext NOT NULL,
  `img_link` varchar(255) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `views` int(11) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `loves` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `storm_article_author_id_113892f7_fk_oauth_ouser_id` (`author_id`),
  KEY `storm_article_category_id_c56e32c4_fk_storm_category_id` (`category_id`),
  CONSTRAINT `storm_article_author_id_113892f7_fk_oauth_ouser_id` FOREIGN KEY (`author_id`) REFERENCES `oauth_ouser` (`id`),
  CONSTRAINT `storm_article_category_id_c56e32c4_fk_storm_category_id` FOREIGN KEY (`category_id`) REFERENCES `storm_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_article
-- ----------------------------
INSERT INTO `storm_article` VALUES ('1', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:22:44', '22', '123', '1', '1', '4');
INSERT INTO `storm_article` VALUES ('2', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:24:14', '15', '124', '1', '1', '3');
INSERT INTO `storm_article` VALUES ('3', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 15:03:30', '17', '125', '1', '1', '1');
INSERT INTO `storm_article` VALUES ('4', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 15:03:35', '16', '126', '1', '1', '2');
INSERT INTO `storm_article` VALUES ('5', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:23:19', '15', '127', '1', '1', '5');
INSERT INTO `storm_article` VALUES ('6', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 15:03:44', '17', '128', '1', '1', '1');
INSERT INTO `storm_article` VALUES ('7', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:23:18', '15', '129', '1', '1', '3');
INSERT INTO `storm_article` VALUES ('8', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:22:17', '15', '130', '1', '1', '1');
INSERT INTO `storm_article` VALUES ('9', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-04 18:23:32', '15', '131', '1', '1', '2');
INSERT INTO `storm_article` VALUES ('10', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-02 14:18:07', '15', '132', '1', '1', '0');
INSERT INTO `storm_article` VALUES ('11', '创建Python虚拟环境——下', 'Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。', '##Python应用程序开发中，如果系统只安装了Python3.6.6。Python的优势之一是有众多的开源包，但是这也成为了Python的一大诟病。当开发者使用pip安装第三方包时，所安装的包会进入Python安装目录下的site-packages目录中。\r\n假如需要同时开发多个应用程序，这些应用程序将会共用一个Python环境，就是安装在系统的Python 3.6.6。如果应用A需要django==1.8.2，应用B需要django==2.0怎么办？\r\n这种情况下，每个应用需要各有一个“独立”的Python运行环境。virtualenv就是用来为一个应用创建一套“隔离”的Python运行环境。\r\n\r\n1、	python虚拟环境—virtualenv\r\nvirtualenv 是一个创建隔离Python开发环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需要的依赖包。\r\n安装virtualenv\r\npip install virtualenv\r\n	 \r\n	安装完成后输入virtualenv按下回车，了解virtualenv的基本功能选项\r\n基本使用：\r\n虚拟 环境是可以随处放置的，进入需要放置的文件夹，点击右键选择“在此处打开shell窗口” 或者 打开cmd 通过cd 进入需要放置的文件夹\r\n$ virtualenv venv    # venv  虚拟环境名称，名称自定义，默认创建一个干净的环境\r\n \r\n$ virtualenv --system-site-packages venv  # 创建一个包含本地已经安装的依赖包的虚拟环境\r\n\r\n\r\n \r\nvirtualenv -p E:\\Python36\\python.exe venv\r\n\r\n查看本地已经安装的python环境\r\n \r\n\r\n \r\n\r\n退出虚拟环境\r\n\r\n2、	安装virtualenvwrapper对虚拟环境集中管理\r\n\r\npip install virtualenvwrapper-win\r\n\r\n	配置环境变量\r\n\r\n	打开环境变量，在系统环境变量中点击新建\r\n \r\n\r\n创建虚拟环境\r\nmkvirtualenv venv　\r\n\r\n查看已经创建过的虚拟环境\r\nworkon\r\n\r\n启动虚拟环境\r\nworkon venv\r\n\r\n退出虚拟环境\r\nDeactivate\r\n\r\n删除虚拟环境\r\nrmvirtualenv venv', '/static/images/summary.jpg', '2019-03-02 14:18:07', '2019-03-02 14:18:07', '15', '133', '1', '1', '0');

-- ----------------------------
-- Table structure for storm_article_keywords
-- ----------------------------
DROP TABLE IF EXISTS `storm_article_keywords`;
CREATE TABLE `storm_article_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storm_article_keywords_article_id_keyword_id_7510b8d6_uniq` (`article_id`,`keyword_id`),
  KEY `storm_article_keywords_keyword_id_a563777a_fk_storm_keyword_id` (`keyword_id`),
  CONSTRAINT `storm_article_keywords_article_id_5df25258_fk_storm_article_id` FOREIGN KEY (`article_id`) REFERENCES `storm_article` (`id`),
  CONSTRAINT `storm_article_keywords_keyword_id_a563777a_fk_storm_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `storm_keyword` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_article_keywords
-- ----------------------------
INSERT INTO `storm_article_keywords` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for storm_article_tags
-- ----------------------------
DROP TABLE IF EXISTS `storm_article_tags`;
CREATE TABLE `storm_article_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storm_article_tags_article_id_tag_id_c71bf3b2_uniq` (`article_id`,`tag_id`),
  KEY `storm_article_tags_tag_id_e8380d38_fk_storm_tag_id` (`tag_id`),
  CONSTRAINT `storm_article_tags_article_id_15b9f147_fk_storm_article_id` FOREIGN KEY (`article_id`) REFERENCES `storm_article` (`id`),
  CONSTRAINT `storm_article_tags_tag_id_e8380d38_fk_storm_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `storm_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_article_tags
-- ----------------------------
INSERT INTO `storm_article_tags` VALUES ('1', '1', '1');
INSERT INTO `storm_article_tags` VALUES ('2', '2', '1');
INSERT INTO `storm_article_tags` VALUES ('3', '3', '1');
INSERT INTO `storm_article_tags` VALUES ('4', '4', '1');
INSERT INTO `storm_article_tags` VALUES ('5', '5', '1');

-- ----------------------------
-- Table structure for storm_bigcategory
-- ----------------------------
DROP TABLE IF EXISTS `storm_bigcategory`;
CREATE TABLE `storm_bigcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_bigcategory
-- ----------------------------
INSERT INTO `storm_bigcategory` VALUES ('1', '生活笔记', 'life', '生活笔记');
INSERT INTO `storm_bigcategory` VALUES ('2', '技术杂谈', 'technique', '技术杂谈');
INSERT INTO `storm_bigcategory` VALUES ('3', '福利专区', 'resources', '福利专区');
INSERT INTO `storm_bigcategory` VALUES ('4', '关于自己', 'about', '关于自己');
INSERT INTO `storm_bigcategory` VALUES ('5', '给我留言', 'message', '给我留言');
INSERT INTO `storm_bigcategory` VALUES ('6', '赞助作者', 'donate', '赞助作者');
INSERT INTO `storm_bigcategory` VALUES ('7', '技术交流', 'exchange', '技术交流');
INSERT INTO `storm_bigcategory` VALUES ('8', '提问交流', 'question', '提问交流');
INSERT INTO `storm_bigcategory` VALUES ('9', '项目合作', 'project', '项目合作');

-- ----------------------------
-- Table structure for storm_carousel
-- ----------------------------
DROP TABLE IF EXISTS `storm_carousel`;
CREATE TABLE `storm_carousel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `content` varchar(80) NOT NULL,
  `img_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_carousel
-- ----------------------------
INSERT INTO `storm_carousel` VALUES ('1', '6', 'Python爬虫学习系列教程', 'Python爬虫学习系列教程', '/static/images/right1.jpg', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('2', '7', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/right2.jpg', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('3', '1', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/docker.jpg', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('4', '2', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/python-django-logo.jpg', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('5', '3', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/bsblog.png', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('6', '4', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/right3.jpg', 'http://127.0.0.1:8080/article/123/');
INSERT INTO `storm_carousel` VALUES ('7', '5', '小白学爬虫系列教程', '小白学爬虫系列教程', '/static/images/right4.jpg', 'http://127.0.0.1:8080/article/123/');

-- ----------------------------
-- Table structure for storm_category
-- ----------------------------
DROP TABLE IF EXISTS `storm_category`;
CREATE TABLE `storm_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `bigcategory_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `storm_category_bigcategory_id_aa573836_fk_storm_bigcategory_id` (`bigcategory_id`),
  CONSTRAINT `storm_category_bigcategory_id_aa573836_fk_storm_bigcategory_id` FOREIGN KEY (`bigcategory_id`) REFERENCES `storm_bigcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_category
-- ----------------------------
INSERT INTO `storm_category` VALUES ('1', 'python', 'python', 'StormSha的个人网站，记录生活的瞬间，分享学习的心得，感悟生活，留住感动，静静寻觅生活的美好', '2');

-- ----------------------------
-- Table structure for storm_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `storm_friendlink`;
CREATE TABLE `storm_friendlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `link` varchar(200) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `create_date` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_friendlink
-- ----------------------------

-- ----------------------------
-- Table structure for storm_keyword
-- ----------------------------
DROP TABLE IF EXISTS `storm_keyword`;
CREATE TABLE `storm_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_keyword
-- ----------------------------
INSERT INTO `storm_keyword` VALUES ('1', 'python');

-- ----------------------------
-- Table structure for storm_silian
-- ----------------------------
DROP TABLE IF EXISTS `storm_silian`;
CREATE TABLE `storm_silian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badurl` varchar(200) NOT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_silian
-- ----------------------------

-- ----------------------------
-- Table structure for storm_tag
-- ----------------------------
DROP TABLE IF EXISTS `storm_tag`;
CREATE TABLE `storm_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_tag
-- ----------------------------
INSERT INTO `storm_tag` VALUES ('1', 'python', 'python', 'StormSha的个人网站，记录生活的瞬间，分享学习的心得，感悟生活，留住感动，静静寻觅生活的美好');

-- ----------------------------
-- Table structure for storm_timeline
-- ----------------------------
DROP TABLE IF EXISTS `storm_timeline`;
CREATE TABLE `storm_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `side` varchar(1) NOT NULL,
  `star_num` int(11) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `icon_color` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storm_timeline
-- ----------------------------
