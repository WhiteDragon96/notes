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

### DOCKER启动

#### `activeMQ`

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



#### bilibili

```shell
docker run -d --name=bilibili-helper-hyb --restart unless-stopped -v /appdata/bilibili-hyb-config:/config  superng6/bilibili-helper:latest
```

#### `epic`

```shell
docker run -it --name epic -e TZ=Asia/Shanghai --restart unless-stopped -v /appdata/epic:/User_Data luminoleon/epicgames-claimer -r 10:30 -a -ps SCT42461T86ZEIJOoskFirJMdmXboRFYX 
```

#### xxx-job

```shell
docker run -e PARAMS="--spring.datasource.url=jdbc:mysql://47.114.105.19:8888/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" -e PARAMS="--spring.datasource.username=root" -e PARAMS="--spring.datasource.password=123456" -e PARAMS="--spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver" -p 8080:8080 -v /appdata/xxl-job-log:/data/applogs --name xxl-job-admin02  -d xuxueli/xxl-job-admin:2.3.0
```

#### `阿里云挂载服务`

```shell
docker run -d --name=aliyundrive-webdav --restart=unless-stopped -p 6677:8080 \
  -v /appdata/aliyundriver/:/etc/aliyundrive-webdav/ \
  -e REFRESH_TOKEN='53a0456aacc849dfb7743ebfe75b6149' \
  -e WEBDAV_AUTH_USER=tangcs \
  -e WEBDAV_AUTH_PASSWORD=tangcs123 \
  messense/aliyundrive-webdav

java -jar webdav.jar --aliyundrive.refresh-token="b18b8b24bad34b7880166cc91fa56eb4"

# /etc/aliyun-driver/ 挂载卷自动维护了最新的refreshToken，建议挂载
# ALIYUNDRIVE_AUTH_PASSWORD 是admin账户的密码，建议修改
# JAVA_OPTS 可修改最大内存占用，比如 -e JAVA_OPTS="-Xmx512m" 表示最大内存限制为512m

```

#### 数据库

```
docker run -d -p 3305:3306 -v /appdata/mysql/conf:/etc/mysql/conf.d -v /appdata/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=T@ng7167451959  --name mysql001 mysql:5.7.32

--version 8
docker run -d -p 3304:3306 -v /appdata/mysql8/conf:/etc/mysql/conf.d -v /appdata/mysql8/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=T@ng7167451959  --name mysql8 mysql:8
```

#### redis

```
docker run -p 6379:6379 --name redis -v /appdata/redis/conf/redis.conf:/etc/redis/redis.conf -v /appdata/redis/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes
```

#### testspeed

```
docker run -d --name testspeed -p 9001:80 -it badapple9/speedtest-x
```

#### nginx

```shell
docker run --name nginx -p 80:80 -v /appdata/nginx/nginx.conf:/etc/nginx/nginx.conf -v /appdata/nginx/log:/var/log/nginx -v /appdata/nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf -v /appdata/nginx/html:/usr/share/nginx/html -d nginx
```

#### Jenkins

```
docker run -p 8484:8080 -p 50000:50000 --name jenkins -d -v /appdata/jenkins_data:/var/jenkins_home jenkinsci/blueocean
```



#### Nacos

```shell
docker  run \
--name nacos -d \
-p 28848:8848 \
--privileged=true \
--restart=always \
-e SPRING_DATASOURCE_PLATFORM=mysql \
-e MYSQL_SERVICE_HOST=119.91.204.244 \
-e MYSQL_SERVICE_PORT=3305 \
-e MYSQL_SERVICE_DB_NAME=nacos \
-e MYSQL_SERVICE_USER=root \
-e MYSQL_SERVICE_PASSWORD=T@ng7167451959 \
-e JVM_XMS=256m \
-e JVM_XMX=256m \
-e MODE=standalone \
-e PREFER_HOST_MODE=hostname \
-v /mydata/nacos/logs:/home/nacos/logs \
-v /mydata/nacos/init.d/custom.properties:/home/nacos/init.d/custom.properties \
nacos/nacos-server
```

#### 为知笔记

```shell
docker run --name wiz --restart=always -it -d -v  appdata/wizdata:/wiz/storage -v  /etc/localtime:/etc/localtime -p 5757:80 -p 9269:9269/udp  wiznote/wizserver
```

#### OneDev

```shell
docker run --name onedev -d --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /appdata/onedev:/opt/onedev -p 6610:6610 -p 6611:6611 1dev/server
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









server {
        listen       8080;
        server_name  localhost;
        charset utf-8;
	location /api/ {
	    proxy_pass http://127.0.0.1:80/;
	}
	location / { 
	    proxy_pass http://localhost:8888;
	}
	/ /baiduapi/ {
        proxy_pass https://www.baidu.com/;
    }
    }

















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

































```shell
mvn install:install-file -DgroupId=gn -DartifactId=GNCalendar -Dversion=v1.0 -Dpackaging=jar -Dfile=C:\Users\neu\Downloads\springboot-javafx-app-demo-master\springboot-javafx-app-demo-master\lib\GNCalendar-1.0-alpha.jar

mvn install:install-file -DgroupId=gn -DartifactId=GNButton -Dversion=v1.1.0 -Dpackaging=jar -Dfile=C:\Users\neu\Downloads\springboot-javafx-app-demo-master\springboot-javafx-app-demo-master\lib\GNButton-1.1.0.jar

