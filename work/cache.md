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





```
3001000052000000006000018443aa0028150308152831100104b06000018414600001840812100000170017
```



ddd

```shell
shshshfpa=f90fc459-6547-9c33-293b-1fe55a973987-1616674800; shshshfpb=h0SM8dO2UGLbGze7ASLtTGg%3D%3D; webp=1; visitkey=1181879200414015; unpl=V2_ZzNtbRAAR0YlDU5VKxlYVWJTEF1KVRMQdwwRAHxLW1dlAkYIclRCFnUURlRnGF8UZwEZWEJcQxVFCEdkexhdBGYKGlRKVXMVcQ8oVRUZVQAJbRZcQFJKHXdbQQEsTV1QMlcibUFXcxRFCEFWeBxaAmULF1tEVEMXdglCUXoeVQNXMxJVRmdDFHQJRlVyG1UAYgQiiuv5lZnT3P%2f%2brKveNWMFEVtGVkIUdjhHZHopCmtnAhNcQ1ZAEXUAC1R8G18AYQQQVUdRRRZ1CkVVfxxdAm4FIlxyVA%3d%3d; wxa_level=1; retina=0; jxsid=16379203388059685000; autoOpenApp_downCloseDate_auto=1637920339983_1800000; jcap_dvzw_fp=2qLAydWuGel48uyxA5aZNb4mQ9vdGzlWnjOqCRhnRO8KZrTPBh-Ew6mxDA0nt3Nypt_hZA==; TrackerID=QxjdwsanduXoTEloz3PHc4P2Mh4PxcigArC7GyJ6vnz9f38JMIYi6bK5xv2z57NJ202fa43cuaXIqmMAAtNZ6XweWP7QygbNv_GTL0l391g; pt_key=AAJhoK52ADB9d_58DDvhBVwkifC89YrrBIofBlXgSHt3_NCMEWtvTnx-3gFAyANRfARjfZB1icA; pt_pin=jd_646a8d337de18; pt_token=u2k4q8tn; pwdt_id=jd_646a8d337de18; sfstoken=tk01mc0e81bdfa8sM3gxeDMrMSsybnFp1yyOipFgjqG024Pd7tDt8k+V5+EuV3lNpbnKo14LXfOUyP157VHwl7FBsIKJ; whwswswws=; cid=9; __wga=1637920376717.1637920376717.1633931508993.1633931508993.1.2; __jdv=122270672%7Cdirect%7C-%7Cnone%7C-%7C1637920376720; PPRD_P=UUID.16324763947721320540687; __jda=122270672.16324763947721320540687.1632476394.1635831658.1637920376.10; share_cpin=; share_open_id=; share_gpin=; shareChannel=; source_module=; erp=; jxsid_s_t=1637920376763; jxsid_s_u=https%3A//home.m.jd.com/myJd/newhome.action; sc_width=1920; shshshfp=7f33cd39d910864014d50e6c077b9aa5; shshshsID=b1543c0c21154b5d794572728fa43e36_2_1637920376917; cartLastOpTime=1637920390; cartNum=23; wqmnx1=MDEyNjM4MnRtL3JudmV4NzAwNzBsV04geGwvKGxrbTRTMzIyZjRRQyMmJQ%3D%3D; kplTitleShow=1
```

```
hyb的key
pt_key=AAJhpzWAADCwQTZv271TH2dJr1tomST8kmofQ10W_A-UkiRE1Z1TUtAo45kZ8zTeM_RBNwiAUUc; pt_pin=jd_4234a7c246fdd
```

hh的key

