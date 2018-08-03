/*
Navicat MySQL Data Transfer

Source Server         : 172.17.10.111
Source Server Version : 50628
Source Host           : 172.17.10.111:3306
Source Database       : tianzhi-light-prototype

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-10-25 10:19:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cloud_course
-- ----------------------------
DROP TABLE IF EXISTS `cloud_course`;
CREATE TABLE `cloud_course` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `year` int(4) DEFAULT NULL,
  `term` int(2) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `run_id` bigint(20) DEFAULT NULL,
  `run_state` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_course
-- ----------------------------
INSERT INTO `cloud_course` VALUES ('10000044820000', '2011', '3', null, null, null, null, null);
INSERT INTO `cloud_course` VALUES ('10000044830000', '2016', '4', null, null, null, null, null);
INSERT INTO `cloud_course` VALUES ('10000044860000', '214214', '124124', null, null, null, null, null);

-- ----------------------------
-- Table structure for cloud_course_item
-- ----------------------------
DROP TABLE IF EXISTS `cloud_course_item`;
CREATE TABLE `cloud_course_item` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `course_id` bigint(20) DEFAULT NULL,
  `course_name` varchar(20) DEFAULT NULL,
  `course_teacher` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_course_item
-- ----------------------------
INSERT INTO `cloud_course_item` VALUES ('10000044820001', '10000044820000', 'ffffffff', 'shi ');
INSERT INTO `cloud_course_item` VALUES ('10000044820002', '10000044820000', 'gggggg', 'wei ');
INSERT INTO `cloud_course_item` VALUES ('10000044830001', '10000044830000', '数学', '张三');
INSERT INTO `cloud_course_item` VALUES ('10000044830002', '10000044830000', '语文', '李四');
INSERT INTO `cloud_course_item` VALUES ('10000044830003', '10000044830000', '英语', '王五');
INSERT INTO `cloud_course_item` VALUES ('10000044830004', '10000044830000', '体育', '赵六');
INSERT INTO `cloud_course_item` VALUES ('10000044860001', '10000044860000', '2424', '2222');
INSERT INTO `cloud_course_item` VALUES ('10000044860002', '10000044860000', '555', '3555');

-- ----------------------------
-- Table structure for cloud_saas_form
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_form`;
CREATE TABLE `cloud_saas_form` (
  `id` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL COMMENT '公司Id',
  `srcUrl` varchar(200) DEFAULT NULL COMMENT '源Url',
  `transferUrl` varchar(200) DEFAULT NULL COMMENT '转化Url',
  `state` varchar(20) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_saas_form
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_saas_res
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_res`;
CREATE TABLE `cloud_saas_res` (
  `saas_res_id` bigint(32) NOT NULL DEFAULT '0' COMMENT 'ID',
  `res_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`saas_res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_saas_res
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_saas_role
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_role`;
CREATE TABLE `cloud_saas_role` (
  `saas_role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `role_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '角色名',
  `role_alias` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '角色别名',
  `role_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '角色类型：集团、经销商、服务商、采购商等',
  `memo` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`saas_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_saas_role
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_saas_role_res
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_role_res`;
CREATE TABLE `cloud_saas_role_res` (
  `saasRoleResId` bigint(32) NOT NULL COMMENT '角色资源Id',
  `roleId` bigint(20) DEFAULT NULL,
  `resId` bigint(20) DEFAULT NULL COMMENT '资源主键',
  `tenantId` bigint(20) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`saasRoleResId`),
  KEY `IDX_ROLERES_RESID` (`resId`) USING BTREE,
  KEY `IDX_ROLERES_ROLEID` (`roleId`) USING BTREE,
  CONSTRAINT `cloud_saas_role_res_ibfk_1` FOREIGN KEY (`resId`) REFERENCES `sys_res1` (`resId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色资源映射';

-- ----------------------------
-- Records of cloud_saas_role_res
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_saas_user_role
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_user_role`;
CREATE TABLE `cloud_saas_user_role` (
  `SaasUserRoleId` bigint(20) NOT NULL COMMENT '用户角色Id',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `tenantId` bigint(20) DEFAULT NULL COMMENT '租户Id',
  PRIMARY KEY (`SaasUserRoleId`),
  KEY `FK_SYS_ROLE_R_USR_ROLE` (`roleId`) USING BTREE,
  KEY `FK_USER_ROLE_R_SYS_USER` (`userId`) USING BTREE,
  CONSTRAINT `cloud_saas_user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户角色映射表';

-- ----------------------------
-- Records of cloud_saas_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_saas_workflow
-- ----------------------------
DROP TABLE IF EXISTS `cloud_saas_workflow`;
CREATE TABLE `cloud_saas_workflow` (
  `id` bigint(20) NOT NULL,
  `entid` bigint(20) DEFAULT NULL,
  `entname` varchar(200) DEFAULT NULL,
  `flowtype` varchar(20) DEFAULT NULL,
  `flowkey` varchar(200) DEFAULT NULL,
  `flowname` varchar(200) DEFAULT NULL,
  `remake` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_saas_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for contract_info
-- ----------------------------
DROP TABLE IF EXISTS `contract_info`;
CREATE TABLE `contract_info` (
  `id` bigint(20) NOT NULL,
  `cont_code` varchar(64) DEFAULT NULL,
  `cont_name` varchar(100) DEFAULT NULL,
  `intr_code` varchar(64) DEFAULT NULL,
  `property` int(11) DEFAULT NULL,
  `cont_attri` int(11) DEFAULT NULL,
  `is_space_eng` int(11) DEFAULT NULL,
  `ind_plate` int(11) DEFAULT NULL,
  `ind_field` int(11) DEFAULT NULL,
  `BELONG_PROJECT` varchar(150) DEFAULT NULL,
  `bus_attri` int(11) DEFAULT NULL,
  `pur_unit` varchar(128) DEFAULT NULL,
  `taxpayer_code` varchar(128) DEFAULT NULL,
  `bus_type` int(11) DEFAULT NULL,
  `securitylevel` int(11) DEFAULT NULL,
  `sing_date` date DEFAULT NULL,
  `parta_region` varchar(50) DEFAULT NULL,
  `parta_unit_name` varchar(100) DEFAULT NULL,
  `parta_representor` varchar(20) DEFAULT NULL,
  `parta_entrustor` varchar(20) DEFAULT NULL,
  `parta_address` varchar(100) DEFAULT NULL,
  `parta_postal_code` varchar(10) DEFAULT NULL,
  `parta_phone` varchar(20) DEFAULT NULL,
  `parta_fax` varchar(12) DEFAULT NULL,
  `parta_bank_name` varchar(50) DEFAULT NULL,
  `parta_account_name` varchar(50) DEFAULT NULL,
  `parta_account_code` varchar(30) DEFAULT NULL,
  `partb_region` varchar(50) DEFAULT NULL,
  `partb_unit_name` varchar(100) DEFAULT NULL,
  `partb_representor` varchar(20) DEFAULT NULL,
  `partb_entrustor` varchar(20) DEFAULT NULL,
  `partb_address` varchar(100) DEFAULT NULL,
  `partb_postal_code` varchar(10) DEFAULT NULL,
  `partb_phone` varchar(20) DEFAULT NULL,
  `partb_fax` varchar(12) DEFAULT NULL,
  `partb_bank_name` varchar(50) DEFAULT NULL,
  `partb_account_name` varchar(50) DEFAULT NULL,
  `partb_account_code` varchar(30) DEFAULT NULL,
  `partc_unit_name` varchar(100) DEFAULT NULL,
  `partc_user_name` varchar(20) DEFAULT NULL,
  `is_pay_points` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `cont_amount` double(18,7) DEFAULT NULL,
  `cont_paid_amount` double(18,7) DEFAULT NULL,
  `cont_status` int(11) DEFAULT '1',
  `old_cont_status` int(11) DEFAULT NULL,
  `cont_type` int(11) DEFAULT NULL,
  `source_id` double DEFAULT NULL,
  `create_user_id` double DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `confirm_user_id` double DEFAULT NULL,
  `confirm_time` date DEFAULT NULL,
  `confirm_opinion` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `parta_unit_id` double DEFAULT NULL,
  `partb_unit_id` double DEFAULT NULL,
  `clause_a` varchar(500) DEFAULT NULL,
  `clause_b` varchar(500) DEFAULT NULL,
  `clause_c` varchar(500) DEFAULT NULL,
  `clause_d` varchar(500) DEFAULT NULL,
  `clause_e` varchar(500) DEFAULT NULL,
  `clause_f` varchar(500) DEFAULT NULL,
  `clause_g` varchar(500) DEFAULT NULL,
  `clause_h` varchar(500) DEFAULT NULL,
  `clause_i` varchar(500) DEFAULT NULL,
  `clause_j` varchar(500) DEFAULT NULL,
  `clause_k` varchar(500) DEFAULT NULL,
  `clause_l` varchar(500) DEFAULT NULL,
  `clause_m` varchar(500) DEFAULT NULL,
  `clause_n` varchar(500) DEFAULT NULL,
  `clause_o` varchar(500) DEFAULT NULL,
  `clause_p` varchar(500) DEFAULT NULL,
  `clause_r` varchar(500) DEFAULT NULL,
  `clause_s` varchar(500) DEFAULT NULL,
  `parta_org_code` varchar(64) DEFAULT NULL,
  `partb_org_code` varchar(64) DEFAULT NULL,
  `militaryname` varchar(64) DEFAULT NULL,
  `supplyunitname` varchar(64) DEFAULT NULL,
  `supplyunitaddress` varchar(64) DEFAULT NULL,
  `memo` varchar(500) DEFAULT NULL,
  `clause_q` varchar(500) DEFAULT NULL,
  `run_id` double DEFAULT NULL,
  `old_cont_id` double DEFAULT NULL,
  `inquiry_id` double DEFAULT NULL,
  `quote_id` double DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `proca_status` int(11) DEFAULT NULL,
  `procb_status` int(11) DEFAULT NULL,
  `runa_id` double DEFAULT NULL,
  `runb_id` double DEFAULT NULL,
  `stop_run_id` double DEFAULT NULL,
  `origin_cont_id` double DEFAULT NULL,
  `TARGET_NAME` varchar(64) DEFAULT NULL,
  `support_case` int(11) DEFAULT NULL,
  `parta_assess_flag` int(11) DEFAULT '0',
  `partb_assess_flag` int(11) DEFAULT '0',
  `count_a_last` int(11) DEFAULT NULL,
  `cont_end_date` datetime DEFAULT NULL,
  `cont_start_date` datetime DEFAULT NULL,
  `count_a_current` int(11) DEFAULT NULL,
  `count_b_last` int(11) DEFAULT NULL,
  `count_b_current` int(11) DEFAULT NULL,
  `FINISH_DATE` date DEFAULT NULL,
  `TARGET_AMOUNT` double(20,2) DEFAULT NULL,
  `signatureStatus` int(11) DEFAULT NULL COMMENT ' 电子签章状态（0：默认状态 null或者0 ；1：待签章；2：甲方已签章3：乙方已签章4：不需要签章)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contract_info
-- ----------------------------

-- ----------------------------
-- Table structure for contract_information
-- ----------------------------
DROP TABLE IF EXISTS `contract_information`;
CREATE TABLE `contract_information` (
  `id` bigint(20) NOT NULL,
  `cont_code` varchar(64) DEFAULT NULL,
  `cont_name` varchar(100) DEFAULT NULL,
  `Money` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contract_information
-- ----------------------------

-- ----------------------------
-- Table structure for demo_student
-- ----------------------------
DROP TABLE IF EXISTS `demo_student`;
CREATE TABLE `demo_student` (
  `student_id` bigint(32) NOT NULL COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `sex` int(2) DEFAULT NULL COMMENT '性别',
  `honor` varchar(32) DEFAULT NULL COMMENT '爱好',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_student
-- ----------------------------

-- ----------------------------
-- Table structure for demo_student_item
-- ----------------------------
DROP TABLE IF EXISTS `demo_student_item`;
CREATE TABLE `demo_student_item` (
  `item_id` bigint(32) NOT NULL COMMENT '主键',
  `course_id` bigint(32) DEFAULT NULL COMMENT '课程ID',
  `student_id` bigint(32) DEFAULT NULL COMMENT '学生ID',
  `remark` varchar(32) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_student_item
-- ----------------------------

-- ----------------------------
-- Table structure for sys_audit
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit`;
CREATE TABLE `sys_audit` (
  `auditId` bigint(20) NOT NULL,
  `opName` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作名称',
  `exeTime` datetime DEFAULT NULL COMMENT '执行时间',
  `executorId` bigint(20) DEFAULT NULL COMMENT '执行人ID',
  `executor` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '执行人',
  `fromIp` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IP',
  `exeMethod` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '执行方法',
  `requestURI` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '请求URL',
  `reqParams` text COLLATE utf8_unicode_ci COMMENT '请求参数',
  `tenantId` bigint(20) DEFAULT NULL,
  `tenantName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resultState` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`auditId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sys_audit
-- ----------------------------

-- ----------------------------
-- Table structure for sys_datasource
-- ----------------------------
DROP TABLE IF EXISTS `sys_datasource`;
CREATE TABLE `sys_datasource` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '数据源名称',
  `alias` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '别名',
  `driverName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '驱动名称',
  `url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '数据库URL',
  `userName` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '密码',
  `dbType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统数据源管理';

-- ----------------------------
-- Records of sys_datasource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_db_id
-- ----------------------------
DROP TABLE IF EXISTS `sys_db_id`;
CREATE TABLE `sys_db_id` (
  `id` smallint(6) NOT NULL COMMENT '计算机编号',
  `incremental` int(11) DEFAULT NULL COMMENT 'ID增量',
  `bound` bigint(20) DEFAULT NULL COMMENT '边界值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统ID生成表';

-- ----------------------------
-- Records of sys_db_id
-- ----------------------------
INSERT INTO `sys_db_id` VALUES ('1', '10000', '44870000');
INSERT INTO `sys_db_id` VALUES ('2', '10000', '5080000');
INSERT INTO `sys_db_id` VALUES ('3', '10000', '570000');

-- ----------------------------
-- Table structure for sys_db_orgid
-- ----------------------------
DROP TABLE IF EXISTS `sys_db_orgid`;
CREATE TABLE `sys_db_orgid` (
  `id` smallint(6) NOT NULL COMMENT '计算机编号',
  `incremental` int(11) DEFAULT NULL COMMENT 'ID增量',
  `bound` bigint(20) DEFAULT NULL COMMENT '边界值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统ID生成表';

-- ----------------------------
-- Records of sys_db_orgid
-- ----------------------------
INSERT INTO `sys_db_orgid` VALUES ('1', '10000', '2340300');
INSERT INTO `sys_db_orgid` VALUES ('2', '10000', '160000');

-- ----------------------------
-- Table structure for sys_demension
-- ----------------------------
DROP TABLE IF EXISTS `sys_demension`;
CREATE TABLE `sys_demension` (
  `demId` bigint(20) NOT NULL COMMENT '维度编号',
  `demName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '维度名称',
  `demDesc` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '维度描述',
  PRIMARY KEY (`demId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SYS_DEMENSION';

-- ----------------------------
-- Records of sys_demension
-- ----------------------------
INSERT INTO `sys_demension` VALUES ('1', '行政维度', '行政维度');

-- ----------------------------
-- Table structure for sys_dep_pos
-- ----------------------------
DROP TABLE IF EXISTS `sys_dep_pos`;
CREATE TABLE `sys_dep_pos` (
  `orgId` bigint(20) NOT NULL,
  `posId` bigint(20) NOT NULL,
  PRIMARY KEY (`orgId`,`posId`),
  KEY `FK_SYS_POS_R_DEP_POS` (`posId`) USING BTREE,
  CONSTRAINT `sys_dep_pos_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `sys_org` (`orgId`) ON DELETE CASCADE,
  CONSTRAINT `sys_dep_pos_ibfk_2` FOREIGN KEY (`posId`) REFERENCES `sys_position` (`posId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sys_dep_pos
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dic
-- ----------------------------
DROP TABLE IF EXISTS `sys_dic`;
CREATE TABLE `sys_dic` (
  `dicId` bigint(20) NOT NULL,
  `typeId` bigint(20) DEFAULT NULL COMMENT '分类ID',
  `itemKey` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '项Key',
  `itemName` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '项名',
  `itemValue` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '项值',
  `descp` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `sn` bigint(20) DEFAULT NULL COMMENT '序号',
  `nodePath` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`dicId`),
  KEY `FK_SYSDIC_R_SYSGTYPE` (`typeId`) USING BTREE,
  CONSTRAINT `sys_dic_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `sys_gl_type` (`typeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dic
-- ----------------------------

-- ----------------------------
-- Table structure for sys_gl_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_gl_type`;
CREATE TABLE `sys_gl_type` (
  `typeId` bigint(20) NOT NULL,
  `typeName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '分类名称',
  `nodePath` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '路径',
  `depth` int(11) NOT NULL COMMENT '层次',
  `parentId` bigint(20) DEFAULT NULL COMMENT '父节点',
  `catKey` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '分类Key',
  `nodeKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '节点的分类Key',
  `sn` bigint(20) NOT NULL COMMENT '序号',
  `userId` bigint(20) DEFAULT NULL COMMENT '所属用户\r\n            当为空则代表为公共分类',
  `depId` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '类型\r\n            (0平铺\r\n            ,1树形)',
  `isLeaf` smallint(6) DEFAULT NULL COMMENT '1=是\r\n            0=否',
  `nodeCode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '子编码',
  `nodeCodeType` smallint(6) DEFAULT NULL COMMENT '子编码类型：0手工录入，1自动生成',
  `tenantId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='总分类表\r\n用于显示树层次结构的分类\r\n可以允许任何层次结构';

-- ----------------------------
-- Records of sys_gl_type
-- ----------------------------
INSERT INTO `sys_gl_type` VALUES ('100', '行业隐藏类', '2.100.', '1', '2', 'DIC', 'hylx_yc', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000000180001', '国家', '2.10000000180001.', '1', '2', 'DIC', 'COUNTRY', '0', '0', '0', '1', '0', '1000', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000000270001', '表单字段复制', '3.10000000270001.', '1', '3', 'FLOW_TYPE', 'copy', '0', '0', '0', '1', '1', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000000280575', '币种', '2.10000000280575.', '1', '2', 'DIC', 'currency_type', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000000280579', '运费承担方', '2.10000000280579.', '1', '2', 'DIC', '运费承担方', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000001040001', '节点人员设置', '3.10000001040001.', '1', '3', 'FLOW_TYPE', 'nodeuserset', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000001120001', '协同服务', '3.10000001120001.', '1', '3', 'FLOW_TYPE', 'AFTERSALE', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000001460269', '协同采购', '3.10000001460269.', '1', '3', 'FLOW_TYPE', 'purchase', '0', '0', '0', '1', '1', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000002130001', '协同生产', '3.10000002130001.', '1', '3', 'FLOW_TYPE', 'manufacture', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000003470025', '主营行业', '2.10000003470025.', '1', '2', 'DIC', 'industry', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000003990001', '国旗', '2.10000003990001.', '1', '2', 'DIC', 'flaglogo', '0', '0', '0', '0', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000004920001', '协同营销', '3.10000004920001.', '1', '3', 'FLOW_TYPE', 'sale', '0', '0', '0', '1', '1', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005420003', '企业类型', '2.10000005420003.', '1', '2', 'DIC', 'type', '0', '0', '0', '1', '0', '1000001', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005510001', '经营范围', '2.10000005510001.', '1', '2', 'DIC', 'manage_range', '0', '0', '0', '1', '0', '1002', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005610078', '销售区域', '2.10000005610078.', '1', '2', 'DIC', 'sell_area', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005640295', '年营业额', '2.10000005640295.', '1', '2', 'DIC', 'turnover', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005680006', '企业规模', '2.10000005680006.', '1', '2', 'DIC', 'scale', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005780001', '经营类型', '2.10000005780001.', '1', '2', 'DIC', 'model', '0', '0', '0', '1', '1', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000005960001', '资质证书分类', '2.10000005960001.', '1', '2', 'DIC', 'zzzsfl', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000007360005', '服务报表', '1.10000007360005.', '1', '1', 'REPORT_TYPE', 'REPORT_AFTERSALE', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000007540009', '物流管理', '3.10000007540009.', '1', '3', 'FLOW_TYPE', 'ship_management', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000008450112', '协同研发', '3.10000008450112.', '1', '3', 'FLOW_TYPE', 'xtyf', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000010570022', '物品计量单位', '2.10000010570022.', '1', '2', 'DIC', 'wpjldw', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000011450023', '专业学科分类', '2.10000011450023.', '1', '2', 'DIC', 'zyxkfl', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000011960004', '资质项', '2.10000011960004.', '1', '2', 'DIC', 'qua', '0', '0', '0', '1', '0', '', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000020070088', '支付方式', '2.10000020070088.', '1', '2', 'DIC', 'zffs', '0', '0', '0', '0', '0', 'zffs', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000020070112', '票据要求', '2.10000020070112.', '1', '2', 'DIC', 'pjyq', '0', '0', '0', '0', '0', 'pjyq', '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000021091367', '我的类1', '6.10000021091367.', '1', '6', 'FILE_TYPE', 'wdl1', '0', '10000019980175', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000025280002', 'd', '3.10000000270001.10000025280002.', '2', '10000000270001', 'FLOW_TYPE', 'dd', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000027530125', '金兰流程', '3.10000001460269.10000027530125.', '2', '10000001460269', 'FLOW_TYPE', 'jllc', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('10000027530151', '合同审批', '3.10000001460269.10000027530151.', '2', '10000001460269', 'FLOW_TYPE', 'htsp', '0', '0', '0', '1', '0', null, '0', null);
INSERT INTO `sys_gl_type` VALUES ('20000002810438', '订单批发', '3.10000004920001.20000002810438.', '2', '10000004920001', 'FLOW_TYPE', 'ddpf', '0', '0', '0', '1', '0', null, '0', null);

-- ----------------------------
-- Table structure for sys_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_group`;
CREATE TABLE `sys_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupType` varchar(255) DEFAULT '',
  `entId` bigint(20) DEFAULT NULL,
  `entName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_group
-- ----------------------------

-- ----------------------------
-- Table structure for sys_identity
-- ----------------------------
DROP TABLE IF EXISTS `sys_identity`;
CREATE TABLE `sys_identity` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '名称',
  `alias` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '别名',
  `regulation` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '规则',
  `genEveryDay` smallint(6) DEFAULT NULL COMMENT '每天生成',
  `noLength` int(11) DEFAULT NULL COMMENT '流水号长度',
  `curDate` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `initValue` int(11) DEFAULT NULL COMMENT '初始值',
  `curValue` int(11) DEFAULT NULL COMMENT '当前值',
  `step` smallint(6) DEFAULT NULL COMMENT '步长',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='流水号生成';

-- ----------------------------
-- Records of sys_identity
-- ----------------------------

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message` (
  `messageId` bigint(20) NOT NULL COMMENT '主键',
  `subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主题',
  `receiver` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '接收人',
  `copyTo` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操送',
  `bcc` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '秘密操送',
  `fromUser` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '发送人',
  `templateId` bigint(20) DEFAULT NULL COMMENT '模版ID',
  `messageType` int(11) DEFAULT NULL COMMENT '消息类型\r\n            1;邮件信息\r\n            2;手机短信\r\n            3;内部消息',
  `SENDTOSTARTUSER` smallint(6) DEFAULT NULL,
  `CONTENT` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '消息内容',
  PRIMARY KEY (`messageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='设置待发送的消息可供流程或节点使用';

-- ----------------------------
-- Records of sys_message
-- ----------------------------

-- ----------------------------
-- Table structure for sys_message_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_log`;
CREATE TABLE `sys_message_log` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主题',
  `sendTime` datetime DEFAULT NULL COMMENT '发送时间',
  `receiver` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '接收者 （多个人用，分隔）',
  `messageType` int(11) DEFAULT NULL COMMENT '消息类型\r\n            1;邮件信息\r\n            2;手机短信\r\n            3;内部消息',
  `state` int(11) DEFAULT NULL COMMENT '发送状态 \r\n            1:成功\r\n            0:不成功',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='消息日志';

-- ----------------------------
-- Records of sys_message_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_read`;
CREATE TABLE `sys_msg_read` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `messageId` bigint(20) DEFAULT NULL COMMENT '消息ID',
  `receiverId` bigint(20) DEFAULT NULL COMMENT '接收人Id',
  `receiver` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '接收人',
  `receiveTime` datetime DEFAULT NULL COMMENT '接收时间',
  PRIMARY KEY (`id`),
  KEY `IDX_MSGREAD_RECEIVERID` (`receiverId`) USING BTREE,
  KEY `IDX_MSGREAD_MESSAGEID` (`messageId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='接收状态';

-- ----------------------------
-- Records of sys_msg_read
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_receiver
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_receiver`;
CREATE TABLE `sys_msg_receiver` (
  `id` bigint(20) NOT NULL,
  `messageId` bigint(20) DEFAULT NULL COMMENT '消息ID',
  `receiveType` smallint(6) DEFAULT NULL COMMENT '接收者类型',
  `receiverId` bigint(20) DEFAULT NULL COMMENT '接收人ID\r\n            0,接收人\r\n            1,组织架构',
  `receiver` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '接收人',
  PRIMARY KEY (`id`),
  KEY `IDX_MSGRECEIVER_MESSAGEID` (`messageId`) USING BTREE,
  KEY `IDX_MSGRECEIVER_RECEIVERID` (`receiverId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='消息接收者';

-- ----------------------------
-- Records of sys_msg_receiver
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_reply
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_reply`;
CREATE TABLE `sys_msg_reply` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `messageId` bigint(20) DEFAULT NULL COMMENT '消息id',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `replyId` bigint(20) DEFAULT NULL COMMENT '回复人ID',
  `reply` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '回复人',
  `replyTime` datetime DEFAULT NULL COMMENT '回复时间',
  `isPrivate` smallint(6) DEFAULT NULL COMMENT '私密回复',
  PRIMARY KEY (`id`),
  KEY `IDX_MSG_REPLY_MESSAGEID` (`messageId`) USING BTREE,
  KEY `IDX_MSG_REPLY_REPLYID` (`replyId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='消息回复';

-- ----------------------------
-- Records of sys_msg_reply
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_send
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_send`;
CREATE TABLE `sys_msg_send` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `userId` bigint(20) DEFAULT NULL COMMENT '发送人ID',
  `userName` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '发送人',
  `messageType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '消息类型(使用数据字典）',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `sendTime` datetime DEFAULT NULL COMMENT '发送时间',
  `canReply` smallint(6) DEFAULT NULL COMMENT '不需回复',
  `receiverName` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_MSGSEND_USERID` (`userId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='发送消息';

-- ----------------------------
-- Records of sys_msg_send
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org` (
  `orgId` bigint(20) NOT NULL COMMENT '组织ID',
  `demId` bigint(20) DEFAULT NULL COMMENT '维度编号',
  `orgName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '名称',
  `orgDesc` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `orgSupId` bigint(20) DEFAULT NULL COMMENT '上级',
  `path` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '路径',
  `depth` int(11) DEFAULT NULL COMMENT '层次',
  `orgType` bigint(20) DEFAULT NULL COMMENT '类型ID\r\n            对应维度类型表(sys_org_type)主键',
  `creatorId` bigint(20) DEFAULT NULL COMMENT '建立人',
  `createtime` datetime DEFAULT NULL COMMENT '建立时间',
  `updateId` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `sn` bigint(20) DEFAULT NULL,
  `fromType` smallint(6) DEFAULT NULL COMMENT '数据来源',
  `orgStatus` smallint(6) DEFAULT NULL COMMENT '状态',
  `isSystem` smallint(6) DEFAULT NULL COMMENT '是否为平台管理企业：0-不是，1-是',
  PRIMARY KEY (`orgId`),
  KEY `FK_ORG_R_DMS` (`demId`) USING BTREE,
  CONSTRAINT `sys_org_ibfk_1` FOREIGN KEY (`demId`) REFERENCES `sys_demension` (`demId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='组织架构\r\nSYS_ORG';

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('1000', '1', '天智公司', '天智公司', '1', '1.100.', null, '1', null, '2013-04-10 16:51:04', '10000000110001', '2013-04-16 08:55:47', '1000', '0', null, '1');
INSERT INTO `sys_org` VALUES ('10000', '1', '宏发印务', '宏发印务', '1', '1.10000.', null, '1', null, '2014-05-26 00:45:02', null, null, '10000', '0', null, '0');

-- ----------------------------
-- Table structure for sys_org_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_info`;
CREATE TABLE `sys_org_info` (
  `SYS_ORG_INFO_ID` bigint(20) NOT NULL COMMENT 'ID',
  `EMAIL` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司邮箱',
  `NAME` varchar(256) CHARACTER SET utf8 DEFAULT '' COMMENT '公司名称',
  `INDUSTRY` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主营行业',
  `SCALE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司规模',
  `ADDRESS` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司地址',
  `POSTCODE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司邮编',
  `CONNECTER` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系人',
  `TEL` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手机号',
  `FAX` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '传真号',
  `HOMEPHONE` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '固定电话',
  `LOGO` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司LOGO',
  `INDUSTRY2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主营行业',
  `INFO` varchar(10240) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司简介',
  `COUNTRY` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '国家',
  `PROVINCE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '省',
  `CITY` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '市',
  `CODE` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '组织机构代码',
  `TYPE` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司类型',
  `MODEL` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '经营类型',
  `PRODUCT` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主营产品',
  `WEBSITE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司网址',
  `IS_PUBLIC` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '是否公开',
  `REGISTERTIME` datetime DEFAULT NULL COMMENT '注册时间',
  `FLAGLOGO` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '所属国别',
  `STATE` tinyint(4) unsigned zerofill DEFAULT NULL,
  `MANAGE_RANGE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '经验营范围',
  `REG_PROVE` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '注册证明',
  `SELL_AREA` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '销售区域',
  `BRAND` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '企业品牌',
  `EMPLOYEES` int(128) DEFAULT NULL COMMENT '员工人数',
  `AREA` bigint(128) DEFAULT NULL COMMENT '占地面积',
  `CLIENTS` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主要客户群体',
  `TURNOVER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '年营业额',
  `EXPORT_FORE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '年出口额',
  `IMPORT_FORE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '年进口额',
  `QUALITY_CONTROL` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '质量管理体系',
  `REG_CAPITAL` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '注册资本',
  `REG_ADD` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '注册地点',
  `INCORPORATOR` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '法人',
  `OPEN_BANK` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '开户银行',
  `OPEN_ACCOUNT` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '开户账户',
  `SHOWIMAGE` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '企业首页展示图片',
  `SELL_AREA2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `setid` bigint(20) DEFAULT NULL COMMENT '餐套ID',
  `recommendedEnt` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '荐推企业',
  `QRcode` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '企业二维码',
  `orgType` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '所属组织类型',
  `typeId` bigint(9) DEFAULT NULL COMMENT '类型ID',
  `typeName` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '类型名称',
  `manageType` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '经营类型',
  `specialMaterial` int(10) DEFAULT NULL COMMENT '是否有对特殊物资报价功能',
  `classification` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '机构分类（企业|学校|研究机构）',
  PRIMARY KEY (`SYS_ORG_INFO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sys_org_info
-- ----------------------------
INSERT INTO `sys_org_info` VALUES ('1000', 'tianzhi@casic.com', '北京航天智造科技发展有限公司', '运维企业', '20-50人', '北京市', '100040', '柴旭东', '13811543889', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2013-06-28 12:34:34', null, null, null, null, null, null, null, null, '学校');
INSERT INTO `sys_org_info` VALUES ('10000', 'mengwei_night_4@sina.com', '宏发印务', '印刷业和记录媒介的复制', '5 人以下', '贵州省贵阳市', '550001', '孟伟', '14938037890', '08513461070', '08513461070', null, '印刷', null, '中国', null, null, null, null, null, null, null, null, null, 'images/flag/cn.png', '0001', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2014-05-26 00:00:00', null, '美的', null, null, '0', null, null, null, '学校');

-- ----------------------------
-- Table structure for sys_org_info_aptitude
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_info_aptitude`;
CREATE TABLE `sys_org_info_aptitude` (
  `ID` bigint(20) NOT NULL,
  `INFO_ID` bigint(20) DEFAULT NULL,
  `CATE_TYPE` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_ORG` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INURE_DATE` datetime DEFAULT NULL,
  `END_DATE` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_PIC` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sys_org_info_aptitude
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org_manage
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_manage`;
CREATE TABLE `sys_org_manage` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `ORGID` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `MANAGEDORGID` bigint(20) DEFAULT NULL COMMENT '被管理的组织',
  `MANAGETYPE` smallint(6) DEFAULT NULL COMMENT '类型(1，分级授权，2，业务上的管理)',
  `CANDEL` smallint(6) DEFAULT NULL COMMENT '是否可以删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='管理的组织';

-- ----------------------------
-- Records of sys_org_manage
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_param`;
CREATE TABLE `sys_org_param` (
  `valueId` bigint(20) NOT NULL COMMENT '主键ID',
  `orgId` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `paramId` bigint(20) DEFAULT NULL COMMENT '属性ID',
  `paramValue` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '字符串属性值',
  `paramDateValue` datetime DEFAULT NULL COMMENT '日期型属性值',
  `paramIntValue` bigint(20) DEFAULT NULL COMMENT '数值型属性值',
  PRIMARY KEY (`valueId`),
  KEY `FK_ORGPM_R_SYS_ORG` (`orgId`) USING BTREE,
  KEY `FK_ORGPM_R_SYS_PARAM` (`paramId`) USING BTREE,
  CONSTRAINT `sys_org_param_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `sys_org` (`orgId`) ON DELETE CASCADE,
  CONSTRAINT `sys_org_param_ibfk_2` FOREIGN KEY (`paramId`) REFERENCES `sys_param` (`paramId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='组织参数值';

-- ----------------------------
-- Records of sys_org_param
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_role`;
CREATE TABLE `sys_org_role` (
  `id` bigint(20) NOT NULL,
  `ORGID` bigint(20) DEFAULT NULL,
  `ROLEID` bigint(20) DEFAULT NULL,
  `CANDEL` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ORGROLE_ORGID` (`ORGID`) USING BTREE,
  KEY `IDX_ORGROLE_ROLE` (`ROLEID`) USING BTREE,
  CONSTRAINT `sys_org_role_ibfk_1` FOREIGN KEY (`ORGID`) REFERENCES `sys_org` (`orgId`) ON DELETE CASCADE,
  CONSTRAINT `sys_org_role_ibfk_2` FOREIGN KEY (`ROLEID`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='组织和角色授权';

-- ----------------------------
-- Records of sys_org_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org_rolemanage
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_rolemanage`;
CREATE TABLE `sys_org_rolemanage` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `ORGID` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `ROLEID` bigint(20) DEFAULT NULL COMMENT '角色',
  `canDel` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ORGROLEMANAGE_ORGID` (`ORGID`) USING BTREE,
  KEY `IDX_ORGROLEMANAGE_ROLEID` (`ROLEID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='组织可以授权的角色范围(用于分级授权)';

-- ----------------------------
-- Records of sys_org_rolemanage
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_type`;
CREATE TABLE `sys_org_type` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `demId` bigint(20) DEFAULT NULL COMMENT '维度ID',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '名称',
  `levels` smallint(6) DEFAULT NULL COMMENT '级别',
  `memo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `icon` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='组织结构类型';

-- ----------------------------
-- Records of sys_org_type
-- ----------------------------
INSERT INTO `sys_org_type` VALUES ('1', '1', '集团', '1', '', '/styles/default/images/resicon/archSat.png');
INSERT INTO `sys_org_type` VALUES ('2', '1', '公司/单位', '2', '', '/styles/default/images/resicon/ico_116.gif');
INSERT INTO `sys_org_type` VALUES ('3', '1', '部门', '3', '', '/styles/default/images/resicon/ico_32.gif');
INSERT INTO `sys_org_type` VALUES ('4', '1', '小组', '4', '', '/styles/default/images/resicon/nav-customer.png');
INSERT INTO `sys_org_type` VALUES ('5', '1', '其他组织', '5', '', '/styles/default/images/resicon/user.gif');

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param` (
  `paramId` bigint(20) NOT NULL COMMENT '主键',
  `paramKey` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '属性key值',
  `paramName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '属性名称',
  `dataType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '数据类型',
  `effect` smallint(6) DEFAULT NULL COMMENT '参数类型\r\n            1.个人\r\n            2.组织',
  PRIMARY KEY (`paramId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户或组织自定义属性';

-- ----------------------------
-- Records of sys_param
-- ----------------------------

-- ----------------------------
-- Table structure for sys_paur
-- ----------------------------
DROP TABLE IF EXISTS `sys_paur`;
CREATE TABLE `sys_paur` (
  `PAURID` bigint(20) NOT NULL,
  `paurName` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '参数名称',
  `aliasName` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '参数的别名',
  `paurValue` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT '参数值',
  `userId` bigint(20) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`PAURID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统个性用户参数，用于记录当前用户登录后的设置一些个性化参数';

-- ----------------------------
-- Records of sys_paur
-- ----------------------------
INSERT INTO `sys_paur` VALUES ('1', '皮肤', 'skin', 'default', '0');
INSERT INTO `sys_paur` VALUES ('10000000160030', '皮肤', 'skin', 'default', '10000000110001');
INSERT INTO `sys_paur` VALUES ('10000001600076', '皮肤', 'skin', 'default', '1');
INSERT INTO `sys_paur` VALUES ('10000019480892', '皮肤', 'skin', 'default', '3');

-- ----------------------------
-- Table structure for sys_pos_sub
-- ----------------------------
DROP TABLE IF EXISTS `sys_pos_sub`;
CREATE TABLE `sys_pos_sub` (
  `mainPositionId` bigint(20) NOT NULL COMMENT '主岗位ID',
  `subPositionId` bigint(20) NOT NULL COMMENT '隶属岗位ID',
  PRIMARY KEY (`mainPositionId`,`subPositionId`),
  KEY `FK_POS_SUB_SUB_R_POS` (`subPositionId`) USING BTREE,
  CONSTRAINT `sys_pos_sub_ibfk_1` FOREIGN KEY (`mainPositionId`) REFERENCES `sys_position` (`posId`) ON DELETE CASCADE,
  CONSTRAINT `sys_pos_sub_ibfk_2` FOREIGN KEY (`subPositionId`) REFERENCES `sys_position` (`posId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='同级岗位是用于管理同级用户的下级，如一经理岗位同时有正与副，正副也同时管理下面的职位人员的话，\r\n可以把这两职';

-- ----------------------------
-- Records of sys_pos_sub
-- ----------------------------

-- ----------------------------
-- Table structure for sys_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position` (
  `posId` bigint(20) NOT NULL,
  `posName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '岗位名称',
  `posDesc` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '岗位描述',
  `parentId` bigint(20) DEFAULT NULL COMMENT '上级岗位',
  `nodePath` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '路径',
  `depth` int(11) DEFAULT NULL COMMENT '层次',
  `sn` int(11) DEFAULT NULL COMMENT '序号',
  `isLeaf` smallint(6) DEFAULT NULL COMMENT '1=是\r\n            0=否',
  `tenantId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`posId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统岗位表';

-- ----------------------------
-- Records of sys_position
-- ----------------------------

-- ----------------------------
-- Table structure for sys_profile
-- ----------------------------
DROP TABLE IF EXISTS `sys_profile`;
CREATE TABLE `sys_profile` (
  `ID` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `homepage` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '主页',
  `skin` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '皮肤',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='个人个性化信息';

-- ----------------------------
-- Records of sys_profile
-- ----------------------------

-- ----------------------------
-- Table structure for sys_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_res`;
CREATE TABLE `sys_res` (
  `resId` bigint(20) NOT NULL AUTO_INCREMENT,
  `resName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '资源名称',
  `alias` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '别名（系统中唯一)',
  `sn` int(11) DEFAULT NULL COMMENT '同级排序',
  `icon` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `parentId` bigint(20) DEFAULT NULL COMMENT '父ID',
  `defaultUrl` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '默认地址',
  `isFolder` smallint(6) DEFAULT NULL COMMENT '栏目',
  `isDisplayInMenu` smallint(6) DEFAULT NULL COMMENT '显示到菜单',
  `isOpen` smallint(6) DEFAULT NULL COMMENT '默认打开',
  `systemId` bigint(20) DEFAULT NULL COMMENT '子系统ID',
  `path` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isHidden` int(1) DEFAULT NULL,
  PRIMARY KEY (`resId`),
  KEY `IDX_SYSRES_SYSTEMID` (`systemId`) USING BTREE,
  KEY `IDX_SYSRES_PARENTID` (`parentId`) USING BTREE,
  CONSTRAINT `sys_res_ibfk_1` FOREIGN KEY (`systemId`) REFERENCES `sys_subsystem` (`systemId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110000000060007 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='子系统资源';

-- ----------------------------
-- Records of sys_res
-- ----------------------------
INSERT INTO `sys_res` VALUES ('10000000290013', '个人中心', 'CLOUD_TASK', '1', '/styles/default/images/resicon/destop.gif', '0', null, '1', '1', '1', '4001', '10000000290013', '0');
INSERT INTO `sys_res` VALUES ('10000000290021', '系统管理', 'sub_sys_manage', '2', '/styles/default/images/resicon/destop.gif', '0', null, '1', '1', '1', '4001', '10000000290021', '0');
INSERT INTO `sys_res` VALUES ('10000000290031', '企业管理', 'sub_manage', '1', '/styles/default/images/resicon/destop.gif', '10000000290021', null, '1', '1', '1', '4001', '10000000290021:10000000290031', '0');
INSERT INTO `sys_res` VALUES ('10000000290032', '企业信息维护', 'ORG_INFO', '1', '/styles/default/images/resicon/destop.gif', '10000000290031', '/cloud/tenant/tenant/edit.ht', '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290032', null);
INSERT INTO `sys_res` VALUES ('10000000290033', '组织结构维护', 'ORG_INFO_MANAGE', '1', '/styles/default/images/resicon/destop.gif', '10000000290031', '/cloud/subsystem/auth/org/list.ht', '1', '1', '1', '4001', '10000000290021:10000000290031:10000000290033', '0');
INSERT INTO `sys_res` VALUES ('10000000290034', '人员信息维护', 'USER_INFO_MANAGE', '1', '/styles/default/images/resicon/destop.gif', '10000000290031', '/cloud/subsystem/auth/user/list.ht', '1', '1', '1', '4001', '10000000290021:10000000290031:10000000290034', '0');
INSERT INTO `sys_res` VALUES ('10000004000147', '增加组织', 'addEnterpriseOrg', '1', '/styles/default/images/resicon/destop.gif', '10000000290033', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290033:10000004000147', null);
INSERT INTO `sys_res` VALUES ('10000004000148', '编辑组织', 'editEnterpriseOrg', '1', '/styles/default/images/resicon/destop.gif', '10000000290033', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290033:10000004000148', null);
INSERT INTO `sys_res` VALUES ('10000004000149', '删除节点', 'delEnterpriseOrg', '1', '/styles/default/images/resicon/destop.gif', '10000000290033', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290033:10000004000149', null);
INSERT INTO `sys_res` VALUES ('10000004000180', '查询人员', 'searchEnterpriseUser', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000180', null);
INSERT INTO `sys_res` VALUES ('10000004000181', '添加人员', 'addEnterpriseUser', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000181', null);
INSERT INTO `sys_res` VALUES ('10000004000182', '删除人员', 'delEnterpriseUser', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000182', null);
INSERT INTO `sys_res` VALUES ('10000004000183', '编辑人员', 'updateEnterpriseUserInfo', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000183', null);
INSERT INTO `sys_res` VALUES ('10000004000184', '人员明细', 'userEnterpriseInfo', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000184', null);
INSERT INTO `sys_res` VALUES ('10000004000185', '重置密码', 'resetEnterprisePwd', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000185', null);
INSERT INTO `sys_res` VALUES ('10000004000186', '设置状态', 'setEnterpriseStatus', '1', '/styles/default/images/resicon/destop.gif', '10000000290034', null, '0', '1', '1', '4001', '10000000290021:10000000290031:10000000290034:10000004000186', null);
INSERT INTO `sys_res` VALUES ('10000004010008', '租户定制', 'sys_tenant_custom', '1', '/styles/default/images/resicon/destop.gif', '10000044130005', null, '1', '1', '1', '4001', '10000044130005:10000004010008', '0');
INSERT INTO `sys_res` VALUES ('10000020480163', '消息处理', 'CLOUD_MESSAGE', '2', '/styles/default/images/resicon/destop.gif', '10000000290013', null, '1', '1', '1', '4001', '10000000290013:10000020480163', null);
INSERT INTO `sys_res` VALUES ('10000020480164', '收到的消息', 'MESSAGE_RECEIVED', '1', '/styles/default/images/resicon/destop.gif', '10000020480163', '/platform/system/messageReceiver/list.ht', '0', '1', '1', '4001', '10000000290013:10000020480163:10000020480164', null);
INSERT INTO `sys_res` VALUES ('10000020480165', '发送的消息', 'MESSAGE_SENDED', '1', '/styles/default/images/resicon/destop.gif', '10000020480163', '/platform/system/messageSend/list.ht', '0', '1', '1', '4001', '10000000290013:10000020480163:10000020480165', null);
INSERT INTO `sys_res` VALUES ('10000020480166', '发送消息', 'MESSAGE_SEND', '1', '/styles/default/images/resicon/destop.gif', '10000020480163', '/platform/system/messageSend/edit.ht', '0', '1', '1', '4001', '10000000290013:10000020480163:10000020480166', null);
INSERT INTO `sys_res` VALUES ('10000023700001', '表单绑定', 'set_form_list', '2', '/styles/default/images/resicon/destop.gif', '10000004010008', '/cloud/saas/form/list.ht', '0', '1', '1', '4001', '10000000290022:10000004010008:10000023700001', null);
INSERT INTO `sys_res` VALUES ('10000034740199', '我的信息', 'myinfo', '3', '/styles/default/images/resicon/destop.gif', '10000000290013', null, '1', '1', '1', '4001', '10000000290013:10000034740199', null);
INSERT INTO `sys_res` VALUES ('10000034740201', '我的资料', 'wodeziliao', '1', '/styles/default/images/resicon/destop.gif', '10000034740199', '/cloud/subsystem/auth/user/getMySelf.ht?canReturn=0', '0', '1', '1', '4001', '10000000290013:10000034740199:10000034740201', null);
INSERT INTO `sys_res` VALUES ('10000034740202', '修改密码', 'xiugaimima', '1', '/styles/default/images/resicon/destop.gif', '10000034740199', '/platform/system/sysUser/modifyPwdView.ht', '0', '1', '1', '4001', '10000000290013:10000034740199:10000034740202', null);
INSERT INTO `sys_res` VALUES ('10000044130005', '会员管理', 'sys_operation', '3', '/styles/default/images/resicon/destop.gif', '0', null, '1', '1', '1', '4001', '10000044130005', '0');
INSERT INTO `sys_res` VALUES ('10000044130009', '系统管理', 'cloud_aqgl', '5', '/styles/default/images/resicon/destop.gif', '0', null, '1', '1', '1', '4001', '10000044130009', '0');
INSERT INTO `sys_res` VALUES ('10000044130013', '企业管理', 'sys_tenant_manage', null, '/styles/default/images/resicon/destop.gif', '10000044130005', null, '1', '1', '1', '4001', '10000044130005:10000044130013', '0');
INSERT INTO `sys_res` VALUES ('10000044130014', '新注册企业', 'cloud_xzchy', '1', '/styles/default/images/resicon/destop.gif', '10000044130013', '/cloud/tenant/tenant/listNew.ht', '1', '1', '1', '4001', '10000044130005:10000044130013:10000044130014', '0');
INSERT INTO `sys_res` VALUES ('10000044130018', '未审核企业', 'cloud_wshhy', '2', '/styles/default/images/resicon/destop.gif', '10000044130013', '/cloud/tenant/tenant/listPending.ht', '1', '1', '1', '4001', '10000044130005:10000044130013:10000044130018', '0');
INSERT INTO `sys_res` VALUES ('10000044130019', '已审核企业', 'cloud_yshhy', '3', '/styles/default/images/resicon/destop.gif', '10000044130013', '/cloud/tenant/tenant/listPassing.ht', '1', '1', '1', '4001', '10000044130005:10000044130013:10000044130019', '0');
INSERT INTO `sys_res` VALUES ('10000044130048', '日志管理', 'res_audit', null, '/styles/default/images/resicon/destop.gif', '10000044130009', null, '1', '1', '1', '4001', '10000044130009:10000044130048', '0');
INSERT INTO `sys_res` VALUES ('10000044130049', '平台日志', 'audit_system', null, '/styles/default/images/resicon/destop.gif', '10000044130048', '/cloud/audit/log/listForAuditAdmin.ht', '0', '1', '1', '4001', '10000044130009:10000044130048:10000044130049', '0');
INSERT INTO `sys_res` VALUES ('10000044130052', '权限管理', null, null, '/styles/default/images/resicon/destop.gif', '10000044130009', null, '1', '1', '1', '4001', null, '0');
INSERT INTO `sys_res` VALUES ('10000044130053', '角色管理', null, null, '/styles/default/images/resicon/destop.gif', '10000044130052', '/platform/system/sysRole/list.ht', '1', '1', '1', '4001', null, '0');
INSERT INTO `sys_res` VALUES ('10000044130062', '资源管理', null, null, '/styles/default/images/resicon/destop.gif', '10000044130052', '/platform/system/resources/tree.ht', '0', '1', '1', '4001', null, '0');
INSERT INTO `sys_res` VALUES ('10000044270000', '审计管理', 'sub_audit', '1', '/styles/default/images/resicon/destop.gif', '10000000290021', null, '1', '1', '1', '4001', '10000000290021:10000044270000', '0');
INSERT INTO `sys_res` VALUES ('10000044270001', '企业日志', 'audit_tenant', '1', '/styles/default/images/resicon/destop.gif', '10000044270000', '/cloud/audit/log/listForSystemAdmin.ht', '1', '1', '1', '4001', '10000000290021:10000044270000:10000044270001', '0');
INSERT INTO `sys_res` VALUES ('10000044320033', '业务系统演示', 'demo', '1', '/styles/default/images/resicon/destop.gif', '0', null, '1', '1', '1', '4001', '10000044320033', '0');
INSERT INTO `sys_res` VALUES ('10000044320034', '课程列表', 'cloud_kclb', '1', '/styles/default/images/resicon/destop.gif', '10000044320033', '/demo/course/course/list.ht', '0', '1', '1', '4001', '10000044320033:10000044320034', '0');
INSERT INTO `sys_res` VALUES ('10000044850000', '合同列表', 'cloud_htlb', '1', '/styles/default/images/resicon/file.png', '10000044320033', '/demo/contract/contract/list.ht', '0', '1', '1', '4001', '10000044320033:10000044850000', '0');
INSERT INTO `sys_res` VALUES ('20000000010000', '角色配置', 'cloud_saas_role', '7', '/styles/default/images/resicon/destop.gif', '10000004010008', '/cloud/saas/role/saas.ht', '0', '1', '1', '4001', '10000000290022:10000004010008:20000000010000', null);
INSERT INTO `sys_res` VALUES ('20000000010001', '资源配置', 'cloud_saas_res', '8', '/styles/default/images/resicon/destop.gif', '10000004010008', '/cloud/saas/res/saas.ht', '0', '1', '1', '4001', '10000000290022:10000004010008:20000000010001', null);
INSERT INTO `sys_res` VALUES ('20000000070000', '角色资源维护', 'cloud_config_role_res', '4', '/styles/default/images/resicon/destop.gif', '10000000290031', '/cloud/saas/role/listByTenant.ht', '0', '1', '1', '4001', '10000000290021:10000000290031:20000000070000', null);

-- ----------------------------
-- Table structure for sys_resurl
-- ----------------------------
DROP TABLE IF EXISTS `sys_resurl`;
CREATE TABLE `sys_resurl` (
  `resUrlId` bigint(20) NOT NULL,
  `resId` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '名称',
  `url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`resUrlId`),
  KEY `IDX_RESURL_RESID` (`resId`) USING BTREE,
  CONSTRAINT `sys_resurl_ibfk_1` FOREIGN KEY (`resId`) REFERENCES `sys_res1` (`resId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='资源URL';

-- ----------------------------
-- Records of sys_resurl
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `roleId` bigint(20) NOT NULL,
  `systemId` bigint(20) DEFAULT NULL COMMENT '系统ID',
  `alias` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '角色别名',
  `roleName` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '角色名',
  `memo` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `allowDel` smallint(6) DEFAULT NULL COMMENT '允许删除',
  `allowEdit` smallint(6) DEFAULT NULL COMMENT '允许编辑',
  `enabled` smallint(6) DEFAULT NULL COMMENT '是否启用\r\n            (0,禁止,1,启用)',
  `roleType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '角色类型：集团、经销商、服务商、采购商等',
  `isTenant` int(1) DEFAULT NULL,
  PRIMARY KEY (`roleId`),
  KEY `FK_ROLE_R_SUBSYS` (`systemId`) USING BTREE,
  CONSTRAINT `sys_role_ibfk_1` FOREIGN KEY (`systemId`) REFERENCES `sys_subsystem` (`systemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('11', '4001', 'role_sys_admin', '运营管理员', '内置角色', '0', '1', '1', null, '0');
INSERT INTO `sys_role` VALUES ('12', '4001', 'role_tenant_admin', '企业管理员', '企业内部管理员', '0', '1', '1', null, '0');
INSERT INTO `sys_role` VALUES ('13', '4001', 'role_common_user', '企业员工', '企业普通用户', '0', '1', '1', null, '0');

-- ----------------------------
-- Table structure for sys_role_pos
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_pos`;
CREATE TABLE `sys_role_pos` (
  `posId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`posId`,`roleId`),
  KEY `FK_ROLE_POS_R_ROLE` (`roleId`) USING BTREE,
  CONSTRAINT `sys_role_pos_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE,
  CONSTRAINT `sys_role_pos_ibfk_2` FOREIGN KEY (`posId`) REFERENCES `sys_position` (`posId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SYS_ROLE_POS';

-- ----------------------------
-- Records of sys_role_pos
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_res`;
CREATE TABLE `sys_role_res` (
  `roleResId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色资源Id',
  `roleId` bigint(20) DEFAULT NULL,
  `resId` bigint(20) DEFAULT NULL COMMENT '资源主键',
  `systemId` bigint(20) DEFAULT NULL COMMENT '系统ID',
  PRIMARY KEY (`roleResId`),
  KEY `IDX_ROLERES_RESID` (`resId`) USING BTREE,
  KEY `IDX_ROLERES_ROLEID` (`roleId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110000000080029 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色资源映射';

-- ----------------------------
-- Records of sys_role_res
-- ----------------------------
INSERT INTO `sys_role_res` VALUES ('10000044780019', '11', '10000044130005', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780020', '11', '10000044130013', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780021', '11', '10000044130014', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780022', '11', '10000044130018', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780023', '11', '10000044130019', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780024', '11', '10000004010008', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780025', '11', '10000023700001', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780026', '11', '20000000010000', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780027', '11', '20000000010001', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780029', '11', '10000044130048', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780030', '11', '10000044130049', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780031', '11', '2', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780032', '11', '163', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780033', '11', '161', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780034', '11', '185', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780035', '11', '186', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780036', '11', '181', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780037', '11', '188', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780038', '11', '67', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780039', '11', '124', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780040', '11', '125', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780041', '11', '6', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780042', '11', '126', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780043', '11', '127', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780044', '11', '8', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780045', '11', '128', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780046', '11', '129', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780047', '11', '89', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780048', '11', '72', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780049', '11', '122', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780050', '11', '123', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780051', '11', '3', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780052', '11', '10', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780053', '11', '1', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780054', '11', '39', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780055', '11', '178', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780056', '11', '11', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780057', '11', '179', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780058', '11', '9', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780059', '11', '160', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780060', '11', '164', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780061', '11', '162', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780062', '11', '144', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780063', '11', '165', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780064', '11', '46', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780065', '11', '47', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780066', '11', '48', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780067', '11', '49', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780068', '11', '40', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780069', '11', '61', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780070', '11', '177', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780071', '11', '191', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780072', '11', '192', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780073', '11', '193', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780074', '11', '64', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780075', '11', '65', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780076', '11', '66', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780077', '11', '68', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780078', '11', '70', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780079', '11', '73', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780080', '11', '74', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780081', '11', '75', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780082', '11', '118', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780083', '11', '119', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780084', '11', '76', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780085', '11', '120', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780086', '11', '121', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780087', '11', '82', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780088', '11', '85', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780089', '11', '86', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780090', '11', '190', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780091', '11', '84', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780092', '11', '83', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780093', '11', '10000044130009', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780096', '11', '10000044130052', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780097', '11', '10000044130053', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780098', '11', '10000044130062', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780100', '11', '13', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780101', '11', '36', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780102', '11', '53', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780103', '11', '136', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780104', '11', '137', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780105', '11', '138', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780106', '11', '151', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780107', '11', '176', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780108', '11', '54', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780109', '11', '38', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780110', '11', '173', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780111', '11', '37', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780112', '11', '174', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780113', '11', '143', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780114', '11', '175', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780115', '11', '189', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780116', '11', '14', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780117', '11', '131', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780118', '11', '132', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780119', '11', '133', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780120', '11', '169', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780121', '11', '170', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780122', '11', '130', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780123', '11', '158', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780124', '11', '16', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780125', '11', '135', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780126', '11', '17', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780127', '11', '171', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780128', '11', '18', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044780129', '11', '172', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790002', '12', '10000044320033', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790003', '12', '10000044320034', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790004', '12', '10000000290013', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790012', '12', '10000020480163', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790013', '12', '10000020480164', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790014', '12', '10000020480165', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790015', '12', '10000020480166', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790016', '12', '10000034740199', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790018', '12', '10000034740201', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790019', '12', '10000034740202', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790020', '12', '10000000290021', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790021', '12', '10000044270000', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790022', '12', '10000044270001', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790024', '12', '10000000290031', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790025', '12', '10000000290032', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790026', '12', '10000000290033', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790027', '12', '10000004000147', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790028', '12', '10000004000148', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790029', '12', '10000004000149', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790030', '12', '10000000290034', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790031', '12', '10000004000180', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790032', '12', '10000004000181', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790033', '12', '10000004000182', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790034', '12', '10000004000183', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790035', '12', '10000004000184', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790036', '12', '10000004000185', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790037', '12', '10000004000186', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044790038', '12', '20000000070000', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044850001', '13', '10000044320033', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044850002', '13', '10000044320034', '4001');
INSERT INTO `sys_role_res` VALUES ('10000044850003', '13', '10000044850000', '4001');

-- ----------------------------
-- Table structure for sys_role_sys
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_sys`;
CREATE TABLE `sys_role_sys` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `systemId` bigint(20) DEFAULT NULL COMMENT '系统ID',
  PRIMARY KEY (`id`),
  KEY `FK_SYRLS_R_SUBSYS` (`systemId`) USING BTREE,
  KEY `FK_SYRLES_R_SSROLE` (`roleId`) USING BTREE,
  CONSTRAINT `sys_role_sys_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE,
  CONSTRAINT `sys_role_sys_ibfk_2` FOREIGN KEY (`systemId`) REFERENCES `sys_subsystem` (`systemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色系统映射';

-- ----------------------------
-- Records of sys_role_sys
-- ----------------------------

-- ----------------------------
-- Table structure for sys_subsystem
-- ----------------------------
DROP TABLE IF EXISTS `sys_subsystem`;
CREATE TABLE `sys_subsystem` (
  `systemId` bigint(20) NOT NULL COMMENT '主键',
  `sysName` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '系统名称',
  `alias` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '别名(系统中唯一)',
  `logo` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '系统的图标',
  `defaultUrl` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '系统首页地址',
  `memo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '创建人',
  `allowDel` smallint(6) DEFAULT NULL COMMENT '允许删除',
  `needOrg` smallint(6) DEFAULT NULL COMMENT '选择组织架构\r\n            (0,不需要选择,1,需要选择)\r\n            如果用户只属于一个组织读取组织后，放到当前上下文。多个的话则需要选择。\r\n            ',
  `isActive` smallint(6) DEFAULT NULL COMMENT '是否激活',
  `isLocal` smallint(6) DEFAULT NULL,
  `homePage` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `namespace` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`systemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='子系统管理';

-- ----------------------------
-- Records of sys_subsystem
-- ----------------------------
INSERT INTO `sys_subsystem` VALUES ('4001', '第三方子系统演示', '第三方子系统演示', null, null, '第三方子系统演示', '2016-06-07 16:37:45', null, '0', null, '1', '1', null, null);
INSERT INTO `sys_subsystem` VALUES ('4002', '第三方子系统合同', '合同演示', null, null, '第三方子系统合同', '2016-10-24 18:25:09', null, '0', null, '1', '1', null, null);

-- ----------------------------
-- Table structure for sys_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_template`;
CREATE TABLE `sys_template` (
  `templateId` bigint(20) NOT NULL COMMENT '主键Id',
  `templateType` int(11) DEFAULT NULL COMMENT '类型\r\n            1.手机短信\r\n            2.邮件模版\r\n            3.html模版',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '模版名称',
  `content` text COLLATE utf8_unicode_ci COMMENT '模版内容',
  `ISDEFAULT` smallint(6) DEFAULT NULL COMMENT '是否默认',
  `ISSYSTEMTEMP` smallint(6) DEFAULT NULL COMMENT '是否系统自带模板',
  PRIMARY KEY (`templateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统模版管理';

-- ----------------------------
-- Records of sys_template
-- ----------------------------
INSERT INTO `sys_template` VALUES ('1', '1', '手机短信模板', '${收件人}:您有待办事项:${事项名称}，请登录http://www.cosimcloud.com办理。', '1', '1');
INSERT INTO `sys_template` VALUES ('2', '2', '邮件模板', '${收件人}:<br />你有一个待办事项需要处理，事项名称:<a href=\"${跳转地址}\" target=\"_blank\">${事项名称}</a>。', '1', '1');
INSERT INTO `sys_template` VALUES ('3', '3', '内部消息模板', '${收件人}:<br />你有一个待办事项需要处理，事项名称:<a href=\"${跳转地址}\" target=\"_blank\">${事项名称}</a>。', '1', '1');
INSERT INTO `sys_template` VALUES ('10000034763248', '1', '未读消息', '', '0', '0');

-- ----------------------------
-- Table structure for sys_type_key
-- ----------------------------
DROP TABLE IF EXISTS `sys_type_key`;
CREATE TABLE `sys_type_key` (
  `typeId` bigint(20) NOT NULL,
  `typeKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `typeName` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` bigint(20) DEFAULT NULL,
  `sn` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0=平铺结构\r\n            1=树型结构',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统分类键';

-- ----------------------------
-- Records of sys_type_key
-- ----------------------------
INSERT INTO `sys_type_key` VALUES ('1', 'REPORT_TYPE', '报表分类', '1', '0', '1');
INSERT INTO `sys_type_key` VALUES ('2', 'DIC', '数据字典', '1', '6', '1');
INSERT INTO `sys_type_key` VALUES ('3', 'FLOW_TYPE', '流程分类', '1', '4', '1');
INSERT INTO `sys_type_key` VALUES ('4', 'FORM_TYPE', '表单分类', '1', '5', '1');
INSERT INTO `sys_type_key` VALUES ('5', 'ATTACH_TYPE', '附件分类', '1', '2', '1');
INSERT INTO `sys_type_key` VALUES ('6', 'FILE_TYPE', '文件文类', '1', '3', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userId` bigint(20) NOT NULL,
  `fullname` varchar(127) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '姓名',
  `account` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `isExpired` smallint(6) DEFAULT NULL COMMENT '是否过期',
  `isLock` smallint(6) DEFAULT NULL COMMENT '是否锁定',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `status` smallint(6) DEFAULT NULL COMMENT '状态\r\n            1=激活\r\n            0=禁用\r\n            -1=删除',
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手机',
  `phone` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电话',
  `sex` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '1=男\r\n            0=女',
  `picture` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FROMTYPE` smallint(6) DEFAULT NULL COMMENT '数据来源',
  `orgId` bigint(20) DEFAULT NULL,
  `orgSn` bigint(20) DEFAULT NULL,
  `shortAccount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orgType` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '所属组织类型',
  `typeId` bigint(9) DEFAULT NULL COMMENT '类型ID',
  `typeName` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '类型名称',
  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refCode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `security_level` int(2) DEFAULT NULL,
  `isapply` int(2) DEFAULT NULL,
  `openId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '系统管理员', 'sysadmin', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', '0', '0', '2013-04-16 16:51:03', '1', '', '', '', '1', '', '0', '1000', '1000', 'sysadmin', null, null, null, null, null, null, null, null);
INSERT INTO `sys_user` VALUES ('2', '企业管理员', '10000_system', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', '0', '0', null, '1', null, null, null, '1', null, '0', '10000', '10000', 'system', null, null, null, null, null, null, null, null);
INSERT INTO `sys_user` VALUES ('3', '企业员工', '10000_user', 'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', '0', '0', null, '1', null, null, null, '1', null, '0', '10000', '10000', 'user', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for sys_user_agent
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_agent`;
CREATE TABLE `sys_user_agent` (
  `agentId` bigint(20) NOT NULL,
  `agentUserId` bigint(20) NOT NULL,
  `toUserId` bigint(20) NOT NULL,
  `toFullname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `isAll` smallint(6) DEFAULT NULL COMMENT '1=是\r\n            0=否',
  `isValid` smallint(6) DEFAULT NULL COMMENT '1=是\r\n            0=否',
  PRIMARY KEY (`agentId`),
  KEY `IDX_USERAGENT_AGENTUSERID` (`agentUserId`) USING BTREE,
  KEY `IDX_USERAGENT_TOUSERID` (`toUserId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sys_user_agent
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_extence
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_extence`;
CREATE TABLE `sys_user_extence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `state` tinyint(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_extence
-- ----------------------------
INSERT INTO `sys_user_extence` VALUES ('22', '1', '10000038460000');
INSERT INTO `sys_user_extence` VALUES ('23', '1', '10000038500000');
INSERT INTO `sys_user_extence` VALUES ('26', '1', '10000038510000');
INSERT INTO `sys_user_extence` VALUES ('28', '1', '10000038530002');
INSERT INTO `sys_user_extence` VALUES ('30', '1', '10000038540000');
INSERT INTO `sys_user_extence` VALUES ('32', '0', '10000038660000');
INSERT INTO `sys_user_extence` VALUES ('34', '1', '10000038700001');
INSERT INTO `sys_user_extence` VALUES ('40', '1', '10000039200000');
INSERT INTO `sys_user_extence` VALUES ('42', '0', '10000039460000');
INSERT INTO `sys_user_extence` VALUES ('43', '0', '10000040530006');
INSERT INTO `sys_user_extence` VALUES ('44', '1', '10000041960071');
INSERT INTO `sys_user_extence` VALUES ('45', '1', '10000041960068');
INSERT INTO `sys_user_extence` VALUES ('46', '1', '10000042160138');
INSERT INTO `sys_user_extence` VALUES ('47', '1', '10000042010072');
INSERT INTO `sys_user_extence` VALUES ('48', '1', '10000042780000');
INSERT INTO `sys_user_extence` VALUES ('49', '1', '10000042780003');
INSERT INTO `sys_user_extence` VALUES ('50', '1', '10000042780006');
INSERT INTO `sys_user_extence` VALUES ('51', '1', '10000042780009');
INSERT INTO `sys_user_extence` VALUES ('52', '1', '10000042780012');

-- ----------------------------
-- Table structure for sys_user_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_org`;
CREATE TABLE `sys_user_org` (
  `userOrgId` bigint(20) NOT NULL COMMENT '用户组织编号',
  `orgId` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `userId` bigint(20) DEFAULT NULL COMMENT 'userId',
  `isPrimary` smallint(6) NOT NULL COMMENT '是否为主要\r\n            1=主要\r\n            0=非主要',
  `isCharge` bigint(20) DEFAULT NULL COMMENT '组织负责人ID',
  `ISGRADEMANAGE` smallint(6) DEFAULT NULL COMMENT '是否为分级管理员',
  PRIMARY KEY (`userOrgId`),
  KEY `IDX_USER_ORG_ORGID` (`orgId`) USING BTREE,
  KEY `IDX_USER_ORG_USERID` (`userId`) USING BTREE,
  CONSTRAINT `sys_user_org_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `sys_org` (`orgId`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_org_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户所属组织或部门';

-- ----------------------------
-- Records of sys_user_org
-- ----------------------------
INSERT INTO `sys_user_org` VALUES ('1', '1000', '1', '1', '1', '0');
INSERT INTO `sys_user_org` VALUES ('2', '10000', '2', '1', '1', '1');
INSERT INTO `sys_user_org` VALUES ('3', '10000', '3', '1', '0', '0');

-- ----------------------------
-- Table structure for sys_user_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_param`;
CREATE TABLE `sys_user_param` (
  `valueId` bigint(20) NOT NULL COMMENT '主键ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `paramId` bigint(20) DEFAULT NULL COMMENT '属性ID',
  `paramValue` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '属性值',
  `paramDateValue` datetime DEFAULT NULL COMMENT '日期类型属性值',
  `paramIntValue` bigint(20) DEFAULT NULL COMMENT '数值型属性值',
  PRIMARY KEY (`valueId`),
  KEY `IDX_USERPARAM_USERID` (`userId`) USING BTREE,
  KEY `IDX_USERPARAM_PARAMID` (`paramId`) USING BTREE,
  CONSTRAINT `sys_user_param_ibfk_1` FOREIGN KEY (`paramId`) REFERENCES `sys_param` (`paramId`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_param_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户自定义参数';

-- ----------------------------
-- Records of sys_user_param
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_pos
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_pos`;
CREATE TABLE `sys_user_pos` (
  `userPosId` bigint(20) NOT NULL,
  `posId` bigint(20) DEFAULT NULL COMMENT '岗位编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `isPrimary` smallint(6) DEFAULT NULL COMMENT '是否主岗位',
  `tenantId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`userPosId`),
  KEY `FK_SYS_USR_R_USR_POS` (`userId`) USING BTREE,
  KEY `FK_USER_POS_R_POSITION` (`posId`) USING BTREE,
  CONSTRAINT `sys_user_pos_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_pos_ibfk_2` FOREIGN KEY (`posId`) REFERENCES `sys_position` (`posId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户岗位表';

-- ----------------------------
-- Records of sys_user_pos
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `userRoleId` bigint(20) NOT NULL COMMENT '用户角色Id',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`userRoleId`),
  KEY `FK_SYS_ROLE_R_USR_ROLE` (`roleId`) USING BTREE,
  KEY `FK_USER_ROLE_R_SYS_USER` (`userId`) USING BTREE,
  CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户角色映射表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '11', '1');
INSERT INTO `sys_user_role` VALUES ('2', '12', '2');
INSERT INTO `sys_user_role` VALUES ('3', '13', '3');

-- ----------------------------
-- Table structure for sys_user_under
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_under`;
CREATE TABLE `sys_user_under` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `underUserId` bigint(20) DEFAULT NULL COMMENT '下属用户ID',
  `underUserName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '下属用户名',
  `tenantId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_USERUNDER_USERID` (`userId`) USING BTREE,
  KEY `IDX_USERUNDER_UNDERUSERID` (`underUserId`) USING BTREE,
  CONSTRAINT `sys_user_under_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `sys_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='下属管理';

-- ----------------------------
-- Records of sys_user_under
-- ----------------------------
