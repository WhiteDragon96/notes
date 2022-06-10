



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

> 特点

Docker镜像都只是只读的，当容器启动时，一个新的科协层被加载到镜像的顶部！

这一层就是我们通常说的容器层，容器之下都叫镜像层！

![image-20211025211733032](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211025211733032.png)

#### commmit镜像

```shell
docker commit 提交容器成为一个新的副本
 
docker commit -m="提交的描述信息" -a="作者" 容器id 目标镜像名: [TAG]
```

实战测试

```shell
# 1.启动一个默认的tomcat

# 2.发现这个默认的tomcat 是没有 webapps应用， 镜像的原因，官方的镜像默认 webapps下面是没有文件的！

# 3.自己拷贝进去基本的文件

# 4.将操作过的容器通过commit提交为一个镜像！我们以后就是使用我们修改过的镜像即可

[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker commit -a="tang" -m="add webapps" 38066f82831a tomcat01:1.0
sha256:2f06941af778f40f9a190e66ba07f0039318fa8b72d1096b8762b3dbf2613c53
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker images
REPOSITORY                     TAG       IMAGE ID       CREATED          SIZE
tomcat01                       1.0       2f06941af778   4 seconds ago    684MB
tomcat                         latest    b3b4c471f854   45 seconds ago   684MB
```

### 容器数据卷

---

#### 什么时容器数据卷

----

**docker的理念回顾**

将应用和环境打包成一个镜像！

容器之间可以有一个数据共享的技术！Docker容器中产生的数据，同步到本地！这就是卷技术！目录的挂载，将我们容器内的目录，挂载到Linux上面！

**容器的持久化和同步操作！容器间也是可以数据共享的！**

#### 使用数据卷

> 方式一：直接使用命令来挂载 -v

```shell
docker run -v 主机目录：容器内目录

# 测试
[root@iZbp1et2qekjwuvfpiokc4Z tangchuansong]# docker run -d -it --name centos -v /home/tangchuansong/test:/home centos

# 启动起来时候我们可以通过 docker inspect 容器id 查看容器信息

# 双向绑定，互相同步
# 容器停止后也会同步进去
```

**好处：**以后我们修改只需要在本地修改即可，容器内会自动同步！

#### 实战：安装 MySQL

```shell
# 获取镜像 docker pull mysql

# 议论性容器，需要做数据挂载！ #安装启动mysql,需要配置密码的，这是要注意点！
# 官方测试：
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

# 启动自己的
-d 后台运行
-p 端口映射
-v 卷挂宅
-e 环境配置
[root@iZbp1et2qekjwuvfpiokc4Z test]# docker run  -d -p 8888:3306 -v /home/mysql/conf:/etc/mysql/conf.d -v /home/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql

# 启动成功后，我们使用本地连接测试下
# 在本地新建一个数据库，看有没有
```

删除容器，本地数据是不会丢失的



#### 具名和匿名挂载

```shell
# 匿名挂载
-v 容器内路径！
docker run -d -P --name nginx01 -v /ect/nginx nginx

# 查看所有卷的情况 volume 的情况
[root@iZbp1et2qekjwuvfpiokc4Z mysql]# docker volume ls
DRIVER    VOLUME NAME
local     2c8cd9f5fdc9a925ae2acaefecfb5e973cd32ee2968323c12643d7bcbfca43bb
local     3f1eba3ff186429f2749479e17746225b274d5493cf396784c67fbce3d55e689

# 这种就是匿名挂载，我们在 -v 只写了容器内的路径，没有写容器外的路径！

# 具名挂载
[root@iZbp1et2qekjwuvfpiokc4Z mysql]# docker run -d -P --name nginx02 -v juming:/ect/nginx nginx
[root@iZbp1et2qekjwuvfpiokc4Z mysql]# docker volume ls
DRIVER    VOLUME NAME
local     2c8cd9f5fdc9a925ae2acaefecfb5e973cd32ee2968323c12643d7bcbfca43bb
local     juming

# 通过 -v 卷名：容器内路径
# 查看一下这个卷
[root@iZbp1et2qekjwuvfpiokc4Z mysql]# docker volume inspect juming
[
    {
        "CreatedAt": "2021-10-25T22:14:49+08:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/juming/_data",
        "Name": "juming",
        "Options": null,
        "Scope": "local"
    }
]
```

