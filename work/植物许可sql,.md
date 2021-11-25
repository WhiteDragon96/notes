```sql
CREATE TABLE `aco_plant` (
  `id` bigint(64) NOT NULL,
  `tenant_id` varchar(12) DEFAULT NULL COMMENT '租户ID',
   `rel_type` varchar(64) DEFAULT NULL COMMENT '关联类型 1.个人、2.公司',
   `rel_id` bigint(64) DEFAULT NULL COMMENT '关联ID',
    `ywlsh` varchar(64) DEFAULT NULL COMMENT '业务流水号',
   `objective` varchar(64) DEFAULT NULL COMMENT '采集目的重大工程建设需要，科学研究、文化交流，人工繁育，自然灾害造成的安全隐患 ）',
   `province` varchar(64) DEFAULT NULL COMMENT '采集地点（省）',
   `city` varchar(64) DEFAULT NULL COMMENT '采集地点（省）',
   `county` varchar(64) DEFAULT NULL COMMENT '采集地点（区/县）',
   `town` varchar(64) DEFAULT NULL COMMENT '采集地点（乡/镇）',
   `village` varchar(64) DEFAULT NULL COMMENT '采集地点（村）',
   `forest_class` varchar(64) DEFAULT NULL COMMENT '采集地点（林班）',
   `pm_no` varchar(255) DEFAULT NULL COMMENT '植采证号 许可证号',
    `approval_number` varchar(64) DEFAULT NULL COMMENT '许可批文号',
    `permit_content_url` varchar(255) DEFAULT NULL COMMENT '许可决定书内容url',
    `start_time` datetime DEFAULT NULL COMMENT '采集开始时间',
    `end_time` datetime DEFAULT NULL COMMENT '采集结束时间',
  	`issued_date` date DEFAULT NULL COMMENT '签发时间',
  `create_user` bigint(64) DEFAULT NULL COMMENT '创建人',
  `create_dept` bigint(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(2) DEFAULT NULL COMMENT '申请状态 1未复核 2已复核',
  `is_deleted` int(2) DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='植物许可-申请主表 ';
```

```sql
CREATE TABLE `aco_plant_info` (
  `id` bigint(64) NOT NULL COMMENT '主键',
  `tenant_id` varchar(12) NOT NULL DEFAULT '000000' COMMENT '租户ID',
   `ywlsh` varchar(64) DEFAULT NULL COMMENT '业务流水号',
  `cname` varchar(200) DEFAULT NULL COMMENT '物种中文学名',
  `ltname` varchar(255) DEFAULT NULL COMMENT '物种拉丁学名',
  `level` int(16) DEFAULT NULL COMMENT '保护级别',
   `permit_count` int(16) DEFAULT NULL COMMENT '准予数量',
  `place` varchar(64) DEFAULT NULL COMMENT '采集部位',
  `create_user` bigint(64) DEFAULT NULL COMMENT '创建人',
  `create_dept` bigint(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(2) DEFAULT NULL COMMENT '申请状态',
  `is_deleted` int(2) DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='植物许可-申请附表 ';
```

