



-- 湿地二调数据
CREATE TABLE `bio_wetland_second_survey` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `city_code` varchar(32) DEFAULT NULL COMMENT '市',
  `district_code` varchar(32) DEFAULT NULL COMMENT '区',
  `all_sum` DOUBLE DEFAULT '0' COMMENT '所有湿地合计',
  `sea_shallow` DOUBLE DEFAULT '0' COMMENT '浅海水域',
  `sea_rock` DOUBLE DEFAULT '0' COMMENT '岩石海岸',
  `sea_sand` DOUBLE DEFAULT '0' COMMENT '沙石海滩',
  `sea_silt` DOUBLE DEFAULT '0' COMMENT '淤泥质海滩',
  `sea_swamp` DOUBLE DEFAULT '0' COMMENT '潮间盐水沼泽',
  `sea_mangrove` DOUBLE DEFAULT '0' COMMENT '红树林',
  `sea_river` DOUBLE DEFAULT '0' COMMENT '河口水域',
  `sea_delta` DOUBLE DEFAULT '0' COMMENT '三角洲沙洲岛',
  `sea_lake` DOUBLE DEFAULT '0' COMMENT '海岸性淡水湖',
  `sea_sum` DOUBLE DEFAULT '0' COMMENT '近海与海岸湿地_小计',
  `river_forever` DOUBLE DEFAULT '0' COMMENT '永久性河流',
  `river_flooding` DOUBLE DEFAULT '0' COMMENT '洪泛平原',
  `river_sum` DOUBLE DEFAULT '0' COMMENT '河流湿地_小计',
  `lake_forever` DOUBLE DEFAULT '0' COMMENT '永久性淡水湖',
  `lake_sum` DOUBLE DEFAULT '0' COMMENT '湖泊湿地_小计',
  `swamp_herb` DOUBLE DEFAULT '0' COMMENT '草本沼泽',
  `swamp_brush` DOUBLE DEFAULT '0' COMMENT '灌丛沼泽',
  `swamp_forest` DOUBLE DEFAULT '0' COMMENT '森林沼泽',
  `swamp_meadow` DOUBLE DEFAULT '0' COMMENT '沼泽化草甸',
  `swamp_sum` DOUBLE DEFAULT '0' COMMENT '沼泽湿地_小计',
  `artificial_wetland_pond` DOUBLE DEFAULT '0' COMMENT '库唐',
  `artificial_wetland_river` DOUBLE DEFAULT '0' COMMENT '运河输水河',
  `artificial_wetland_farm` DOUBLE DEFAULT '0' COMMENT '水产养殖场',
  `artificial_wetland_salina` DOUBLE DEFAULT '0' COMMENT '盐田',
  `artificial_wetland_sum` DOUBLE DEFAULT '0' COMMENT '人工湿地_小计',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_dept` bigint(64) DEFAULT NULL COMMENT '创建部门',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0.未删除、1.已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1372072586654982147 DEFAULT CHARSET=utf8 COMMENT='湿地二调数据表';








INSERT INTO `blade_menu` ( `id`, `parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted` )
VALUES
	( '1430800359310516230', 1354033200126369794, 'wetlandsecondsurvey', '湿地二调数据', 'menu', '/shengting-wetland/wetland-resource/wetlandDistributionAndChange/wetlandsecondsurvey', NULL, 1, 1, 0, 1, NULL, 0 );
	
	INSERT INTO `blade_menu` ( `id`, `parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted` )
VALUES
	( '1430800359310516234', '1430800359310516230', 'wetlandsecondsurvey_view', '查看', 'view', '/shengting-wetland/wetland-resource/wetlandDistributionAndChange/wetlandsecondsurvey/view', 'file-text', 4, 2, 2, 1, NULL, 0 );





    -- 物种信息改状态字段
    ALTER TABLE `shengting_aco`.`aco_animal_info` 
MODIFY COLUMN `status` varchar(50) NULL DEFAULT NULL AFTER `create_time`;







CREATE TABLE `aco_process_info` (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `place_id` bigint(64) NOT NULL COMMENT '繁育场id',
  `place_species_id` varchar(255) NOT NULL COMMENT '繁育场物种id',
  `approval_number` varchar(255) DEFAULT NULL COMMENT '批文号',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `operate_user` bigint(64) DEFAULT NULL COMMENT '操作人',
  `operate_event` int(2) DEFAULT NULL COMMENT '1-新办证、2-换证、3-变更、4-注销操作、5-利⽤复核、6-利用确认',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` int(2) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='行政许可事项流程信息';