所有docker容器内的卷，没有指定目录的情况下都在 /var/lib/docker/volumes/xxx/_data

我们荣国具名挂载可以方便找到我们的一个卷，大多数情况下使用的`具名挂载`

``` shell
如何确定时具名挂载还是匿名挂载，还是指定路径挂载
-v 容器内路径		# 匿名挂载
-v 卷名：容器内路径	  # 具名挂载
-v 本地路径：容器内路径# 指定路径挂载
```

拓展：

```shell
# 通过 -v 容器内路径: ro rw 改变读写权限
ro	readonly		# 只读
rw	readwrite		# 可读可写

# 一旦这个设置了容器权限，容器对我们挂载出来的内容就有限定了！
docker run -d -P --name nginx -v juming:/etc/nginx:ro nginx

# ro 说明这个路径只能通过宿主机来操作，容器内部时无法操作的！
```



#### 初识DockerFile

---

Dockerfile 就是用来构建docker 镜像的构建文件！命令脚本！

通过这个脚本可以生成镜像，镜像是一层一层的，脚本一个个的命令，都是一层

```shell
# 创建一个dockerfile文件，名字可以随机取  建议dockerfile
# 文件中的内容，指令(大写) 参数
FROM centos
VOLUME ["VOLUME01","VOLUME02"]
CMD echo "--end---"
CMD /bin/bash

docker build -f dockerfile1 -t tang/centos:1.0 .

# volume01、volume02也挂载出去了，通常会构建自己的镜像
```



#### 数据卷容器

----

多个mysql 同步数据！

![image-20211025224838653](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211025224838653.png)



#### 数据卷容器

---



多个mysql实现数据共享

```shell
# 命令 
docker run -d --name 02 --volumes-form 01 mysql
# 只会同步容器的挂载路径
```



![image-20211025230003644](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211025230003644.png)

```shell
docker run -d -p 3301:3306 -v /etc/mysql/conf.d -v /var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql

docker run -d -p 3302:3306 -v /etc/mysql/conf.d -v /var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql02 --volumes-form mysql01 mysql
#这个时候可以实现两个容器数据同步
```



结论：

容器之间配置信息的传递，数据卷容器的生命周期一直持续到没有容器使用为止

### DockerFile

----

#### DockerFile介绍

dockerfile 是用来构建docker 镜像的文件！命令参数脚本!

构建步骤：

1、编写一个dockerfile文件

2、docker build 构建成为一个镜像

3、docker run 运行镜像

4、docker push 发布镜像(DockerHub、阿里云镜像仓库！)

官方centos镜像

```shell
FROM scratch
ADD centos-8-x86_64.tar.xz /
LABEL org.label-schema.schema-version="1.0"     org.label-schema.name="CentOS Base Image"     org.label-schema.vendor="CentOS"     org.label-schema.license="GPLv2"     org.label-schema.build-date="20210915"
CMD ["/bin/bash"]
```

#### DockerFile构建过程

**基础知识：**

1、每个保留关键字都必须是大写字幕

2、执行从上到下顺序执行

3、# 表示注释

4、每一个指令都会创建提交一个新的镜像层，并提交！

![](https://img0.baidu.com/it/u=3383571339,2436431860&fm=26&fmt=auto)

DockerFile：构建文件，定义了一切的步骤，源代码

DockerImages：通过DockerFile构建生成的镜像，最终发布和运行的产品！

Docker容器：容器就是镜像运行起来提供服务器



#### DockerFile指令

---

```shell
FROM		# 基础敬故乡，一切从这里开始构建
MAINTAINER	# 镜像是谁写的，姓名+邮箱
RUN			# 镜像构建的时候需要运行的命令
ADD			# 步骤：tomcat镜像，这个tomcat压缩包，添加内容
WORKDIR		# 镜像的工作目录
VOLUME		# 挂载的目录
EXPOSE		# 保留端口配置
CMD			# 指定这个容器启动的时候要运行的命令，只有最后一个会生效，可被替代
ENTRYPOINT	# 指定这个容器启动的时候要运行的命令，可以追加命令
ONBUILD		# 当构建一个被继承 DockerFIle 这个时候就会运行 ONBUILD 的指令。触发指令。
COPY		# 雷士ADD，将我们文件拷贝到镜像中
ENV			# 构建的时候设置环境环境变量！
```

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fupload-images.jianshu.io%2Fupload_images%2F6567790-fff25499e56d7295.png&refer=http%3A%2F%2Fupload-images.jianshu.io&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637937841&t=28094a10ac365ead6d4ab4970135f788)

