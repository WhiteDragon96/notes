

### docker安装

#### docker的基本组成

![img](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgitee.com%2Fwx_3d25ad0b9a%2Fimg%2Fraw%2Fmaster%2Fimg%2FDocker%25E7%25BB%2593%25E6%259E%2584%25E5%259B%25BE.png&refer=http%3A%2F%2Fgitee.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637419979&t=7f09983f7031f87b406051d5d18694a0)

**镜像(image)：**

docker镜像就好比是一个模板，可以通过这个模板来创建容器服务,tomcat镜像===>run==>tomcat01容器(提供服务),通过这个镜像可以创建多个容器(做种服务运行或者项目运行就是在容器中的)。

**容器(container)**

Docker利用容器技术，独立运行一个或者一组应用，通过镜像来创建的。

启动，停止，删除，基本命令！

目前就可以把这个容器理解为就是一个简易的linux系统

**仓库(repository):**

创库就是存放镜像的地方!

创库分为共有仓库和私有仓库 Cocker Hub（默认是国外的）

#### 安装Docker

> 环境准备

1. 环境查看 cat /etc/os-release

2. 安装

   1.CentOS

   ```shell
   # 1.卸载旧版本
   sudo yum remove docker \
                     docker-client \
                     docker-client-latest \
                     docker-common \
                     docker-latest \
                     docker-latest-logrotate \
                     docker-logrotate \
                     docker-engine
   # 2、需要的安装包
   sudo yum install -y yum-utils
   # 3、设置镜像的仓库
   sudo yum-config-manager \
      --add-repo \
       https://download.docker.com/linux/centos/docker-ce.repo #默认是国外sudo 
       
   yum-config-manager \
      --add-repo \
       http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo #推荐阿里云的
   # 更新yum软件包索引
   yum makecache
   # 4、安装docker相关的 docker-ce 社区 ee 企业版    
   yum install docker-ce docker-ce-cli containerd.io
   # 5、启动docker
   systemctl start docker
   # 6、判断是否启动成功
   docker version
   #7、hello-world
   docker run hello-world
   # 8、查看下载的镜像
   docker images
   
   ```

   卸载docker

   ```shell
    # 1、依赖卸载
    sudo yum remove docker-ce docker-ce-cli containerd.io
    # 2、删除资源
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
   ```

   #### docker运行流程图

   ![image-20211021234057864](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211021234057864.png)

   #### 底层原理

   **Docker是怎么工作的？**

   Docker是一个Client-Server结构的系统，Docker的守护进程运行再主机上。通过Socket从客户端访问！

   DockerServer接收到Docker-Client的指令，就会去执行这个命令

   ![image-20211021234710753](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211021234710753.png)

#### 常用设置

**设置镜像**

创建文件 /etc/docker/daemon.json ，并在其中添加如下内容

```json
{
"registry-mirrors":["https://docker.mirrors.ustc.edu.cn"]
}
```

重启docker

```shell
systemctl daemon-reload
systemctl restart docker
```



### Docker常用命令

```shell
docker version			#显示版本信息
docker info				#显示docker详细信息
docker --help			#帮助命令
```

帮助文档地址：https://docs.docker.com/engine/reference/commandline



#### 镜像命令

**docker images			#查看本地所有镜像**

```shell
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
mysql         latest    ecac195d15af   3 days ago     516MB

#解释
REPOSITORY		镜像的仓库源
TAG				镜像的标签
IMAGE ID		镜像的id
CREATED			镜像的的创建时间
SIZE			镜像的的大小
# 可选项
	-a, --all		#列出所有的镜像
	-q, --quiet		#只显示镜像的id
```

**docker search: 搜索镜像**

```shell
[root@iZbp1et2qekjwuvfpiokc4Z ~]#  docker search mysql
NAME                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
mysql                             MySQL is a widely used, open-source relation…   11570     [OK]       
mariadb                           MariaDB Server is a high performing open sou…   4403      [OK]       

# 可选项，通过收藏来过滤
 --filter=STARS=3000		#搜索出来的镜像就是STARS大于3000的
```

