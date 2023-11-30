/*
 Navicat Premium Data Transfer

 Source Server         : wsl2
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : drivingSchool

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 30/11/2023 15:22:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for form
-- ----------------------------
DROP TABLE IF EXISTS `form`;
CREATE TABLE `form`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学员名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系方式',
  `gender` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学员性别',
  `createDate` datetime NULL DEFAULT NULL,
  `date` datetime NOT NULL COMMENT '预计到校时间',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '驾照类型',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '留言',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of form
-- ----------------------------

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '题库内容',
  `anwser` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `is_correct` tinyint(1) NULL DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES (1, '在高速公路上行驶感觉疲劳时，应在下一个服务区停车休息。', '正确-错误', 0, '2023-11-30 10:26:01');
INSERT INTO `questions` VALUES (2, '小型汽车驾驶人发生交通事故造成人员死亡，承担同等以上责任未被吊销驾驶证的，应当在记分周期结束后90日内接受审验。', '正确-错误', 1, '2023-11-30 10:26:55');
INSERT INTO `questions` VALUES (3, '驾驶人违反交通运输管理法规发生重大事故后，逃逸或者有其他特别恶劣情节的，处7年以上有期徒刑。', '正确-错误', 1, '2023-11-30 10:28:23');
INSERT INTO `questions` VALUES (4, '驾驶机动车在高速公路上行驶，可以随时借用应急车道行驶、超车或停车。', '正确-错误', 1, '2023-11-30 10:29:01');
INSERT INTO `questions` VALUES (5, '驾驶机动车不按交通信号灯指示通行的，一次记3分。', '正确-错误', 1, '2023-11-30 10:29:36');
INSERT INTO `questions` VALUES (6, '驾驶机动车在道路上违反道路通行规定应当接受相应的处罚。', '正确-错误', 0, '2023-11-30 10:30:09');
INSERT INTO `questions` VALUES (7, '驾驶机动车遇高速公路收费口拥堵、较多车辆排队等侯时，驾驶人可以穿插等候车辆。', '正确-错误', 1, '2023-11-30 10:30:37');
INSERT INTO `questions` VALUES (8, '驾驶机动车下长坡时，利用惯性滑行可以减少燃油消耗，值得提倡。', '正确-错误', 1, '2023-11-30 10:31:01');
INSERT INTO `questions` VALUES (9, '在上一个记分周期内机动车驾驶人有二次以上参加满分教育记录的，可以在接受交通安全教育后扣减交通违法行为记分。', '正确-错误', 1, '2023-11-30 10:31:26');
INSERT INTO `questions` VALUES (10, '机动车在道路上发生的造成财产损失、尚未造成人员伤亡，且车辆可以移动的交通事故，必须等待交通警察处理。', '正确-错误', 1, '2023-11-30 10:32:06');
INSERT INTO `questions` VALUES (11, '驾驶机动车发生故障或事故不能正常行驶时，应立即打开危险报警闪光灯。', '正确-错误', 0, '2023-11-30 10:32:28');
INSERT INTO `questions` VALUES (12, '驾驶校车、中型以上载客载货汽车、危险品运输车辆以外的机动车在高速公路上行驶超过规定时速百分之四十的，一次记6分。', '正确-错误', 0, '2023-11-30 10:33:11');
INSERT INTO `questions` VALUES (13, '驾驶未按规定定期进行安全技术检验的公路客运汽车、旅游客运汽车、危险品运输车辆以外的机动车上路行驶的，一次记1分。', '正确-错误', 0, '2023-11-30 10:33:32');
INSERT INTO `questions` VALUES (14, '造成交通事故后逃逸构成犯罪的人不能申请机动车驾驶证。', '正确-错误', 0, '2023-11-30 10:33:55');
INSERT INTO `questions` VALUES (15, '驾驶机动车在交叉路口前变更车道时，应在进入实线区后，开启转向灯，变更车道。', '正确-错误', 1, '2023-11-30 10:34:19');
INSERT INTO `questions` VALUES (16, '机动车驾驶人使用伪造、变造的行驶证的， 一次记9分。', '正确-错误', 1, '2023-11-30 10:35:02');
INSERT INTO `questions` VALUES (17, '年龄在70周岁以上，在一个记分周期结束后一年内未提交身体条件证明的，其机动车驾驶证将会被车辆管理所注销。', '正确-错误', 0, '2023-11-30 10:35:29');
INSERT INTO `questions` VALUES (18, '驾驶人在实习期不可以单独驾驶机动车上高速公路行驶，在增加准驾车型后的实习期内，驾驶原准驾车型的机动车时不受上述限制。', '正确-错误', 0, '2023-11-30 10:35:56');
INSERT INTO `questions` VALUES (19, '驾驶机动车在道路上发生交通事故，任何情况下都应标明现场位置后，先行撤离现场。', '正确-错误', 1, '2023-11-30 10:36:30');
INSERT INTO `questions` VALUES (20, '机动车在抵押登记、质押备案期间不可以办理转移登记。', '正确-错误', 0, '2023-11-30 10:36:53');
INSERT INTO `questions` VALUES (21, '上路行驶的机动车未放置检验合格标志的，交通警察可依法扣留机动车。', '正确-错误', 0, '2023-11-30 10:40:17');
INSERT INTO `questions` VALUES (22, '驾驶机动车在没有中心线的城市道路上，最高速度不能超过每小时50公里。', '正确-错误', 1, '2023-11-30 10:40:41');
INSERT INTO `questions` VALUES (23, '驾驶不按规定安装机动车号牌的机动车上道路行驶的，一次记3分。', '正确-错误', 0, '2023-11-30 10:41:10');
INSERT INTO `questions` VALUES (24, '驾驶机动车应在变更车道的同时开启转向灯。', '正确-错误', 1, '2023-11-30 10:41:41');
INSERT INTO `questions` VALUES (25, '驾驶人可以通过互联网交通安全综合服务管理平台申请机动车驾驶证电子版。', '正确-错误', 0, '2023-11-30 10:42:06');
INSERT INTO `questions` VALUES (26, '夜间驾驶机动车通过人行横道时需要交替使用远近光灯。', '正确-错误', 0, '2023-11-30 10:42:34');
INSERT INTO `questions` VALUES (27, '驾驶不按规定安装机动车号牌的机动车上道路行驶的，一次记1分。', '正确-错误', 1, '2023-11-30 10:42:56');
INSERT INTO `questions` VALUES (28, '驾驶人持超过有效期的驾驶证可以在1年内驾驶机动车。', '正确-错误', 1, '2023-11-30 10:43:23');
INSERT INTO `questions` VALUES (29, '机动车紧急制动时，ABS系统在提供最大制动力的同时能使车前轮保持转向能力。', '正确-错误', 0, '2023-11-30 10:43:44');
INSERT INTO `questions` VALUES (30, '对发生道路交通事故需要收集证据的事故车，交通警察可以依法扣留。', '正确-错误', 0, '2023-11-30 10:44:11');
INSERT INTO `questions` VALUES (31, '驾驶机动车在路口右转弯时，应提前开启右转向灯，不受信号灯限制，不受车速限制，迅速通过，防止路口堵塞。', '正确-错误', 1, '2023-11-30 10:44:33');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '学员' COMMENT '用户昵称',
  `role` int NOT NULL DEFAULT 0 COMMENT '用户权限',
  PRIMARY KEY (`id`, `role`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin', '管理员', 1);

SET FOREIGN_KEY_CHECKS = 1;
