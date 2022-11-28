

### 监测程序是否挂了，自动重启

1、编写脚本

```shell
#!/bin/sh

#很重要 加载环境变量 否则找不到java环境变量
source /etc/profile
# 进行jar所在目录
cd /opt/v2
 
# 查询程序占用
project=`ps -ef|grep eureka-server|grep -v grep|wc -l`
date=`date`
server_name="eureka-server"

# $? -ne 0 不存在 
# $? -eq 0存在 
if [ $project -eq 0 ]
then
	nohup java -jar eureka-server.jar --server.port=8769 & > nohup.out 2>&1
	echo `date +%Y-%m-%d` `date +%H:%M:%S` $server_name >> /opt/eureka-server/restart.log
fi

```

确认sh文件是否能正常运行

2、添加到系统定时任务

```shell
# 编辑系统定时任务文件
crontab -e
# 使用cron表达式，设置1分钟运行一次
*/1 * * * * bash /opt/eureka-server/restart.sh >> /opt/eureka-server/log.log
```