#### 实战测试

> 创建一个自己的centos

```shell
# 1、编写dockerfile文件
FROM centos
MAINTAINER tang<1234@163.com>
ENV MYPATH /usr/local
WORKDIR $MYPATH
RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80
CMD echo $MYPATH
CMD echo "---end---"
CMD /bin/bash
# 2、编译dockerfile文件
# 命令 docker build -f dockerfile文件路径 -t 镜像名:[tag] .
```

对比原来多了 vim

我们可以列出本地镜像变更历史

```shell
[root@iZbp1et2qekjwuvfpiokc4Z dockerfile]# docker history mycentos:0.1 
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
f5c5062c7f08   3 minutes ago   /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "/bin…   0B        
dc400826c1c9   3 minutes ago   /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "echo…   0B        
0afbb619c7e2   3 minutes ago   /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "echo…   0B        
3d18feb7ce0c   3 minutes ago   /bin/sh -c #(nop)  EXPOSE 80                    0B        
1f4c0b122f82   3 minutes ago   /bin/sh -c yum -y install net-tools             32.3MB    
6c848c197865   4 minutes ago   /bin/sh -c yum -y install vim                   72.6MB    
b32354dc2036   4 minutes ago   /bin/sh -c #(nop) WORKDIR /usr/local            0B        
f99fdcfd2ebe   4 minutes ago   /bin/sh -c #(nop)  ENV MYPATH=/usr/local        0B        
e4c939676af9   4 minutes ago   /bin/sh -c #(nop)  MAINTAINER tang<1234@163.…   0B        
5d0da3dc9764   5 weeks ago     /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B        
<missing>      5 weeks ago     /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B        
<missing>      5 weeks ago     /bin/sh -c #(nop) ADD file:805cb5e15fb6e0bb0…   231MB 
```

> CMD 和 ENTRYPOINT 区别

![image-20211027230745551](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211027230745551.png)

#### 实战：Tomcat镜像

1、准备镜像文件tomcat 压缩包，jdk的压缩包！

2、编写dockerfile文件，官方命令`Dockerfile`，build会自动寻找这个文件，就不需要-f指定了！

```shell
FROM centos
MAINTAINER tang
#COPY dockerfile /usr/local/dockerfile
ADD jdk-8u141-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-9.0.54.tar.gz /usr/local/
RUN yum -y install vim

ENV MYPATH /usr/local
WORKDIR $MYPATH

ENV JAVA_HOME /usr/local/jdk1.8.0_141
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tool.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.54
ENV CATALINA_BASE /usr/local/apache-tomcat-9.0.54
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/bin

EXPOSE 80

CMD /usr/local/apache-tomcat-9.0.54/bin/startup.sh && tail -f /usr/local/apache-tomcat-9.0.54/logs/catalina.out
```

3、构建镜像

```shell
docker build -t diytomcat .
```

4、启动

```shell
docker run -d -p 8888:8080 --name tangtomcat -v /home/tangchuansong/build/tomcat/test:/usr/local/apache-tomcat-9.0.54/webapps/ROOT -v /home/tangchuansong/build/tomcat/tomcatlogs/:/usr/local/apache-tomcat-9.0.54/logs diytomcat
```

5、访问测试

6、发布项目

#### 发布自己的镜像

> DockerHub

1、地址https://hub.docker.com/ 注册自己的账号

2、确定这个账号可以登录

3、在我们服务器上提交自己的镜像

4、登录完毕后就可以提交自己的镜像

```shell
# 登录
docker login -u username
# 提交
docker push 镜像:[tag]
```

> 阿里云镜像服务

1、登录阿里云

2、找到容器镜像服务

3、创建命名空间

4、创建容器镜像

5、浏览阿里云信息