```shell
shshshfpa=24da72b7-9be9-598f-6325-fc1a51f10464-1605417917; shshshfpb=pJupd3jbnju%2FqGLUas1DOIA%3D%3D; pinId=7OwJxo0hX_fjM7Zq4yEmkLV9-x-f3wj7; TrackID=1fKjCrlbTCg8CuuyTS9RPQ87cCCHRilAsJ_FzH4xlM_E5sXfePks9x1hBxJIlE3254KApx2n9aLNgnP8BUzm4xBu0KAiGxeCQ4_1alabOgVY; 3AB9D23F7A4B3C9B=SD7ZKBXPRXKZSZAV74I6ABBF564WDZ5A23EYQ3HABO2ENCVCCCBVLI4OXB5HKGOZU5BNOFEHRMDVLANBTOBOHWOZ7M; jcap_dvzw_fp=pZuqCXoE_-3fQV9jqLUKcxpYkQjBZhbEaPWbbECruzSV_rBAz4ICRMiauViPSmx3wo9Zww==; TrackerID=timipmwgsZwHTpfzt6CMhwzsMPUa3Bxgo6a8mnu-3vU5mGJtQ-_XfN-jmtEGuN0NsPROQpxpLGeSfUBPYoQpe0-trpAh_BUsi21TEPbARoo; pt_key=AAJhriW-ADAKSbvzmx1VfuaxrkmgJN6HJn1FYLm3oVu2TCpX-A4hj9a0qn63OcCwa1Hn5zp1meg; pt_pin=jd_BoJNZZFoVmLT; pt_token=pyuqrpdn; pwdt_id=jd_BoJNZZFoVmLT; sfstoken=tk01m9bc41b04a8sMngyeDE5MGh6qMhwlQNKzBLrPQZwWQrWOX+5H4cTA9VQX+94Vt7qZH05C7I38pG7iaj+qXkY/6rg; whwswswws=; wxa_level=1; retina=0; cid=9; jxsid=16388028794166176695; webp=1; visitkey=6374113032724414; __jdv=122270672%7Cdirect%7C-%7Cnone%7C-%7C1638802879832; PPRD_P=UUID.1615010680949239767254; __jda=122270672.1615010680949239767254.1615010681.1635869017.1638802879.6; sc_width=1920; shshshfp=72c1cdda02765fe48a055c228972df66; jxsid_s_u=https%3A//home.m.jd.com/myJd/newhome.action; __wga=1638802935504.1638802879824.1638802879824.1638802879824.4.1; jxsid_s_t=1638802935642; shshshsID=1a03aef1f6ecddf70f7692fe97de8d92_5_1638802936469; cartLastOpTime=1638802966; cartNum=3; wqmnx1=MDEyNjM4MXQubWFvYW5qMzQ5MTRsKCA7IHB0ICBjby4gNTRmVTJWTykoKQ%3D%3D; kplTitleShow=1
```



```
Collectors  [kə'lektəz] kelaiketesi

```





plus+ token：55bae7f54bb7418aa31cda718186299e





v2ex

```shell
docker run --restart=always -d  -e  --name v2ex v2ex_cookies='A2="2|1:0|10:1633923446|2:A2|48:OGY5ZmIyMmItOGU1Ni00ZTVjLWI0MWUtNjc2MTkxYTQzNWZh|529cacefc44b97710caed7760a6c9cb9e13cb66fc17f5a1af7e9cb84396137ba"; V2EX_LANG=zhcn; V2EX_REFERRER="2|1:0|10:1638416291|13:V2EX_REFERRER|12:YmFpc2hpNzMy|8b84e4d092fdfe1fe65237b035ec737979dfa6e8792a3057a4e6fe17de8c66c3"' mysqto/v2ex
```







http://192.168.1.248:1888/api/shengting-aco/specialspecies/export-species?Blade-Auth=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRfaWQiOiIwMDAwMDAiLCJ1c2VyX25hbWUiOiJuZXVzZW5zZSIsInJlYWxfbmFtZSI6IueuoeeQhuWRmCIsImF2YXRhciI6IiIsImF1dGhvcml0aWVzIjpbImFkbWluaXN0cmF0b3IiXSwiY2xpZW50X2lkIjoic2FiZXIiLCJyb2xlX25hbWUiOiJhZG1pbmlzdHJhdG9yIiwibGljZW5zZSI6InBvd2VyZWQgYnkgYmxhZGV4IiwicG9zdF9pZCI6IjExMjM1OTg4MTc3Mzg2NzUyMDEiLCJ1c2VyX2lkIjoiMTEyMzU5ODgyMTczODY3NTIwMSIsInJvbGVfaWQiOiIxMTIzNTk4ODE2NzM4Njc1MjAxIiwic2NvcGUiOlsiYWxsIl0sIm5pY2tfbmFtZSI6IueuoeeQhuWRmCIsIm9hdXRoX2lkIjoiIiwiZGV0YWlsIjp7InR5cGUiOiJ3ZWIiLCJtZW51TW9kZSI6MiwiaXNGb3JjZVB3ZCI6MCwicGhvbmUiOiIxMjMzMzMzMzMzMzMiLCJyZWdpb25Db2RlIjoiMzMifSwiZXhwIjoxNjM4MjQ3NDM2LCJkZXB0X2lkIjoiMTEyMzU5ODgxMzczODY3NTIwMSIsImp0aSI6IjhlMTFlOTQwLTk1NTQtNGFiZS04MjY2LThhYmQ4NzUxNzMwNyIsImFjY291bnQiOiJuZXVzZW5zZSJ9.odf9BXldXJsjYlxDGN1-nxQdCeAloLAAxkQi6vJXtK4&name=&level=1











```
aco_sec_manage:结果录入
ap_hunt_team_regulation:组织实施

```





'pt_key=AAJhoK52ADB9d_58DDvhBVwkifC89YrrBIofBlXgSHt3_NCMEWtvTnx-3gFAyANRfARjfZB1icA; pt_pin=jd_646a8d337de18;',//账号一ck,例:pt_key=XXX;pt_pin=XXX;

 'pt_key=AAJhpL0NADCErDaMrtm4DMjCR6OLFkdq8hJ0BeOC8lvFpEq3DaoFVeEgmiucXoScPK1TOAnBffY; pt_pin=a925017215;',//账号二ck,例:pt_key=XXX;pt_pin=XXX;如有更多,依次类推









