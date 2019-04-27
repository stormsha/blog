/*
Navicat MySQL Data Transfer

Source Server         : 118.89.244.82
Source Server Version : 50725
Source Host           : 118.89.244.82:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-04-27 19:14:49
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
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `user_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_emailconfirmation
-- ----------------------------
DROP TABLE IF EXISTS `account_emailconfirmation`;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirmation_email_address_id_5b7f8c58_fk` (`email_address_id`),
  CONSTRAINT `account_emailconfirmation_email_address_id_5b7f8c58_fk` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for comment_aboutcomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_aboutcomment`;
CREATE TABLE `comment_aboutcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comment_articlecomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_articlecomment`;
CREATE TABLE `comment_articlecomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `author_id` int(11) NOT NULL,
  `belong_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `rep_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_articlecomme_author_id_46e6fdb8_fk_comment_c` (`author_id`),
  KEY `comment_articlecomment_belong_id_58e0232c_fk_storm_article_id` (`belong_id`),
  KEY `comment_articlecomme_parent_id_f0ab594d_fk_comment_a` (`parent_id`),
  KEY `comment_articlecomme_rep_to_id_84dab3d5_fk_comment_a` (`rep_to_id`),
  CONSTRAINT `comment_articlecomme_author_id_46e6fdb8_fk_comment_c` FOREIGN KEY (`author_id`) REFERENCES `comment_commentuser` (`id`),
  CONSTRAINT `comment_articlecomme_parent_id_f0ab594d_fk_comment_a` FOREIGN KEY (`parent_id`) REFERENCES `comment_articlecomment` (`id`),
  CONSTRAINT `comment_articlecomme_rep_to_id_84dab3d5_fk_comment_a` FOREIGN KEY (`rep_to_id`) REFERENCES `comment_articlecomment` (`id`),
  CONSTRAINT `comment_articlecomment_belong_id_58e0232c_fk_storm_article_id` FOREIGN KEY (`belong_id`) REFERENCES `storm_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comment_messagecomment
-- ----------------------------
DROP TABLE IF EXISTS `comment_messagecomment`;
CREATE TABLE `comment_messagecomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `content` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
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
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `user_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for socialaccount_socialaccount
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialaccount`;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_ouser_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_ouser_id` FOREIGN KEY (`user_id`) REFERENCES `user_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for socialaccount_socialtoken
-- ----------------------------
DROP TABLE IF EXISTS `socialaccount_socialtoken`;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for storm_activate
-- ----------------------------
DROP TABLE IF EXISTS `storm_activate`;
CREATE TABLE `storm_activate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext,
  `is_active` tinyint(1) NOT NULL,
  `add_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `views` int(11) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `loves` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `storm_article_author_id_113892f7_fk_oauth_ouser_id` (`author_id`),
  KEY `storm_article_category_id_c56e32c4_fk_storm_category_id` (`category_id`),
  CONSTRAINT `storm_article_author_id_113892f7_fk_oauth_ouser_id` FOREIGN KEY (`author_id`) REFERENCES `user_ouser` (`id`),
  CONSTRAINT `storm_article_category_id_c56e32c4_fk_storm_category_id` FOREIGN KEY (`category_id`) REFERENCES `storm_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for storm_bigcategory
-- ----------------------------
DROP TABLE IF EXISTS `storm_bigcategory`;
CREATE TABLE `storm_bigcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `keywords` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
  `create_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for storm_keyword
-- ----------------------------
DROP TABLE IF EXISTS `storm_keyword`;
CREATE TABLE `storm_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for storm_silian
-- ----------------------------
DROP TABLE IF EXISTS `storm_silian`;
CREATE TABLE `storm_silian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badurl` varchar(200) NOT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `add_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
  `update_date` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_ouser
-- ----------------------------
DROP TABLE IF EXISTS `user_ouser`;
CREATE TABLE `user_ouser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `link` varchar(200) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_ouser_groups
-- ----------------------------
DROP TABLE IF EXISTS `user_ouser_groups`;
CREATE TABLE `user_ouser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ouser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_ouser_groups_ouser_id_group_id_4a9e5409_uniq` (`ouser_id`,`group_id`),
  KEY `oauth_ouser_groups_group_id_ee861e08_fk_auth_group_id` (`group_id`),
  CONSTRAINT `oauth_ouser_groups_group_id_ee861e08_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `oauth_ouser_groups_ouser_id_c543bcdc_fk_oauth_ouser_id` FOREIGN KEY (`ouser_id`) REFERENCES `user_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_ouser_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `user_ouser_user_permissions`;
CREATE TABLE `user_ouser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ouser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_ouser_user_permiss_ouser_id_permission_id_ab6b2ccc_uniq` (`ouser_id`,`permission_id`),
  KEY `oauth_ouser_user_per_permission_id_2b5b927f_fk_auth_perm` (`permission_id`),
  CONSTRAINT `oauth_ouser_user_per_permission_id_2b5b927f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `oauth_ouser_user_permissions_ouser_id_12e23549_fk_oauth_ouser_id` FOREIGN KEY (`ouser_id`) REFERENCES `user_ouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