### Docker网络

-----

> 测试

![image-20211028230118054](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211028230118054.png)

三个网络

```shell
 # 问题：docker 是如何处理容器网络的访问的
 
 # [root@iZbp1et2qekjwuvfpiokc4Z ~]# docker run -d -P --name tomcat01 tomcat

# 查看容器的内部网络地址 ip addr
```

> 原理

1、我们每启动一个docker容器，docker就会给docker容器分配一个ip，我们只要安装了docker，就会有一个网卡docker0桥接模式，使用的技术是evth-pair技术！

2、在启动一个容器测试，发现又多了一对网卡

```shell
# 我们发现这歌容器带来网卡，都是一对对的
# evth-pair 就是一堆的虚拟设备接口，他们都是成对出现的，一段连着协议，一段彼此相连
# 正是因为有这个特性，evth-pair 充当一个桥梁，连接各种虚拟网络设备的
# Openstac，Docker容器之间的连接，OVS的里拦截，都是使用evth-pair 技术
```

3、容器和容器之间是可以互相ping通的

![image-20211028233851648](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211028233851648.png)

 结论：tomcat01 和 tomcat02 是共用一个路由器，docker0.

所有的容器不指定网络的情况下，都是docker0路由的，docker会给我们的容器分配一个默认的可用IP

> 小结
>

 Docker 使用的是Linux的桥接，宿主机中 是一个Docker容器的网桥 docker0



Dokcer所有桥接都是内网，所以速度很快

#### --link

> 我们编写一个微服务，database url=ip:,项目不重启，数据库IP换掉了，我们希望可以处理这个问题，可以名字用名字来访问容器？

```shell
# 通过--link既可以解决网络联通问题
docker run -d -P --name tomcat01 --link tomcat02 tomcat
docker exec -it tomcat02 ping tomcat01

# 反向不可以可以ping通
docker exec -it tomcat01 ping tomcat02
Name or service not known
```



#### 自定义网络

---

> 查看所有的docker网络

```shell
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
d47fe38eca1b   bridge    bridge    local
4b59f9e50a39   host      host      local
642ff2faa589   none      null      local


```

**网络模式：**

bridge：桥接docker（默认，自己创建也使用bridge 模式）

none：不配网络

host：和宿主机共享网络

**测试**

```shell
# 我们直接启动的命令 --net bridge，而这个就是我们的docker0
docker run -d -P --name centos01 centos
docker run -d -P --name centos01 --net bridge centos

# docker0特点，默认，域名不能访问，--link可以打通连接！

# 我们可以自定义一个网络
# --driver bridge 桥接
# --subnet 192.168.0.0/16 192.168.0.2 - 192.168.255.255 子网地址
# --gateway 192.168.0.1 网关
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker network create --driver bridge ---subnet 192.168.0.0/16 --gateway 192.168.0.1 mynet
1b166ec190eec708338492800d0f4e03f98769699aec75c7128d53ff6f1f5e57
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
d47fe38eca1b   bridge    bridge    local
4b59f9e50a39   host      host      local
1b166ec190ee   mynet     bridge    local
642ff2faa589   none      null      local

```

自己的网络

![image-20211101233001910](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211101233001910.png)