**docker pull:下载镜像**

```shell
# 下载镜像
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker pull mysql
Using default tag: latest	#如果不写 tag,默认就是 latest
latest: Pulling from library/mysql
b380bbd43752: Already exists 	#分层下载，docker image的核心 联合文件系统
f23cbf2ecc5d: Pull complete 
30cfc6c29c0a: Pull complete 
b38609286cbe: Pull complete 
8211d9e66cd6: Pull complete 
2313f9eeca4a: Pull complete 
7eb487d00da0: Pull complete 
4d7421c8152e: Pull complete 
77f3d8811a28: Pull complete 
cce755338cba: Pull complete 
69b753046b9f: Pull complete 
b2e64b0ab53c: Pull complete
Digest: sha256:6d7d4524463fe6e2b893ffc2b89543c81dec7ef82fb2020a1b27606666464d87 #签名
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest #真实地址

#等价于它
docker pull mysql
docker pull docker.io/library/mysql:latest

# 指定版本下载
docker pull mysql:5.7
```

docker rmi :删除镜像

```shell
docker rmi -f 镜像id  #删除指定的镜像
docker rmi -f 镜像id 镜像id 镜像id  #删除多个镜像
docker rmi -f $(docker images -aq) #删除全部镜像
```



#### 容器命令

----

说明：我们有了镜像才可创建容器

**新建容器并启动**

```shell
docker run [可选参数] image

#参数说明
--name="Name" 		容器名字 tomcat01 tomcat02,用来区分容器
-d					后台方式运行
-it					使用交互式运行，进入容器查看内容
-p					指定容器的端口 -p 8080:8080
	-p ip:主机端口:容器端口
	-p 主机端口:容器端口 (常用)
	-p 容器端口
-P					随机指定端口

# 测试，启动并进入容器
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker run -it centos /bin/bash
[root@36ebe6de7ee5 /]#  

```

**列出所有运行的容器**

```shell
# docker ps 命令
	#列出当前正在运行的容器
-a	#列出所有容器，包括已经停止的容器
-n=?	#显示最近创建的容器
-q	#只显示容器编号(可用于删除)
```

**退出容器**

```shell
exit	#直接退出容器
ctrl+p+q #退出不停止容器
```

**删除容器**

```shell
docker rm 容器id					#删除指定容器，不能删除正在运行容器，要强行删除-f
docker rm -f $(docker ps -aq)	 #删除所有容器
docker ps -aq|xargs docker rm	 #删除所有容器，通过管道符
```

启动和停止容器的操作

```shell
docker start 容器id		#启动容器
docker stop 容器id		#停止容器
docker restart 容器id		#重启容器
docker kill 容器id		#强制停止容器
```

#### 常用其他命令

```shell
# 常见的坑：docker 容器使用后台运行，就必须要有一个前台进程，docker发现没有应用，就会自定停止
# nginx,容器启动后，发现自己没有提供服务，就会立即停止
```

#### 日志命令

```shell
docker logs -t -f --tail n 容器名/id

# 自己编写一段shell脚本
docker run --name centos -d centos /bin/sh -c "while true;do echo tangchuansong;sleep 1;done"

# 显示日志
 -tf			#显示日志
 --tail n		#显示最近n条日志
[root@iZbp1et2qekjwuvfpiokc4Z /]# docker logs -t -f --tail n centos

```

**查看容器中进程信息**

```shell
# 命令 docker top 容器id/name
```

**查看镜像元数据**

```shell
# 命令
docker inspect 容器id/name
```

**进入正在运行的容器**

```shell
# 我们通常容器都是使用后台方式运行的，需要进入容器，修改一些配置

# 命令
docker exec -it 容器id/name /bin/bash		#进入容器后开启一个新的终端，可以再里面操作
docker attach 容器id						#进入容器正在执行的终端，不会启动新的进程！
```

**从容器拷贝文件到主机上**

