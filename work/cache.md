```
  {
    img: '/img/bg/vip2.png',
    title: '许可数据复核',
    subtitle: '',
    tag: 0,
    status: 1,
    path: '/aco/approvalDataCheck/index',
  }
```

```shle

.\npc.exe install -server=121.196.208.104:18024 -vkey=zwsy7q5b76pem9pm -type=tcp
```



`activeMQ`

```shell
docker run -d -p 61616:61616 -p 8161:8161 \
--restart unless-stopped \
-v /appdata/activemq/conf:/opt/activemq/conf \
-v /appdata/activemq/data:/opt/activemq/data \
--name activemq1 \
rmohr/activemq
```

```shell
docker run --user root --rm -it \
-v /appdata/activemq/conf:/opt/activemq/conf \
-v /appdata/activemq/data:/opt/activemq/data \
--name activemq \
rmohr/activemq /bin/sh


chown activemq:activemq /opt/activemq/data
cp -r /opt/activemq/conf /mnt/
cp -a /opt/activemq/data /mnt/

docker exec -ti -u root activemq1 bash
```

```shell
docker run -p 61616:61616 -p 8161:8161 \
--name activemq --restart unless-stopped \
rmohr/activemq
```





```shell
docker run -d --name=bilibili-helper-hyb --restart unless-stopped -v /appdata/bilibili-hyb-config:/config  superng6/bilibili-helper:latest
```

`epic`

```shell
docker run -it --name epic -e TZ=Asia/Shanghai --restart unless-stopped -v /appdata/epic:/User_Data luminoleon/epicgames-claimer -r 10:30 -a -ps SCT42461T86ZEIJOoskFirJMdmXboRFYX 
```



```shell
docker run -e PARAMS="--spring.datasource.url=jdbc:mysql://47.114.105.19:8888/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" -e PARAMS="--spring.datasource.username=root" -e PARAMS="--spring.datasource.password=123456" -e PARAMS="--spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver" -p 8080:8080 -v /appdata/xxl-job-log:/data/applogs --name xxl-job-admin02  -d xuxueli/xxl-job-admin:2.3.0
```

`阿里云挂载服务`

```shell
docker run -d --name=webdav-aliyundriver --restart=always -p 8787:8080 -v /appdata/aliyundriver/aliyundriver:/etc/aliyun-driver/ -e TZ="Asia/Shanghai" -e ALIYUNDRIVE_REFRESH_TOKEN="4479b0f29d3945cdb277dd731364820e" -e ALIYUNDRIVE_AUTH_PASSWORD="tangcs123" -e JAVA_OPTS="-Xmx1g" zx5253/webdav-aliyundriver

java -jar webdav.jar --aliyundrive.refresh-token="b18b8b24bad34b7880166cc91fa56eb4"

# /etc/aliyun-driver/ 挂载卷自动维护了最新的refreshToken，建议挂载
# ALIYUNDRIVE_AUTH_PASSWORD 是admin账户的密码，建议修改
# JAVA_OPTS 可修改最大内存占用，比如 -e JAVA_OPTS="-Xmx512m" 表示最大内存限制为512m

```





```json
6011&0001&330106&11606501137138&19.375&3.324&0.0&19.625&0.0&0.0&19.8125&0.0&0.0&19.875&0.0&0.0&19.8125&0.0&0.0&1636549200001
```









```json
{"default_sbox_drive_id":"1354942","role":"user","user_name":"157***417","need_link":false,"expire_time":"2021-11-15T08:06:58Z","pin_setup":false,"need_rp_verify":false,"avatar":"","token_type":"Bearer","access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhNzhhOTZhODRlNTE0Y2Y3ODFhOGNlMTJjNDc3ZTUwOCIsImN1c3RvbUpzb24iOiJ7XCJjbGllbnRJZFwiOlwiMjVkelgzdmJZcWt0Vnh5WFwiLFwiZG9tYWluSWRcIjpcImJqMjlcIixcInNjb3BlXCI6W1wiRFJJVkUuQUxMXCIsXCJTSEFSRS5BTExcIixcIkZJTEUuQUxMXCIsXCJVU0VSLkFMTFwiLFwiU1RPUkFHRS5BTExcIixcIlNUT1JBR0VGSUxFLkxJU1RcIixcIkJBVENIXCIsXCJPQVVUSC5BTExcIixcIklNQUdFLkFMTFwiLFwiSU5WSVRFLkFMTFwiLFwiQUNDT1VOVC5BTExcIl0sXCJyb2xlXCI6XCJ1c2VyXCIsXCJyZWZcIjpcImh0dHBzOi8vd3d3LmFsaXl1bmRyaXZlLmNvbS9cIn0iLCJleHAiOjE2MzY5NjM2MTgsImlhdCI6MTYzNjk1NjM1OH0.QprsOQkvBFqJypicIXpgbnCYNwEpif-BtA2ZaZSQYGnK-_oAyt1rkCbio-V6DOiEcHdNrL1yNY8JBVBDcjaGr-3hefMo7GzAWaPW8cK985Bq81ExH4z_uSh3PqAnonfAsNHCSbHgt4Zttg4kKD4bvlSWLiiN9fHvJbgiodtLdac","default_drive_id":"1354941","domain_id":"bj29","refresh_token":"4479b0f29d3945cdb277dd731364820e","is_first_login":false,"user_id":"a78a96a84e514cf781a8ce12c477e508","nick_name":"","exist_link":[],"state":"","expires_in":7200,"status":"enabled"}}
```