```shell
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker run -d -P --name tomcat01 --net mynet tomcat
fd2cae0f65c2c73e65ab7d23ea47e8f52b5286336a3c2f079954d07245f75e35
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker ps
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS                                         NAMES
fd2cae0f65c2   tomcat                         "catalina.sh run"        5 seconds ago   Up 3 seconds   0.0.0.0:49158->8080/tcp, :::49158->8080/tcp   tomcat01
a9b7ac5604d7   luminoleon/epicgames-claimer   "python3 -u main.py …"   8 days ago      Up 7 days                                                    epic
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker run -d -P --name tomcat02 --net mynet tomcat
841e7921091791e0a20b1dc8d83b4f0ceb8aba5032f07b2f876f5498abe5ca95
[root@iZbp1et2qekjwuvfpiokc4Z ~]# docker network inspect mynet 
[
    {
        "Name": "mynet",
        "Id": "1b166ec190eec708338492800d0f4e03f98769699aec75c7128d53ff6f1f5e57",
        "Created": "2021-11-01T23:25:41.037877687+08:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.168.0.0/16",
                    "Gateway": "192.168.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "841e7921091791e0a20b1dc8d83b4f0ceb8aba5032f07b2f876f5498abe5ca95": {
                "Name": "tomcat02",
                "EndpointID": "ed89feba1fa1c78830d78505fbc973fc9fed333066d21f3796c3d443bcdce87e",
                "MacAddress": "02:42:c0:a8:00:03",
                "IPv4Address": "192.168.0.3/16",
                "IPv6Address": ""
            },
            "fd2cae0f65c2c73e65ab7d23ea47e8f52b5286336a3c2f079954d07245f75e35": {
                "Name": "tomcat01",
                "EndpointID": "54fc41048c143ce72e66091e1b1ce0367ba76d0080b3fe35d4481735d21f9ac0",
                "MacAddress": "02:42:c0:a8:00:02",
                "IPv4Address": "192.168.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
# 现在不使用 --link也可以ping名字了！
docker exec -it tomcat01 ping 192.168.0.3
docker exec -it tomcat01 ping tomcat02
```

好处：

redis -不同集群使用不同的网络，保证集群是安全和健康的

mysql -不同集群使用不同的网络，保证集群是安全和健康的

#### 网络连通

![image-20211101234511069](C:\Users\White\AppData\Roaming\Typora\typora-user-images\image-20211101234511069.png)

```shell
docker network connect 网络 容器

# 测试打通 mynet跟docker0

# 连通之后就是将 tomcat01 放到了mynet网络下，tomcat有两个内网

# 一个容器两个ip地址
# 阿里云 公网和私网
```



**实战：部署Redis集群**

```shell
# 分片 +高可用　＋　负载均衡

# 创建网卡
docker network create redis --subnet 172.38.0.0/16

# shell脚本，创建六个redis配置
for port in $(seq 1 6); \
do \
mkdir -p /mydata/redis/node-${port}/conf
touch /mydata/redis/node-${port}/conf/redis.conf
cat <<EOF>/mydata/redis/node-${port}/conf/redis.conf
prot 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 172.38.0.1${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
appendonly yes
EOF
done

# 启动
docker run -p 6372:6379 -p 16371:16379 --name redis-1 \
-v /mydata/redis/node-2/data:/data \
-v /mydata/redis/node-1/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.11  redis redis-server /etc/redis/redis.conf

# 创建集权
redis-dli --cluster create 172.38.0.11:6379 172.38.0.12:6379 172.38.0.13:6379 ... --cluster-replicas 1

```



#### SpringBoot微服务打包

1、构建springboot服务

2、打包应用

3、编写dockerfile

4、构建镜像

5、发布运行



```shell
FROM java:8

COPY *.jar /app.jar
CMD ["--server.port=8080"]

EXPOSE 8080

ENTRYPOINT["java","-jar","/app.jar"]
```



### Docker Compose

---

#### 简介

定义运行多个容器

YAML file配置文件 

single command 命令

**三步骤：**

- Dockerfile保证我们的项目在任何地方可以运行
- services 什么是服务
- docker-compose.yml这个文件怎么写

作用：批量容器编排

> 理解

Compose是Docker官方的开源项目。需要安装！

```shell
version: "3.9"  # optional since v1.27.0
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/code
      - logvolume01:/var/log
    links:
      - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
```

Compose：重要的概念。

- 服务services，容器。应用。（web、redis、mysql...）
- 项目project。一组关联的容器。博客。web、mysql 、wp

 #### 安装

1、下载

```shell
curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m`  /usr/local/bin/docker-compose
```

2、授权

```shell
sudo chmod +x /usr/local/bin/docker-compose
```

#### 体验

[官方demo]: https://docs.docker.com/compose/gettingstarted/

1、应用 app.py

2、Dockerfile 应用打包为镜像

3、Docker-compose yml文件 （定义整个服务，需要的环境。web、redis）完整的上线服务

4、启动compose项目（docker-compose -d up)

> 流程

1、创建网络

2、执行Docker-compose yaml

3、启动服务

通过docker-compose启动的会新建一个网络

停止：docker-compose down



#### yaml 规则

```shell
# 3层