```shell
docker cp 容器id:容器内路径 目标的主机路径

#进入容器内部
[root@iZbp1et2qekjwuvfpiokc4Z docker]# docker exec -it centos /bin/bash
[root@d2bd183e716c /]# cd /home/
[root@d2bd183e716c home]# ls
#新建一个文件
[root@d2bd183e716c home]# touch test.java
[root@d2bd183e716c home]# exit
exit
# 拷贝容器文件到主机
[root@iZbp1et2qekjwuvfpiokc4Z docker]# docker cp centos:/home/test.java /home/tangchuansong/docker
[root@iZbp1et2qekjwuvfpiokc4Z docker]# ll
total 0
-rw-r--r-- 1 root root 0 Oct 24 22:53 test.java

#
```

#### 小结

![image-20211024225808290](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211024225808290.png)



#### 安装练习

> **安装nginx**

```shell
# 1、搜索镜像 search，建议去docker搜索，可以看到帮助文旦那个
# 2、下载镜像 pull
# 3、运行测试

# -d		后台运行
# --name	给容器命名
# -p 宿主机端口:容器内端口

[root@iZbp1et2qekjwuvfpiokc4Z docker]# docker exec -it nginx /bin/bash
root@93eb12b303fe:/# ls
bin  boot  dev	docker-entrypoint.d  docker-entrypoint.sh  etc	home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@93eb12b303fe:/# whereis nginx
nginx: /usr/sbin/nginx /usr/lib/nginx /etc/nginx /usr/share/nginx
root@93eb12b303fe:/# cd etc/nginx/ #nginx配置文件
root@93eb12b303fe:/etc/nginx# ls
conf.d	fastcgi_params	mime.types  modules  nginx.conf  scgi_params  uwsgi_params
```

> **安装tomcat**

```shell
# 官方的使用
docker run -it --rm tomcat:9.0
# 我们之前的启动都是1后台，停止了容器还在可以查到，-rm,一般用来测试，用完就删

# 下载再启动
docker pull tomcat
docker run -d -p 8888:8080 --name tomcat tomcat

# linux安装软件再 /usr/local下
# 进入容器
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker exec -it tomcat /bin/bash

# 发现问题：1、linux命令少了 2、没有webapps 阿里云镜像原因。默认是最小的镜像，所有不必要的镜像都剔除掉
# 保证最小可运行环境
```

> **部署elasticsearch + kibana**

```shell
# --net 网络配置

#启动 elasticsearch 
docker run -d --name elasticsearch -p 8888:9200 -p 1888:9300 -e "discovery.type=single-node" elasticsearch:7.6.2

# 非常占内存 docker stats 查看cpu的状态

#修改配置文件 -e 环境配置修改
docker run -d --name elasticsearch -p 8888:9200 -p 1888:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="Xms64m -Xmx512m" elasticsearch:7.6.2
```

#### 可视化

- portainer(先用这个)
- Rancher(CI/CD再用)

**什么是portainer?**

Docker图形化界面管理工具！提供一个后台面板供我们

```shell
docker run -d -p 8888:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock --privileged=true portainer/portainer

# 访问测试 外网:8888
```



### Docker 镜像讲解

---

#### 镜像是什么

------

镜像是一种轻量级、可执行的独立软件包,用来打包软件运行环境和基于运行环境开发的软件,它包含运行某个软件所需的所有内容,包括代码、运行时、库、环境变量和配置文件。

#### Docker 镜像加载原理

----

> UnionFS(联合文件系统)

UnionS(联合文件系统): Union文件系统( UnionFS)是一种分层、轻量级并且高性能的文件系统,它支持对文件系统的修改作为一次提交来一层层的叠加,同时可以将不同目录挂载到同一个虚拟文件系统下 unite several directories into a single virtualfilesystem)。 Union文件系统是 Docker镜像的基础。镜像可以通过分层来进行继承,基于基础镜像(没有父镜像),可以制作各种具体的应用镜像

特性:一次同时加载多个文件系统,但从外面看起来,只能看到一个文件系统,联合加载会把各层文件系统叠加起来,这样最终的文件系统会包含所有底层的文件和目录

> Docker镜像加载原理



#### 分层原理

----