List<SecManage> secManages = secManageMapper.selectList(null);
		List<Long> secManageHuntId = secManages.stream().map(SecManage::getHuntId).collect(Collectors.toList());
		List<Long> collect1 = collect.stream().filter(secManageHuntId::contains).collect(Collectors.toList());
//		List<Long> collect2 = secManages.stream().map(SecManage::getHuntId).collect(Collectors.toList());


-- 繁育许可新增所属机构字段
ALTER TABLE `shengting_aco`.`aco_breed` 
ADD COLUMN `affiliation_dept` bigint(64) NULL COMMENT '复核完所属机构' AFTER `create_dept`;

-- 猎捕许可添加字段
ALTER TABLE `shengting_aco`.`aco_hunt` 
ADD COLUMN `affiliation_dept` bigint(64) NULL COMMENT '复核完所属机构' AFTER `create_dept`;

-- 繁育场变更基本信息表
ALTER TABLE `shengting_aco`.`aco_breed_change_info`
    ADD COLUMN `ywlsh` varchar(64) NULL COMMENT '外部业务流水号' AFTER `change_after_info`;

    ALTER TABLE `shengting_aco`.`aco_breed_species` 
MODIFY COLUMN `permit_count` int(16) NULL DEFAULT NULL COMMENT '准予数量，变更后准予数量' AFTER `ename`;

ALTER TABLE `shengting_aco`.`aco_breed_change_info` 
MODIFY COLUMN `breed_id` bigint(64) NULL DEFAULT NULL COMMENT '繁育许可id' AFTER `type`;

ALTER TABLE `shengting_aco`.`aco_breed` 
DROP COLUMN `is_capital`,
DROP COLUMN `is_forage`,
DROP COLUMN `is_second_level`,
MODIFY COLUMN `purpose` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '繁育目的' AFTER `is_facilities`,
MODIFY COLUMN `apply_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '签发时间时间' AFTER `purpose`,
MODIFY COLUMN `change_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更类型' AFTER `check_recode`;



-- 繁育许可变更 造数据

INSERT INTO `shengting_aco`.`aco_breed_change_info` ( `id`, `type`, `breed_id`, `change_before_info`, `change_after_info`, `ywlsh` )
	(
	SELECT
		rand()* 1000000000000000 AS id,
		'法人代表变更' AS type,
		ab.id as breed_id,
		ac.frdb as change_before_info,
		ac.lxr as change_after_info,
		ab.ywlsh as ywlsh 
	FROM
		aco_breed ab
		INNER JOIN aco_company ac ON ab.rel_id = ac.id 
	WHERE
		ab.id = '1433052708935737345' 
	);
	
INSERT INTO `shengting_aco`.`aco_breed_change_info` ( `id`, `type`, `breed_id`, `change_before_info`, `change_after_info`, `ywlsh` )
(
	SELECT
		rand()* 1000000000000000 AS id,
		'人工繁育场名称变更' AS type,
		ab.id as breed_id,
		ac.name as change_before_info,
		'变更后名称' as change_after_info,
		ab.ywlsh as ywlsh 
	FROM
		aco_breed ab
		INNER JOIN aco_company ac ON ab.rel_id = ac.id 
	WHERE
		ab.id = '1433052708935737345' 
	);

INSERT INTO `shengting_aco`.`aco_breed_change_info` ( `id`, `type`, `breed_id`, `change_before_info`, `change_after_info`, `ywlsh` )
(
	SELECT
		rand()* 1000000000000000 AS id,
		'技术负责人变更' AS type,
		ab.id as breed_id,
		ab.technology_pic as change_before_info,
		'变更后技术人' as change_after_info,
		ab.ywlsh as ywlsh 
	FROM
		aco_breed ab
		INNER JOIN aco_company ac ON ab.rel_id = ac.id 
	WHERE
		ab.id = '1433052708935737345' 
	);







`AI鸟类识别`

```sql
CREATE TABLE `daq_infrared_camera_resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT 'uuid',
  `imei` varchar(255) DEFAULT NULL COMMENT '相机Imei',
  `distinguishTime` datetime DEFAULT NULL COMMENT '识别时间',
  `name` varchar(255) DEFAULT NULL COMMENT '鸟类名称',
  `count` int(11) DEFAULT NULL COMMENT '发现数量',
  `distinguishUrl` varchar(255) DEFAULT NULL COMMENT '识别文件地址',
  `resource_type` int(2) DEFAULT NULL COMMENT '资源类型;1用于高分辨率照片，2用于视频',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='AI鸟类识别资源表';
```