verion: '' # 版本
services: # 服务
	服务1：web
	# 服务配置
	images
	build
	network
	.....
	服务2:redis
	...
	服务3：redis
	...
# 其他配置 网络/卷、全局规则
volumes:
networks:
configs:
	
```

1、官方文档

https://docs.docker.com/compose/compose-file/compose-file-v3/

#### 开源项目（博客）

https://docs.docker.com/samples/wordpress/

1、下载项目（docker-compose.yaml）

2、如果需要文件。Dockerfile

3、文件准备齐全（直接一键启动）

后台启动

docker-compose up -d

#### 实战

1、编写项目微服务

dockerfile 构建镜像

3、docker-compose.yaml 编排项目

4、丢到服务器 docker-compose up



### Docker Swarm





### 应用

---

#### `epic`

```shell
docker run -it --name epic -e TZ=Asia/Shanghai --restart unless-stopped -v /appdata/epic:/User_Data luminoleon/epicgames-claimer -r 10:30 -a -ps SCserver酱
```

#### `bilibili-helper`

```shell
docker run -d --name=bilibili-helper --restart unless-stopped -e CRON=true -e TZ=Asia/Shanghai -v /appdata/bilibili-config:/config  superng6/bilibili-helper:latest
```

#### `阿里云挂载服务`

```shell
docker run -d --name=aliyundrive-webdav --restart=unless-stopped -p 6677:8080 \
  -v /appdata/aliyundriver/:/etc/aliyundrive-webdav/ \
  -e REFRESH_TOKEN='you refresh token' \
  -e WEBDAV_AUTH_USER=username \
  -e WEBDAV_AUTH_PASSWORD=t***3 \
  messense/aliyundrive-webdav

# /etc/aliyun-driver/ 挂载卷自动维护了最新的refreshToken，建议挂载
# ALIYUNDRIVE_AUTH_PASSWORD 是admin账户的密码，建议修改
# JAVA_OPTS 可修改最大内存占用，比如 -e JAVA_OPTS="-Xmx512m" 表示最大内存限制为512m
```

`bilibili自动抽奖`

```shell
https://github.com/shanmiteko/LotteryAutoScript
```

`启动ubuntu桌面环境`

```shell
docker run -d --name ubuntu-desktop-lxde-vnc -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=T@ng7167451959 -v /appdata/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc
```

#### `qinglong`

```shell
docker run -dit \
  -v /appdata/qinglong:/ql/data \
  -p 5757:5700 \
  --name qinglong \
  --hostname qinglong \
  --restart unless-stopped \
  whyour/qinglong:latest
```

#### `数据库`

```shell
docker run -d -p 3305:3306 -v /appdata/mysql/conf:/etc/mysql/conf.d -v /appdata/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=@@@@  --name mysql001 mysql:5.7.32

--version 8
docker run -d -p 3304:3306 -v /appdata
:/etc/mysql/conf.d -v /appdata/mysql8/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=@@@@  --name mysql8 mysql:8
```

#### melody

```shell
docker run -d -p 5566:5566 --name melody -v /appdata/melody-profile:/app/backend/.profile foamzou/melody:latest
```

#### nps

```shell
docker run -d --name nps --net=host -v /appdata/nps/conf:/conf ffdfgdfg/nps
```

#### nginx

```shell
docker run --name nginx --net=host -v /appdata/nginx/nginx.conf:/etc/nginx/nginx.conf -v /appdata/nginx/log:/var/log/nginx -v /appdata/nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf -v /appdata/nginx/html:/usr/share/nginx/html -d nginx
```

```shell
docker run -d --net=host -v /appdata/nginx/:/var/log/nginx/ -v /appdata/nginx/nginx.conf:/etc/nginx/nginx.conf:ro --name nginx  nginx
```

#### halo

```shell
docker run -it -d --name halo -p 8090:8090 -v /appdata/halo:/root/.halo --net halo-net --restart=unless-stopped halohub/halo:1.5.3
```



#### onenav

> 书签管理器

```shell
docker run -itd --name="onenav" -p 4461:80 \
    -v /appdata/onenav:/data/wwwroot/default/data \
    --restart unless-stopped \
    helloz/onenav:0.9.23
```

