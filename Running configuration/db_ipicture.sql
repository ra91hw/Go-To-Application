/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : db_ipicture

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 24/03/2021 23:19:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xy_album
-- ----------------------------
DROP TABLE IF EXISTS `xy_album`;
CREATE TABLE `xy_album` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` int DEFAULT NULL COMMENT '',
  `category_id` int DEFAULT NULL COMMENT '',
  `title` varchar(255) DEFAULT NULL COMMENT '',
  `cover` varchar(255) DEFAULT NULL COMMENT '',
  `description` text COMMENT '',
  `agree_number` int DEFAULT NULL COMMENT '',
  `discuss_number` int DEFAULT NULL COMMENT '',
  `click_number` int DEFAULT NULL COMMENT '',
  `total_number` int DEFAULT NULL COMMENT '',
  `status` int DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='';

-- ----------------------------
-- Records of xy_album
-- ----------------------------
BEGIN;
INSERT INTO `xy_album` VALUES (13, 6, 1, 'Deers in the forest', '/ipicimg/album/cover/6fe1ffe17d5d4c5892a08543135921bc.jpg', 'Deers in the forest', 1, 2, 6, 3, 0, '2021-03-25 07:06:50', '2021-03-25 07:08:28');
COMMIT;

-- ----------------------------
-- Table structure for xy_album_image
-- ----------------------------
DROP TABLE IF EXISTS `xy_album_image`;
CREATE TABLE `xy_album_image` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `album_id` int DEFAULT NULL COMMENT '',
  `album_image` varchar(255) DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='';

-- ----------------------------
-- Records of xy_album_image
-- ----------------------------
BEGIN;
INSERT INTO `xy_album_image` VALUES (25, 13, '/ipicimg/album/3185bf42bdc148689559609aa97d10a2.jpg', '2021-03-25 07:08:28', '2021-03-25 07:08:28');
INSERT INTO `xy_album_image` VALUES (26, 13, '/ipicimg/album/9c06b20bebef494fbb5e62cff01d7b4c.png', '2021-03-25 07:08:28', '2021-03-25 07:08:28');
INSERT INTO `xy_album_image` VALUES (27, 13, '/ipicimg/album/036a4e1ed1794ac2aa0b0991d470f94a.png', '2021-03-25 07:08:28', '2021-03-25 07:08:28');
COMMIT;

-- ----------------------------
-- Table structure for xy_banner
-- ----------------------------
DROP TABLE IF EXISTS `xy_banner`;
CREATE TABLE `xy_banner` (
  `id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_banner
-- ----------------------------
BEGIN;
INSERT INTO `xy_banner` VALUES (1, 'Forest', '/ipicimg/banner/cf8c22a933224be894af7c5c5423436b.jpg', 'http://localhost:8080/album/piclist.html?id=12', 1, '2021-03-20 14:13:24', '2021-03-25 06:44:32');
INSERT INTO `xy_banner` VALUES (2, 'Ocean', '/ipicimg/banner/5c075d3e5adf48dd87fe63686e85d3ff.png', 'http://localhost:8080/album/piclist.html?id=11', 1, '2020-03-20 18:44:59', '2021-03-25 06:45:02');
INSERT INTO `xy_banner` VALUES (3, 'Skyline', '/ipicimg/banner/d8faadbd80ed4e40b772268ce98fd798.jpeg', 'http://localhost:8080/album/piclist.html?id=10', 1, '2020-03-20 18:44:33', '2021-03-25 06:46:45');
INSERT INTO `xy_banner` VALUES (4, 'Join us and Share your Photos', '/ipicimg/banner/473912b766054db2a6c2c615008d683b.jpg', 'http://localhost:8080/album/piclist.html?id=1', 1, '2020-03-20 18:41:51', '2021-03-25 06:47:22');
COMMIT;