mvn install:install-file -DgroupId=gn -DartifactId=GNCarousel -Dversion=v2.1.5 -Dpackaging=jar -Dfile=C:\Users\neu\Downloads\springboot-javafx-app-demo-master\springboot-javafx-app-demo-master\lib\GNCarousel-2.1.5.jar

mvn install:install-file -DgroupId=gn -DartifactId=GNDecorator -Dversion=v2.1.2-alpha -Dpackaging=jar -Dfile=C:\Users\neu\Downloads\springboot-javafx-app-demo-master\springboot-javafx-app-demo-master\lib\GNDecorator-2.1.2-alpha.jar

mvn install:install-file -DgroupId=gn -DartifactId=GNAvatarView -Dversion=v1.0-rc -Dpackaging=jar -Dfile=C:\Users\neu\Downloads\springboot-javafx-app-demo-master\springboot-javafx-app-demo-master\lib\GNAvatarView-1.0-rc.jar


```







```
git log  --format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat:  --since ==2021-12-14 --until=2021-12-15 --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -; done

git log --since="2020-12-13" --before="2021-12-15" --author="$(git config --get user.name)" --pretty=tformat: --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }'
```



美团token

```shell
uuid=935ad24214d44dd1a812.1639480339.1.0.0; __mta=51140118.1639480341689.1639480341689.1639480341689.1; webloc_geo=30.33075%2C120.102222%2Cwgs84; ci=50; mtcdn=K; userTicket=kbTIybkkreYHXWJqCvAJHfqUboHWCWRloIKGgXrE; _yoda_verify_resp=gzu%2FWzTu7F6ZKiw%2BN%2FQx9ci92LZZga7GouWi1fk04Csi5Ozf%2Bvo6uPKDX2lg%2BiJNe0gbs%2B5yB4Ik5hQO4TyqZ1B7X2gFXpPCNmtEzRuGf463fnu7cAdnTLVA0%2BMY0vaGcMp6%2FzewgC2IbRsnthUxeWbfQ%2FbCgT%2Fwk3tKjEmw5x%2FErvz78g%2FlbBicfFwnonfBaNwZH%2FX34%2Bmm7aJMmdGHKnLSnlpRxN0qL16TcOpYpMUOGMSiM3kYbiVE%2BMp7BYdvCZjzRxwHCzKxMmWOnXW4f%2BnDaj7pYzCo8borjoPvYUTJrlVt1jF7BEsxTdKsQ%2F1cVH9wI9gzDR5JfEVCJz08Aw%3D%3D; _yoda_verify_rid=146906406081805d; u=250387189; n=WhiteDra; lt=KoS1icdlVOAD6pEWDNUKUF_3wtMAAAAAhA8AAE7tyhbBg4bn3ewwXgOvLjiJSopelcuFeEcwU_J6IYVngbmZg8Q4VNMvKcE-WvPnRg; mt_c_token=KoS1icdlVOAD6pEWDNUKUF_3wtMAAAAAhA8AAE7tyhbBg4bn3ewwXgOvLjiJSopelcuFeEcwU_J6IYVngbmZg8Q4VNMvKcE-WvPnRg; token=KoS1icdlVOAD6pEWDNUKUF_3wtMAAAAAhA8AAE7tyhbBg4bn3ewwXgOvLjiJSopelcuFeEcwU_J6IYVngbmZg8Q4VNMvKcE-WvPnRg; lsu=; token2=KoS1icdlVOAD6pEWDNUKUF_3wtMAAAAAhA8AAE7tyhbBg4bn3ewwXgOvLjiJSopelcuFeEcwU_J6IYVngbmZg8Q4VNMvKcE-WvPnRg; unc=WhiteDra; firstTime=1639480444410
```



```shell

https://api.telegram.org/bot''5089106240:AAHA7xpH8rMnZEe2-R_gUmAT3QQwrodCahY''/getupdates
```

```shell
acw_tc=2f6a1f9416395373820334210e12baaf4765dc3406a4ae1967ca546b32299b; i18n_redirected=zh_CN; newopkey=UC3ED6yt1DFJOZQuAUD4C2cEcZl8RpB8C1jTgdkX8q2TmdqeoeQuV8IdspRclwQQl37e3wYAQeM; sa_distinct_id=RFlrek9FdUF2bktsaGdKaHg0NTk0Zz09; NEWOPPOSID=eyJpdiI6Iko2emFEcFZxRGxpK0kwakNpSVF2eHc9PSIsInZhbHVlIjoiTGV2dDZzdGRUT0FOSWJBZUhVMlR0TWJuVWE3UUo5WHE0RWdzQml3ck1zaEszWDlQTCtBUi8xZytJUTdza2x5dXZOQmwycW5CYzBnU0xLNXlWZWFFdUpFVVBoQ2ZjRDhFaUt3SDBGMWljMUhlVDZ2K0ZhcUxXOU1tRWlPL0ZTSWoiLCJtYWMiOiIyYzA2MjRkYjE5NjM5ZTAzOTNjZDU2MzlmNjAxZmUyNGQ4MGU2ZmMzNTUwYTM4OWE0OGJlODFmZWMwNzlkNGVjIn0=; sa_distinct_id=RFlrek9FdUF2bktsaGdKaHg0NTk0Zz09; source_type=504; s_channel=h5_web; is_login=false; utm_source=direct; utm_medium=direct; utm_campaign=direct; utm_term=direct; us=direct; um=direct; uc=direct; ut=direct


