/*
 Navicat Premium Data Transfer

 Source Server         : wsl2
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : healing_drugs_manage_system

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 15/10/2023 11:41:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for medicine
-- ----------------------------
DROP TABLE IF EXISTS `medicine`;
CREATE TABLE `medicine`  (
  `serial_id` bigint NOT NULL COMMENT '药品的编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '药品名称',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '药品图片',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '药品描述',
  PRIMARY KEY (`serial_id`) USING BTREE,
  UNIQUE INDEX `serial`(`serial_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medicine
-- ----------------------------
INSERT INTO `medicine` VALUES (12, '青霉素', 'http://localhost:3000/file/download/1697296006593.png', '（钾盐）注射用无菌粉末：0.25g（40 万 单位）、0.5g（80 万单位） （钠盐）注射用无菌粉末：0.24g（40 万 单位）、0.48g（80 万单位）、0.96g （160 万单位）');
INSERT INTO `medicine` VALUES (15, '阿莫西林', 'http://localhost:3000/file/download/1697296089013.png', '片剂、胶囊、颗粒剂、干混悬剂： 0.125g、0.25g ');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '进出口编号',
  `serial_id` bigint NOT NULL COMMENT '药品编号',
  `import` bigint NULL DEFAULT 0 COMMENT '进口数量',
  `export` bigint NULL DEFAULT 0 COMMENT '出口数量',
  `date` datetime NOT NULL COMMENT '进出口日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id-serial_id`(`serial_id` ASC) USING BTREE,
  CONSTRAINT `id-serial_id` FOREIGN KEY (`serial_id`) REFERENCES `medicine` (`serial_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (3, 15, 68, 75, '2023-10-13 00:15:10');
INSERT INTO `record` VALUES (4, 12, 76, 78, '2023-10-14 00:15:10');
INSERT INTO `record` VALUES (5, 15, 67, 78, '2023-10-12 00:15:10');
INSERT INTO `record` VALUES (6, 12, 54, 25, '2023-10-13 00:15:10');
INSERT INTO `record` VALUES (7, 15, 564, 687, '2023-10-14 00:15:10');
INSERT INTO `record` VALUES (8, 12, 25, 24, '2023-10-13 11:15:10');
INSERT INTO `record` VALUES (9, 15, 24, 45, '2023-10-12 11:15:10');

-- ----------------------------
-- Table structure for sys
-- ----------------------------
DROP TABLE IF EXISTS `sys`;
CREATE TABLE `sys`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知内容',
  `create_time` datetime NOT NULL COMMENT '通知时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys
-- ----------------------------
INSERT INTO `sys` VALUES (15, '今天中午加鸡腿', '2023-10-14 20:14:10');
INSERT INTO `sys` VALUES (16, '今天中午加鸡腿今天中午加鸡腿', '2023-10-14 20:14:10');
INSERT INTO `sys` VALUES (17, '今天中午加鸡腿今天中午加鸡腿', '2023-10-14 20:14:10');
INSERT INTO `sys` VALUES (18, '今天中午加鸡腿今天中午加鸡腿', '2023-10-14 20:14:10');
INSERT INTO `sys` VALUES (19, '今天中午加鸡腿今天中午加鸡腿', '2023-10-14 20:14:10');
INSERT INTO `sys` VALUES (20, '今天中午加鸡腿今天中午加鸡腿', '2023-10-14 20:14:10');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '新用户' COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'http://localhost:3000/file/download/1697284393561-th.jpg' COMMENT '头像',
  `role` int NULL DEFAULT 0 COMMENT '权限',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_time` datetime NULL DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin', 'admin', 'http://localhost:3000/file/download/1697285717277-th.jpg', 1, '2023-10-05 21:38:04', '2023-10-15 11:15:10');
INSERT INTO `users` VALUES (3, 'admin1', 'admin1', '新用户', 'http://localhost:3000/file/download/1697285717277-th.jpg', 0, '2023-10-13 23:13:10', '2023-10-15 11:15:10');

SET FOREIGN_KEY_CHECKS = 1;