-- ----------------------------
-- Table structure for xy_category
-- ----------------------------
DROP TABLE IF EXISTS `xy_category`;
CREATE TABLE `xy_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `name` varchar(20) DEFAULT NULL COMMENT '',
  `description` varchar(40) DEFAULT NULL COMMENT '',
  `sort` int DEFAULT NULL COMMENT '',
  `icon` varchar(50) DEFAULT NULL COMMENT '',
  `status` int DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='';

-- ----------------------------
-- Records of xy_category
-- ----------------------------
BEGIN;
INSERT INTO `xy_category` VALUES (1, 'Forest', 'Forest', 1, '', 1, '2021-03-19 11:34:22', '2021-03-25 06:39:32');
INSERT INTO `xy_category` VALUES (2, 'Ocean', 'Ocean', 1, '', 1, '2021-03-19 11:35:00', '2021-03-25 06:39:23');
INSERT INTO `xy_category` VALUES (3, 'Skyline', '', 3, '', 1, '2021-03-19 12:52:30', '2021-03-25 06:40:49');
INSERT INTO `xy_category` VALUES (4, 'Animals', 'Animals', 4, '', 1, '2021-03-19 12:54:52', '2021-03-25 06:41:41');
COMMIT;

-- ----------------------------
-- Table structure for xy_discuss
-- ----------------------------
DROP TABLE IF EXISTS `xy_discuss`;
CREATE TABLE `xy_discuss` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `album_id` int DEFAULT NULL COMMENT '',
  `user_id` int DEFAULT NULL COMMENT '',
  `pid` int DEFAULT NULL COMMENT '',
  `content` varchar(255) DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='';

-- ----------------------------
-- Records of xy_discuss
-- ----------------------------
BEGIN;
INSERT INTO `xy_discuss` VALUES (5, 13, 6, 0, 'Good job!', '2021-03-25 07:10:16', '2021-03-25 07:10:16');
COMMIT;

-- ----------------------------
-- Table structure for xy_like
-- ----------------------------
DROP TABLE IF EXISTS `xy_like`;
CREATE TABLE `xy_like` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` int DEFAULT NULL COMMENT '',
  `album_id` int DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_like
-- ----------------------------
BEGIN;
INSERT INTO `xy_like` VALUES (1, 2, 8, '2020-07-31 14:05:17', '2020-07-31 14:05:17');
INSERT INTO `xy_like` VALUES (2, 2, 9, '2020-07-31 14:46:26', '2020-07-31 14:46:26');
INSERT INTO `xy_like` VALUES (3, 2, 7, '2020-08-01 11:06:51', '2020-08-01 11:06:51');
INSERT INTO `xy_like` VALUES (4, 6, 13, '2021-03-25 07:10:26', '2021-03-25 07:10:26');
COMMIT;

-- ----------------------------
-- Table structure for xy_link
-- ----------------------------
DROP TABLE IF EXISTS `xy_link`;
CREATE TABLE `xy_link` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `title` varchar(32) DEFAULT NULL COMMENT '',
  `link` varchar(255) DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_link
-- ----------------------------
BEGIN;
INSERT INTO `xy_link` VALUES (2, 'Instagram', 'https://www.instagram.com', '2019-01-17 16:59:51', '2021-03-25 07:02:59');
INSERT INTO `xy_link` VALUES (3, 'Facebook', 'https://www.facebook.com', '2019-02-15 12:18:19', '2021-03-25 07:01:59');
INSERT INTO `xy_link` VALUES (4, 'Twitter', 'https://twitter.com', '2019-02-15 12:19:48', '2021-03-25 07:01:00');
COMMIT;

-- ----------------------------
-- Table structure for xy_notice
-- ----------------------------
DROP TABLE IF EXISTS `xy_notice`;
CREATE TABLE `xy_notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `title` varchar(255) DEFAULT NULL COMMENT '',
  `content` text COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_notice
-- ----------------------------
BEGIN;
INSERT INTO `xy_notice` VALUES (1, 'JOIN US！', '<p>JOIN US AND SHARE YOUR PHOTOS！</p>', '2021-03-20 16:36:31', '2021-03-20 16:36:31');
COMMIT;

-- ----------------------------
-- Table structure for xy_user
-- ----------------------------
DROP TABLE IF EXISTS `xy_user`;
CREATE TABLE `xy_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '',
  `username` varchar(64) DEFAULT NULL COMMENT '',
  `nickname` varchar(64) DEFAULT NULL COMMENT '',
  `password` varchar(64) DEFAULT NULL COMMENT '',
  `telphone` varchar(32) DEFAULT NULL COMMENT '',
  `email` varchar(32) DEFAULT NULL COMMENT '',
  `avatar` varchar(512) DEFAULT NULL COMMENT '',
  `school` varchar(64) DEFAULT NULL COMMENT '',
  `professional` varchar(128) DEFAULT NULL COMMENT '',
  `introduce` text COMMENT '',
  `type` int DEFAULT NULL COMMENT '',
  `visit_number` int DEFAULT NULL COMMENT '',
  `status` int DEFAULT NULL COMMENT '',
  `create_time` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_user
-- ----------------------------
BEGIN;
INSERT INTO `xy_user` VALUES (1, 'admin', 'admin', '1', '', '', '/static/images/avatar.jpg', NULL, NULL, NULL, 1, 0, 1, '2021-03-04 21:29:39', '2021-03-04 21:29:39');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