source_type=504;TOKENSID=eyJpdiI6Iko2emFEcFZxRGxpK0kwakNpSVF2eHc9PSIsInZhbHVlIjoiTGV2dDZzdGRUT0FOSWJBZUhVMlR0TWJuVWE3UUo5WHE0RWdzQml3ck1zaEszWDlQTCtBUi8xZytJUTdza2x5dXZOQmwycW5CYzBnU0xLNXlWZWFFdUpFVVBoQ2ZjRDhFaUt3SDBGMWljMUhlVDZ2K0ZhcUxXOU1tRWlPL0ZTSWoiLCJtYWMiOiIyYzA2MjRkYjE5NjM5ZTAzOTNjZDU2MzlmNjAxZmUyNGQ4MGU2ZmMzNTUwYTM4OWE0OGJlODFmZWMwNzlkNGVjIn0=;app_param=xxx;
```





鸟岛数据sql

```sql
CREATE TABLE `daq_soil` (
	`id` BIGINT ( 64 ) NOT NULL COMMENT '主键id',
	`env_eq_id` BIGINT ( 64 ) DEFAULT NULL COMMENT '设备编号',
	`zone_id` BIGINT ( 64 ) DEFAULT NULL COMMENT '区域',
	`surface_temperature` double DEFAULT NULL COMMENT '地表-土壤温度',
 	 `surface_battery` double DEFAULT NULL COMMENT '地表-电池电量',
	  `surface_outside_voltage` double DEFAULT NULL COMMENT '地表-外部输入电压',
 	 `ten_temperature` double DEFAULT NULL COMMENT '10cm-土壤温度',
 	 `ten_water` double DEFAULT NULL COMMENT '10cm-水分含量',
 	 `ten_salt` double DEFAULT NULL COMMENT '10cm-盐分含量',
 	 `twenty_temperature` double DEFAULT NULL COMMENT '20cm-土壤温度',
 	 `twenty_water` double DEFAULT NULL COMMENT '20cm-水分含量',
 	 `twenty_salt` double DEFAULT NULL COMMENT '20cm-盐分含量',
 	 `thirty_temperature` double DEFAULT NULL COMMENT '30cm-土壤温度',
 	 `thirty_water` double DEFAULT NULL COMMENT '30cm-水分含量',
	  `thirty_salt` double DEFAULT NULL COMMENT '30cm-盐分含量',
 	 `forty_temperature` double DEFAULT NULL COMMENT '40cm-土壤温度',
 	 `forty_water` double DEFAULT NULL COMMENT '40cm-水分含量',
 	 `forty_salt` double DEFAULT NULL COMMENT '40cm-盐分含量',
	`event_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '事件时间',
	`create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`is_deleted` INT ( 2 ) NOT NULL DEFAULT '0' COMMENT '0未删除 1已删除',
	`update_user` BIGINT ( 10 ) DEFAULT NULL COMMENT '更新人',
	`create_user` BIGINT ( 10 ) DEFAULT NULL COMMENT '创建人',
	`create_dept` BIGINT ( 10 ) DEFAULT NULL COMMENT '创建部门',
	`status` INT ( 2 ) DEFAULT NULL COMMENT '状态',
PRIMARY KEY ( `id` ) USING BTREE 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '土壤监测数据实时';
```





```
{
    "notifyUrl": "http://ecology.admin.neusense.cn/data/e/data/notice",
    "lastModified": "2021-11-16 16:11:29",
    "message": "ok"
}
```



```shell
CREATE TABLE `proj_e_data` (
  `id` varchar(36) NOT NULL COMMENT '主键ID,GUID',
  `sn` varchar(50) DEFAULT NULL COMMENT '设备编号',
  `city_code` varchar(16) DEFAULT NULL COMMENT '所属城市',
  `region_code` varchar(16) DEFAULT NULL COMMENT '所在行政区',
  `zone_id` varchar(36) DEFAULT NULL COMMENT '片区id',
  `air_temperature` double DEFAULT NULL COMMENT '空气温度',
  `battery` double DEFAULT NULL COMMENT '电池电量',
  `outside_voltage` double DEFAULT NULL COMMENT '外部输入电压',
  `relative_humidity` double DEFAULT NULL COMMENT '相对湿度',
  `dew_point` double DEFAULT NULL COMMENT '露点',
  `atmospheric_pressure` double DEFAULT NULL COMMENT '大气压',
  `max_wind_speed` double DEFAULT NULL COMMENT '最大风速',
  `wind_speed` double DEFAULT NULL COMMENT '风速',
  `wind_direction` double DEFAULT NULL COMMENT '风向',
  `rainfall` double DEFAULT NULL COMMENT '雨量',
  `rain_daily` double DEFAULT NULL COMMENT '当天累计雨量',
  `solarRadiationIntensity` double DEFAULT NULL COMMENT '太阳辐射',
  `solarRadiationAmount` double DEFAULT NULL COMMENT '累计太阳辐射',
  `pm2` double DEFAULT NULL COMMENT 'pm2.5',
  `pm10` double DEFAULT NULL COMMENT 'PM10',
  `tvoc` double DEFAULT NULL COMMENT 'TVOC含量',
  `collect_time` bigint(20) DEFAULT NULL COMMENT '采集时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='e生态气象传感器原始数据';
```



```
CREATE TABLE `daq_environment` (
  `id` bigint(64) NOT NULL COMMENT '主键id',
  `env_eq_id` bigint(64) DEFAULT NULL COMMENT '设备编号',
  `zone_id` bigint(64) DEFAULT NULL COMMENT '区域',
`air_temperature` double DEFAULT NULL COMMENT '空气温度',
  `battery` double DEFAULT NULL COMMENT '电池电量',
  `outside_voltage` double DEFAULT NULL COMMENT '外部输入电压',
  `relative_humidity` double DEFAULT NULL COMMENT '相对湿度',
  `dew_point` double DEFAULT NULL COMMENT '露点',
  `atmospheric_pressure` double DEFAULT NULL COMMENT '大气压',
  `max_wind_speed` double DEFAULT NULL COMMENT '最大风速',
  `wind_speed` double DEFAULT NULL COMMENT '风速',
  `wind_direction` double DEFAULT NULL COMMENT '风向',
  `rainfall` double DEFAULT NULL COMMENT '雨量',
  `rain_daily` double DEFAULT NULL COMMENT '当天累计雨量',
  `solarRadiationIntensity` double DEFAULT NULL COMMENT '太阳辐射',
  `solarRadiationAmount` double DEFAULT NULL COMMENT '累计太阳辐射',
  `pm2` double DEFAULT NULL COMMENT 'pm2.5',
  `pm10` double DEFAULT NULL COMMENT 'PM10',
  `tvoc` double DEFAULT NULL COMMENT 'TVOC含量',
  `event_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '事件时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int(2) NOT NULL DEFAULT '0' COMMENT '0未删除 1已删除',
  `update_user` bigint(10) DEFAULT NULL COMMENT '更新人',
  `create_user` bigint(10) DEFAULT NULL COMMENT '创建人',
  `create_dept` bigint(10) DEFAULT NULL COMMENT '创建部门',
  `status` int(2) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='气象监测数据实时';
```







```
气象
[{"data":{"地表":{"44":{"symbol":"mm","name":"雨量","value":"0.0"},"45":{"symbol":"W/m²","name":"当前太阳辐射强度","value":"370.1"},"46":{"symbol":"MJ/m²","name":"累计太阳辐射量","value":"4.814"},"36":{"symbol":"%","name":"相对湿度","value":"34.13"},"37":{"symbol":"℃","name":"露点","value":"-10.27"},"38":{"symbol":"hPa","name":"大气压力","value":"1023.97"},"192":{"symbol":"ug/m3","name":"PM2.5浓度","value":"3.0"},"193":{"symbol":"ug/m3","name":"PM10浓度","value":"3.0"},"104":{"symbol":"mm","name":"当天累计雨量","value":"0.0"},"206":{"symbol":"ppb","name":"TVOC含量","value":"60000.0"},"92":{"symbol":"℃","name":"空气温度","value":"4.18"},"50":{"symbol":"v","name":"电池电量","value":"3.523"},"40":{"symbol":"m/s","name":"最大风速","value":"2.56"},"41":{"symbol":"m/s","name":"风速","value":"2.27"},"42":{"symbol":"°","name":"风向","value":"169.0"},"54":{"symbol":"v","name":"外部输入电压","value":"8.809"}}},"sn":"21606705124302","collect_time":1639717200000}]
//土壤
[{"data":{"30cm":{"34":{"symbol":"℃","name":"土壤温度","value":"12.8125"},"82":{"symbol":"%","name":"水分含量","value":"26.56"},"83":{"symbol":"μS/cm","name":"盐分含量","value":"1347.48"}},"地表":{"34":{"symbol":"℃","name":"土壤温度","value":"12.3125"},"50":{"symbol":"v","name":"电池电量","value":"3.564"},"54":{"symbol":"v","name":"外部输入电压","value":"7.353"}},"10cm":{"34":{"symbol":"℃","name":"土壤温度","value":"11.25"},"82":{"symbol":"%","name":"水分含量","value":"26.65"},"83":{"symbol":"μS/cm","name":"盐分含量","value":"1281.91"}},"40cm":{"34":{"symbol":"℃","name":"土壤温度","value":"13.1875"},"82":{"symbol":"%","name":"水分含量","value":"27.42"},"83":{"symbol":"μS/cm","name":"盐分含量","value":"1267.95"}},"20cm":{"34":{"symbol":"℃","name":"土壤温度","value":"12.3125"},"82":{"symbol":"%","name":"水分含量","value":"25.89"},"83":{"symbol":"μS/cm","name":"盐分含量","value":"1352.62"}}},"sn":"11606501137138","collect_time":1639717200000}]
```







```
7B300100017765432197654321943AA0027150A0D122B1800010100765432190A765432190A010100283900BE2E000000DD08000000000000DC2F7D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
```

```sql
最后一条CO2
ALTER TABLE `ecology_data`.`mon_last_co2_data` 
MODIFY COLUMN `co2_concentration` int(5) NULL DEFAULT NULL COMMENT '二氧化碳浓度（0～2000ppm）1位小数' AFTER `msg_type`;




ALTER TABLE `ecology_data`.`proj_co2_data` 
MODIFY COLUMN `co2_concentration` decimal(5, 1) NULL DEFAULT NULL COMMENT '二氧化碳浓度（0～2000ppm）1位小数' AFTER `msg_type`;
ALTER TABLE `ecology_data`.`mon_last_co2_data` 
MODIFY COLUMN `co2_concentration` decimal(6, 1) NULL DEFAULT NULL COMMENT '二氧化碳浓度（0～2000ppm）1位小数' AFTER `msg_type`;


DROP TABLE mon_last_co2_data ;
DROP TABLE proj_co2_data ;

CREATE TABLE `mon_last_co2_data` (
  `id` char(36) NOT NULL COMMENT '主键id',
  `city_code` int(11) NOT NULL COMMENT '所属城市',
  `region_code` int(11) NOT NULL COMMENT '所在行政区',
  `zone_id` char(36) NOT NULL COMMENT '片区id',
  `sensor_code` varchar(50) NOT NULL COMMENT '设备编号',
  `gateway_name` varchar(32) NOT NULL COMMENT '网关名称',
  `device_type` int(2) DEFAULT NULL COMMENT '设备类型',
  `address` varchar(100) NOT NULL COMMENT '传感器地址',
  `sensor_type` int(2) DEFAULT NULL COMMENT '传感器类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `receive_time` datetime NOT NULL COMMENT '接收时间',
  `version_soft` varchar(10) DEFAULT NULL COMMENT '软件版本， 1.01，最大可表示 15.15',
  `version_hard` varchar(10) DEFAULT NULL COMMENT '硬件版本， 1.01，最大可表示 15.15',
  `msg_type` int(2) DEFAULT NULL COMMENT '消息类型',
  `co2_concentration` decimal(6,1) DEFAULT NULL COMMENT '二氧化碳浓度（0～2000ppm）1位小数',
  `temperature` decimal(5,1) DEFAULT NULL COMMENT '温度',
  `humidity` int(5) DEFAULT NULL COMMENT '湿度',
  `atmospheric` decimal(6,1) DEFAULT NULL COMMENT '大气压',
  `wind_direct` int(5) DEFAULT NULL COMMENT '风向',
  `wind_angle` int(5) DEFAULT NULL COMMENT '风向角度',
  `wind_speed` int(5) DEFAULT NULL COMMENT '风速',
  `wind_level` int(5) DEFAULT NULL COMMENT '风的等级',
  `pm2` decimal(6,1) DEFAULT NULL COMMENT 'PM2.5',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='最近一条Co2传感器传感原始数据';

CREATE TABLE `proj_co2_data` (
  `id` char(36) NOT NULL COMMENT '主键id',
  `city_code` int(11) NOT NULL COMMENT '所属城市',
  `region_code` int(11) NOT NULL COMMENT '所在行政区',
  `zone_id` char(36) NOT NULL COMMENT '片区id',
  `hop` int(3) DEFAULT NULL COMMENT '传感器到 GW 的跳数，传感器直接传送到 GW 时，hop=1',
  `net_id` int(4) DEFAULT NULL COMMENT '网段号，1～4095',
  `seq` int(5) DEFAULT NULL COMMENT '传感器帧序号，传感器发一次增 1，可以用来统计丢包率',
  `rssi` int(3) DEFAULT NULL COMMENT '接收到传感器数据的 RSSI',
  `address` varchar(16) DEFAULT NULL COMMENT '接收到传感器数据的 传感器地址',
  `sensor_code` varchar(50) NOT NULL COMMENT '设备编号',
  `gateway_name` varchar(32) NOT NULL COMMENT '网关名称',
  `device_type` int(2) DEFAULT NULL COMMENT '设备类型',
  `sensor_type` int(2) DEFAULT NULL COMMENT '传感器类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `receive_time` datetime NOT NULL COMMENT '接收时间',
  `version_soft` varchar(10) DEFAULT NULL COMMENT '软件版本， 1.01，最大可表示 15.15',
  `version_hard` varchar(10) DEFAULT NULL COMMENT '硬件版本， 1.01，最大可表示 15.15',
  `msg_type` int(2) DEFAULT NULL COMMENT '消息类型',
  `co2_concentration` decimal(6,1) DEFAULT NULL COMMENT '二氧化碳浓度（0～2000ppm）1位小数',
  `temperature` decimal(5,1) DEFAULT NULL COMMENT '温度',
  `humidity` int(5) DEFAULT NULL COMMENT '湿度',
  `atmospheric` decimal(6,1) DEFAULT NULL COMMENT '大气压',
  `wind_direct` int(5) DEFAULT NULL COMMENT '风向',
  `wind_angle` int(5) DEFAULT NULL COMMENT '风向角度',
  `wind_speed` int(5) DEFAULT NULL COMMENT '风速',
  `wind_level` int(5) DEFAULT NULL COMMENT '风的等级',
  `pm2` decimal(6,1) DEFAULT NULL COMMENT 'PM2.5',
  `payload` varchar(255) DEFAULT NULL COMMENT '原始数据',
  `reserved` varchar(32) DEFAULT NULL COMMENT '保留字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Co2传感器数据表';









```



> 一张图

```
猛兽类
	狮
	 非洲狮
	虎
	豹
	狼
	豺
非猛兽类
	
List<兽类>
兽类：type name list




图上数据：
	动物园名称 物种数 存栏量 
	城市 占比



数据库字段：
繁育场 ： 新增区分动物园和繁育场
物种清单：新增区分猛兽类、非猛兽类，兽类、鸟类，狮、虎、豹...


id parentId 猛兽/狮
id parentId 非猛兽


id typeId 物种清单id


```





### 智慧船坞气体与气象传感器 数据帧 

```sql
CREATE TABLE `proj_ship_meteorological_data` (
  `id` char(36) NOT NULL COMMENT '主键id',
  `city_code` int(11) NOT NULL COMMENT '所属城市',
  `region_code` int(11) NOT NULL COMMENT '所在行政区',
  `zone_id` char(36) NOT NULL COMMENT '片区id',
  `hop` int(3) DEFAULT NULL COMMENT '传感器到 GW 的跳数，传感器直接传送到 GW 时，hop=1',
  `net_id` int(4) DEFAULT NULL COMMENT '网段号，1～4095',
  `seq` int(5) DEFAULT NULL COMMENT '传感器帧序号，传感器发一次增 1，可以用来统计丢包率',
  `rssi` int(3) DEFAULT NULL COMMENT '接收到传感器数据的 RSSI',
  `address` varchar(16) DEFAULT NULL COMMENT '接收到传感器数据的 传感器地址',
  `sensor_code` varchar(50) NOT NULL COMMENT '设备编号',
  `gateway_name` varchar(32) NOT NULL COMMENT '网关名称',
  `device_type` int(2) DEFAULT NULL COMMENT '设备类型',
  `sensor_type` int(2) DEFAULT NULL COMMENT '传感器类型',
  `msg_type` int(2) DEFAULT NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `receive_time` datetime NOT NULL COMMENT '接收时间',
  `wind_speed` decimal(7,1) DEFAULT NULL COMMENT '风速，单位 m/s，分辨率 0.1',
  `wind_angle` int(7) DEFAULT NULL COMMENT '风向，单位°，分辨率 1.0',
  `water_level` int(7) DEFAULT NULL COMMENT '水位值，单位 mm，分辨率 1.0',
  `so2_alarm_level` int(2) DEFAULT NULL COMMENT '二氧化硫报警等级',
  `so2_concentrations` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫浓度，单位 ppm，分辨率 0.1',
  `so2_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `so2_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `co_alarm_level` int(2) DEFAULT NULL COMMENT '一氧化碳浓度，单位 ppm，分辨率 0.1',
  `co_concentrations` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳浓度，单位 ppm，分辨率 0.1',
  `co_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `co_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `h2s_alarm_level` int(2) DEFAULT NULL COMMENT '硫化氢浓度，单位 ppm，分辨率 0.1',
  `h2s_concentrations` decimal(7,1) DEFAULT NULL COMMENT '硫化氢浓度，单位 ppm，分辨率 0.1',
  `h2s_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '硫化氢报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `h2s_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '硫化氢报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `air_temp` decimal(7,1) DEFAULT NULL COMMENT '空气温度，单位℃，分辨率 0.1',
  `air_humi` decimal(7,1) DEFAULT NULL COMMENT '空气湿度，单位%，分辨率 0.1',
  `wind_comm_status` tinyint(2) DEFAULT NULL COMMENT '风向、风速传感器 0-通讯中断；1-通讯正常；2-数据异常',
  `water_comm_status` tinyint(2) DEFAULT NULL COMMENT '水位检测传感器',
  `co2_comm_status` tinyint(2) DEFAULT NULL COMMENT ' 二氧化硫气体传感器',
  `co_comm_status` tinyint(2) DEFAULT NULL COMMENT '一氧化碳气体传感器',
  `h2s_comm_status` tinyint(2) DEFAULT NULL COMMENT '硫化氢气体传感器',
  `air_comm_status` tinyint(2) DEFAULT NULL COMMENT '空气温湿度传感器',
  `payload` varchar(255) DEFAULT NULL COMMENT '原始数据',
  `reserved` varchar(32) DEFAULT NULL COMMENT '保留字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='智慧船坞气体与气象传感器数据表';

CREATE TABLE `mon_last_ship_meteorological_data` (
  `id` char(36) NOT NULL COMMENT '主键id',
  `city_code` int(11) NOT NULL COMMENT '所属城市',
  `region_code` int(11) NOT NULL COMMENT '所在行政区',
  `zone_id` char(36) NOT NULL COMMENT '片区id',
  `hop` int(3) DEFAULT NULL COMMENT '传感器到 GW 的跳数，传感器直接传送到 GW 时，hop=1',
  `net_id` int(4) DEFAULT NULL COMMENT '网段号，1～4095',
  `seq` int(5) DEFAULT NULL COMMENT '传感器帧序号，传感器发一次增 1，可以用来统计丢包率',
  `rssi` int(3) DEFAULT NULL COMMENT '接收到传感器数据的 RSSI',
  `address` varchar(16) DEFAULT NULL COMMENT '接收到传感器数据的 传感器地址',
  `sensor_code` varchar(50) NOT NULL COMMENT '设备编号',
  `gateway_name` varchar(32) NOT NULL COMMENT '网关名称',
  `device_type` int(2) DEFAULT NULL COMMENT '设备类型',
  `sensor_type` int(2) DEFAULT NULL COMMENT '传感器类型',
  `msg_type` int(2) DEFAULT NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `receive_time` datetime NOT NULL COMMENT '接收时间',
  `wind_speed` decimal(7,1) DEFAULT NULL COMMENT '风速，单位 m/s，分辨率 0.1',
  `wind_angle` int(7) DEFAULT NULL COMMENT '风向，单位°，分辨率 1.0',
  `water_level` int(7) DEFAULT NULL COMMENT '水位值，单位 mm，分辨率 1.0',
  `so2_alarm_level` int(2) DEFAULT NULL COMMENT '二氧化硫报警等级',
  `so2_concentrations` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫浓度，单位 ppm，分辨率 0.1',
  `so2_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `so2_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '二氧化硫报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `co_alarm_level` int(2) DEFAULT NULL COMMENT '一氧化碳浓度，单位 ppm，分辨率 0.1',
  `co_concentrations` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳浓度，单位 ppm，分辨率 0.1',
  `co_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `co_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '一氧化碳报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `h2s_alarm_level` int(2) DEFAULT NULL COMMENT '硫化氢浓度，单位 ppm，分辨率 0.1',
  `h2s_concentrations` decimal(7,1) DEFAULT NULL COMMENT '硫化氢浓度，单位 ppm，分辨率 0.1',
  `h2s_alarm_th1` decimal(7,1) DEFAULT NULL COMMENT '硫化氢报警阈值 1，单位 ppm，分辨\r\n率 0.1',
  `h2s_alarm_th2` decimal(7,1) DEFAULT NULL COMMENT '硫化氢报警阈值 2，单位 ppm，分辨\r\n率 0.1',
  `air_temp` decimal(7,1) DEFAULT NULL COMMENT '空气温度，单位℃，分辨率 0.1',
  `air_humi` decimal(7,1) DEFAULT NULL COMMENT '空气湿度，单位%，分辨率 0.1',
  `wind_comm_status` tinyint(2) DEFAULT NULL COMMENT '风向、风速传感器 0-通讯中断；1-通讯正常；2-数据异常',
  `water_comm_status` tinyint(2) DEFAULT NULL COMMENT '水位检测传感器',
  `co2_comm_status` tinyint(2) DEFAULT NULL COMMENT ' 二氧化硫气体传感器',
  `co_comm_status` tinyint(2) DEFAULT NULL COMMENT '一氧化碳气体传感器',
  `h2s_comm_status` tinyint(2) DEFAULT NULL COMMENT '硫化氢气体传感器',
  `air_comm_status` tinyint(2) DEFAULT NULL COMMENT '空气温湿度传感器',
  `payload` varchar(255) DEFAULT NULL COMMENT '原始数据',
  `reserved` varchar(32) DEFAULT NULL COMMENT '保留字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='最近一条智慧船坞气体与气象传感器数据表';


INSERT INTO `ecology_data`.`sys_menu` (`MENU_ID`, `PARENT_ID`, `NAME`, `URL`, `PERMS`, `TYPE`, `ICON`, `ORDER_NUM`, `CREATE_BY`, `CREATE_TIME`, `UPDATE_BY`, `UPDATE_TIME`, `DELETED`) VALUES ('808e65f2b37e4008ae37419876b98b47', 'b302df62c7eb433d98e25a56c13ff24d', '气体与气象传感器', '/mon/shipMeteorologicalmonitormonitor', NULL, 1, 'devicemonitor', 11.0000000000, 'ADMIN001', '2022-01-07 11:29:46', NULL, NULL, 0);
INSERT INTO `ecology_data`.`sys_menu` (`MENU_ID`, `PARENT_ID`, `NAME`, `URL`, `PERMS`, `TYPE`, `ICON`, `ORDER_NUM`, `CREATE_BY`, `CREATE_TIME`, `UPDATE_BY`, `UPDATE_TIME`, `DELETED`) VALUES ('d8b2dd1349ea41e2b04997b4756e857c', '7b4aa054bd7248eaa33c6bce5a4d513e', '气体与气象传感器原始数据', 'proj/shipmeteorologicaldata', NULL, 1, 'transactionlist', 15.0000000000, 'ADMIN001', '2022-01-07 14:30:08', NULL, NULL, 0);












常用单词
shipMeteorological
ShipMeteorological

智慧船坞气体与气象传感器
```









###  人工繁育

#### TIP

```
breed_species
新增引进单位 introduce_unit

aco_animal_change 变化记录表
新增死亡个体登记表照片 table_photo_url
```



#### 人工繁育手动录入-检测繁育场是否存在

**接口说明**

> 人工繁育手动录入-检测繁育场是否存在

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/breed/check-breed

**请求方法**

> GET

**数据提交方式**

> application/json

**请求参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述   |
| :------- | :------- | :------- | :--------- |
| name     | String   | 是       | 繁育场名称 |

**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | int      | true     | 返回码 200表示修改成功，其他表示失败                         |
| msg      | String   | true     | 返回描述-记录接口执行情况说明信息 `操作成功` 表示成功，其他表示失败 |
| success  | boolean  | false    | true表示成功，fasle表示失败                                  |
| data     | Object   | true     | 返回结果对象                                                 |



data 说明

| 参数名称    | 数据类型 | 是否必须 | 参数描述        |
| :---------- | :------- | :------- | :-------------- |
| placeName   | String   | true     | 单位名称        |
| code        | String   | true     | 证件号/信用代码 |
| charge      | String   | false    | 负责人          |
| phone       | String   | false    | 负责人电话      |
| chargeLegal | String   | false    | 法人            |
| address     | String   | false    | 详细地址        |
| chargeTec   | String   | false    | 技术负责人      |





**返回参数举例**

```json

```





#### 人工繁育手动录入-提交数据

**接口说明**

> 人工繁育手动录入-提交数据

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/breed/add

**请求方法**

> POST

**数据提交方式**

> application/json

**请求参数**

| 参数名称        | 数据类型 | 是否必须 | 参数描述       |
| :-------------- | :------- | :------- | :------------- |
| company         | Object   | 是       | 繁育场信息     |
| breed           | Object   | 是       | 繁育信息       |
| breedSpecies    | List     | 是       | 物种信息       |
| breedChangeInfo | List     | 否       | 繁育场变更信息 |

company说明

| 参数名称           | 参数描述   | 是否必须 | 数据类型 |
| :----------------- | :--------- | :------- | :------- |
| company.address    | 单位地址   | false    | string   |
| company.creditCode | 信用编码   | false    | string   |
| company.frdb       | 法人代表   | false    | string   |
| company.lxdh       | 联系人电话 | false    | string   |
| company.lxr        | 联系人     | false    | string   |
| company.name       | 单位名称   | true     | string   |

breed说明

| 参数名称               | 参数描述                                         | 是否必须 | 数据类型 |
| :--------------------- | :----------------------------------------------- | :------- | :------- |
| breed.applyTime        | 申请时间                                         | false    | string   |
| breed.cityCode         | 市                                               | false    | string   |
| breed.districtCode     | 区                                               | false    | string   |
| breed.purpose          | 繁育目的种用、公众展示展演、药用、科学研究、其他 | false    | string   |
| breed.technologyPic    | 技术负责人                                       | false    | string   |
| breed.breedType        | 繁育许可申请类别 1.新办证 2.变更 3.换证 4.增项   | true     | int      |
| breed.approvalNumber   | 许可批文号                                       | true     | string   |
| breed.permitContentUrl | 上传附件地址                                     | false    | string   |

breedSpecies 说明

| 参数名称                   | 参数描述                  | 是否必须 | 数据类型       |
| :------------------------- | :------------------------ | :------- | :------------- |
| breedSpecies.cname         | 申请繁育物种种类 种类名称 | false    | string         |
| breedSpecies.mj            | 面积                      | false    | string         |
| breedSpecies.speciesCount  | 申请数量                  | false    | int            |
| breedSpecies.unit          | 单位                      | false    | string         |
| breedSpecies.introduceUnit | 引进单位                  | false    | string         |
| breedSpecies.type          | 变更类型                  | false    | string         |
| breedSpecies.beforeNum     | 变更前准予数量            | false    | integer(int32) |
| breedSpecies.beforeNum     | 变更前准予数量            | false    | integer(int32) |

breedChangeInfo说明

| 参数名称                         | 参数描述   | 是否必须 | 数据类型 |
| :------------------------------- | :--------- | :------- | :------- |
| breedChangeInfo.type             | 变更类型   | false    | string   |
| breedChangeInfo.changeBeforeInfo | 变更前信息 | false    | string   |
| breedChangeInfo.changeAfterInfo  | 变更后信息 | false    | string   |

**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | int      | true     | 返回码 200表示修改成功，其他表示失败                         |
| msg      | String   | true     | 返回描述-记录接口执行情况说明信息 `操作成功` 表示成功，其他表示失败 |
| success  | boolean  | false    | true表示成功，fasle表示失败                                  |



```shell
docker run --name postgres -e POSTGRES_PASSWORD=tangcs123 -p 5432:5432 -v /mydata/postgressql/data:/var/lib/postgresql/data -d postgres
```



#### 修改存栏量

```
 新增
 isMaintain 是否维护 0、否 1、是


新增死亡个体登记表照片url
tablePhotoUrl

 个体编号列表
 api/shengting-aco/animalinfo/list-code
 参数：
 nameCh: 大熊猫
 placeId: 1432150789007314946
 返回：
 List<Code>
```









 #### 许可证表

浙林驯繁

年份

序号



```sql
CREATE TABLE `aco_breed_place_permit_number` (
  `id` bigint(64) NOT NULL,
  `place_id` bigint(64) DEFAULT NULL COMMENT '繁育场id',
  `effective_time` datetime DEFAULT NULL COMMENT '繁育场许可证生效时间',
  `expiration_time` datetime DEFAULT NULL COMMENT '繁育场许可证失效时间',
    `permit_number` varchar(64) COMMENT '许可证号',
  `permit_number_prefix` varchar(64) COMMENT '许可证前缀',
  `permit_number_year` int(4) COMMENT '许可证年份',
    `permit_number_sort` int(11) COMMENT '许可证序号',
   `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` int(2) DEFAULT '0' COMMENT '是否已删除 0-未删除 1-已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='繁育场许可证表';
```

#### 打印

打印物种页面

- /api/shengting-aco/breedplacespecies/selectSpecies  加个参数 permitNumberType 1-浙江省陆⽣野⽣动物⼈⼯繁育许可证 2-国家重点点保护陆⽣野⽣动物⼈⼯繁育许可证



```
以前有多个许可证编号
生成两个许可证 没有许可证编号显示什么
```















```sql
CREATE TABLE `aco_species_category` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `name` varchar(32) DEFAULT NULL COMMENT '类别名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级别编号',
  `parent_name` varchar(32) DEFAULT NULL COMMENT '父级别编号名称',
  `ancestors` varchar(255) DEFAULT NULL COMMENT '祖级划编号',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `category_level` int(2) DEFAULT NULL COMMENT '层级',
  `sort` int(2) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `is_deleted` int(2) DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='动物类别';



ALTER TABLE `shengting_aco`.`aco_species_maintenance` 
ADD COLUMN `category_id` bigint(20) NULL COMMENT '类别id' AFTER `id`;
```