`白名单`

```shell
ALTER TABLE `bladex`.`blade_user` 
ADD COLUMN `is_whitelist` int(2) NULL DEFAULT 1 COMMENT '是否跳过白名单 0-不跳过 1-跳过' AFTER `is_deleted`;
-- 数据字典
INSERT INTO `bladex`.`blade_dict_biz` (`id`, `tenant_id`, `parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_sealed`, `is_deleted`) VALUES (1397748968827367426, '000000', 0, 'ship_whitelist', '-1', '白名单验证', 65, '', 0, 0);
INSERT INTO `bladex`.`blade_dict_biz` (`id`, `tenant_id`, `parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_sealed`, `is_deleted`) VALUES (1397749078541971458, '000000', 1397748968827367426, 'ship_whitelist', '1', '是', 1, '', 0, 0);
INSERT INTO `bladex`.`blade_dict_biz` (`id`, `tenant_id`, `parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_sealed`, `is_deleted`) VALUES (1397749140026273793, '000000', 1397748968827367426, 'ship_whitelist', '0', '否', 0, '', 0, 0);

```





























```sql

CREATE TABLE `device_e` (
  `id` char(36) NOT NULL COMMENT '主键ID',
  `city_code` varchar(16) DEFAULT NULL COMMENT '所属城市',
  `region_code` varchar(16) DEFAULT NULL COMMENT '所在行政区',
  `zone_id` varchar(36) NOT NULL COMMENT '片区id',
  `sn` varchar(64) DEFAULT NULL COMMENT '设备序列号',
  `alias` varchar(64) DEFAULT NULL COMMENT '设备别名',
  `type` varchar(16) DEFAULT NULL COMMENT '设备类型',
  `series` varchar(64) DEFAULT NULL COMMENT '设备系列',
  `address` varchar(64) DEFAULT NULL COMMENT '详细地址',
  `series` varchar(64) DEFAULT NULL COMMENT '设备系列',
  `lat` decimal(10,6) DEFAULT NULL COMMENT '经度',
  `lng` decimal(10,6) DEFAULT NULL COMMENT '纬度',
  `status` varchar(16) DEFAULT NULL COMMENT '设备状态 ',
  `create_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_user` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='e生态设备表';


CREATE TABLE `proj_e_data` (
  `id` varchar(36) NOT NULL COMMENT '主键ID,GUID',
  `sn` varchar(50) DEFAULT NULL COMMENT '设备编号',
  `surface_temperature` float(53) DEFAULT NULL COMMENT '地表-土壤温度',
  `surface_battery` float(53) DEFAULT NULL COMMENT '地表-电池电量',
  `surface_outside_voltage` float(53) DEFAULT NULL COMMENT '地表-外部输入电压',
    `ten_temperature` float(53) DEFAULT NULL COMMENT '10cm-土壤温度',
    `ten_water` float(53) DEFAULT NULL COMMENT '10cm-水分含量',
    `ten_salt` float(53) DEFAULT NULL COMMENT '10cm-盐分含量',
    `twenty_temperature` float(53) DEFAULT NULL COMMENT '20cm-土壤温度',
    `twenty_water` float(53) DEFAULT NULL COMMENT '20cm-水分含量',
    `twenty_salt` float(53) DEFAULT NULL COMMENT '20cm-盐分含量',
    `thirty_temperature` float(53) DEFAULT NULL COMMENT '30cm-土壤温度',
    `thirty_water` float(53) DEFAULT NULL COMMENT '30cm-水分含量',
    `thirty_salt` float(53) DEFAULT NULL COMMENT '30cm-盐分含量',
    `forty_temperature` float(53) DEFAULT NULL COMMENT '40cm-土壤温度',
    `forty_water` float(53) DEFAULT NULL COMMENT '40cm-水分含量',
    `forty_salt` float(53) DEFAULT NULL COMMENT '40cm-盐分含量',
  `collect_time` datetime DEFAULT NULL COMMENT '采集时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='e生态传感器原始数据';
```

