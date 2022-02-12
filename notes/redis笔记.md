# Redis



### Nosql概述

#### 为什么要用Nosql

> 1、单机MySQL的年代

![image-20220210163008840](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220210163008840.png)

整个网站的瓶颈是什么？

1、数据量如果太大，一个机器放不下了！

2、数据的索引（B-Tree），一个机器内存也放不下

3、访问量（读写混合），一个服务器承受不了

> 2、Memcached(缓存) + MySQL + 垂直拆分(读写分离)

为了减轻数据库压力，我们可以使用缓存

发展过程：优化数据结构和索引-->文件缓存(IO)-->Memcached

![image-20220210163634400](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220210163634400.png)

> 3、分库分表 + 水平拆分

MyISAM：表锁

Innodb：行锁

> 4、如今最近的年代

MySQL等关系型数据库就不够用了，数据量大，变换快

![image-20220210165514723](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220210165514723.png)

> 为什么要用NoSQL！

用户的个人信息，社交网络，地理位置。用户自己产生的数据，用户日志等等爆发式增长！



#### 什么是NoSQL

> NoSQL

NoSQL = Not OnlySQL（不仅仅是SQL）

泛指非关系型数据库

> NoSQL 特点

1、方便扩展，K-V键值对(数据之间没有关系，很好扩展！)

2、大数据量高性能（Redis一秒可以写8万次，读取11万次，NoSQL的缓存记录级，是一种细粒度的缓存，性能会比较高！）

3、数据类型是多样型的！（不需要事先设计数据库）

4、传统RDBMS 和 NoSQL

```
传统RDBMS
- 结构化组织
- SQL
- 数据和关系都存在单独的表中
- 操作，数据定义语言
- 严格的一致性
...
```

```
Nosql
- 不仅仅是数据
- 没有固定的查询语言
- 键值对存储，列存储，文档存储，图形数据库
- 最终一致性
- CAP定理和BASE （异地多活）
- 高性能，高可用，高科扩
....
```



> 了解： 3V + 3高

![image-20220212152016657](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220212152016657.png)

#### NoSQL的四大分类

**KV键值对：**

- Redis
- Redis + Tair
- Redis + memecache

**文档型数据路(bson格式和json一样)：**

- **MongoDB**
  - MongoDB是一个基于分布式文件存储的数据库，C++编写，主要用来处理大量文档！
    - MongoDB是一个介于关系型数据库和非关系型数据中中间的产品！MongoDB是非关系型数据库中功能最丰富，最像关系型数据库的！

- ConthDB

**列存储数据库**

- HBase
- 分布式文件系统

**图关系数据库**

- 放的是一些关系，不如：朋友圈社交网络，广告推荐！
- Neo4j，InfoGrid

![image-20220212155305137](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220212155305137.png)



### Redis入门

---

#### 概述

> Redis 是什么

Redis（Remote Dictionary Server )，即远程字典服务

是一个开源的使用ANSI [C语言](https://baike.baidu.com/item/C语言)编写、支持网络、可基于内存亦可持久化的日志型、Key-Value[数据库](https://baike.baidu.com/item/数据库/103728)，并提供多种语言的API。

> Redis 能干嘛

1、内存存储、持久化、内存是断电即失（aof、rdb）

2、效率高，可用于高速缓存

3、发布订阅系统

4、地图信息分析

5、计时器、计数器（浏览量！）

​      ............

> Redis 特性

1、多样的数据类型

2、持久化

3、事务

> 学习工具

官网：http://www.redis.cn/



#### 测试性能

**redis-benchmark** 是一个压力测试工具！

redis 性能测试工具可选参数如下所示：

| 选项                      | 描述                                       | 默认值    |
| :------------------------ | :----------------------------------------- | :-------- |
| **-h**                    | 指定服务器主机名                           | 127.0.0.1 |
| **-p**                    | 指定服务器端口                             | 6379      |
| **-s**                    | 指定服务器 socket                          |           |
| **-c**                    | 指定并发连接数                             | 50        |
| **-n**                    | 指定请求数                                 | 10000     |
| **-d**                    | 以字节的形式指定 SET/GET 值的数据大小      | 2         |
| **-k**                    | 1=keep alive 0=reconnect                   | 1         |
| **-r**                    | SET/GET/INCR 使用随机 key, SADD 使用随机值 |           |
| **-P**                    | 通过管道传输 <numreq> 请求                 | 1         |
| **-q**                    | 强制退出 redis。仅显示 query/sec 值        |           |
| **--csv**                 | 以 CSV 格式输出                            |           |
| ***-l\*（L 的小写字母）** | 生成循环，永久执行测试                     |           |
| **-t**                    | 仅运行以逗号分隔的测试命令列表。           |           |
| ***-I\*（i 的大写字母）** | Idle 模式。仅打开 N 个 idle 连接并等待。   |           |
| -a                        | 加密码                                     |           |

```shell
# 测试：100个并发链接 100000请求
redis-benchmark -h localhost -p 6379 -c 100 -n 100000
```

![image-20220212162004594](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220212162004594.png)

#### 基础的知识

redis默认有16个数据库，默认使用的是第0个

```shell
# 切换数据库
127.0.0.1:6379[3]> select 0
OK
# DB大小
127.0.0.1:6379> DBSIZE
(integer) 5
# 查看所有key
127.0.0.1:6379> keys *
1) "key:__rand_int__"
# 清除当前数据库 清除全部数据库 flushall
127.0.0.1:6379> flushdb
OK 
```



> Redis 是单线程的

Redis是基于内存操作的，CPU不是Redis性能瓶颈，Redis的瓶颈是根据机器的内存和网络带宽，既然可以使用单线程来实现，就使用单线程

> Redis为什么单线程还更快？

 误区：多线程（CPU上下文会切换！）一定比单线程效率高！

核心：redis是将所有的数据全部放在内存中的，所以说使用单线程去操作效率就是最高的，多线程（CPU上下文会切换），多次读写都是在一个CPU上的，在内存情况下，这个就是最佳的方案！

#### Redis-Key

```bash
127.0.0.1:6379> exists name
(integer) 1
127.0.0.1:6379> exists name1 # 判断当前key是否存在
(integer) 0
127.0.0.1:6379> move name 1 # 移除当前key
(integer) 1
127.0.0.1:6379> keys *
1) "age"
127.0.0.1:6379> set name tang
OK
127.0.0.1:6379> keys *
1) "name"
2) "age"
127.0.0.1:6379> get name
"tang"
127.0.0.1:6379> expire name 10 # 设置key过期时间
(integer) 1
127.0.0.1:6379> ttl name # 查看key还有多久过期
(integer) 2
127.0.0.1:6379> ttl name
(integer) -2
127.0.0.1:6379> get name
127.0.0.1:6379> type age # 查看当前key类型
string	
```



### 五大数据类型

Redis 是一个开源（BSD许可）的，内存中的数据结构存储系统，它可以用作**数据库**、**缓存**和**消息中间件**。 它支持多种类型的数据结构，如 [字符串（strings）](http://www.redis.cn/topics/data-types-intro.html#strings)， [散列（hashes）](http://www.redis.cn/topics/data-types-intro.html#hashes)， [列表（lists）](http://www.redis.cn/topics/data-types-intro.html#lists)， [集合（sets）](http://www.redis.cn/topics/data-types-intro.html#sets)， [有序集合（sorted sets）](http://www.redis.cn/topics/data-types-intro.html#sorted-sets) 与范围查询， [bitmaps](http://www.redis.cn/topics/data-types-intro.html#bitmaps)， [hyperloglogs](http://www.redis.cn/topics/data-types-intro.html#hyperloglogs) 和 [地理空间（geospatial）](http://www.redis.cn/commands/geoadd.html) 索引半径查询。 Redis 内置了 [复制（replication）](http://www.redis.cn/topics/replication.html)，[LUA脚本（Lua scripting）](http://www.redis.cn/commands/eval.html)， [LRU驱动事件（LRU eviction）](http://www.redis.cn/topics/lru-cache.html)，[事务（transactions）](http://www.redis.cn/topics/transactions.html) 和不同级别的 [磁盘持久化（persistence）](http://www.redis.cn/topics/persistence.html)， 并通过 [Redis哨兵（Sentinel）](http://www.redis.cn/topics/sentinel.html)和自动 [分区（Cluster）](http://www.redis.cn/topics/cluster-tutorial.html)提供高可用性（high availability）。

#### String（字符串类型）

```shell

127.0.0.1:6379> set name tang
OK
127.0.0.1:6379> append name "hello" # 往当前字符串追加，不存在新建
(integer) 9 
127.0.0.1:6379> get name
"tanghello"
i++
127.0.0.1:6379> set views 0
OK
127.0.0.1:6379> incr views # 自增1
(integer) 1
127.0.0.1:6379> get views
"1"
127.0.0.1:6379> decr views # 自减1
(integer) 1
127.0.0.1:6379> incrby views 10 # 指定增量
(integer) 10
127.0.0.1:6379> decrby views 10 # 指定减去步长
(integer) 0
127.0.0.1:6379> get name
"tanghello"
127.0.0.1:6379> Getrange name 0 3 # 截取字符串[0,3]
"tang"
# 替换！
127.0.0.1:6379> setrange name 3 xx # 替换指定开始的字符串！
(integer) 9
127.0.0.1:6379> get name
"tanxxello"
# setex(set with expire) # 设置
# setnx(set if not exist) # 设置不存在
127.0.0.1:6379> setex key 30 "hello" # 设置key30s后过期
OK
127.0.0.1:6379> ttl key
(integer) 28
127.0.0.1:6379> setnx key1 redis # 如果key1不存在，创建key1
127.0.0.1:6379> setnx key1 monogoDB # 如果key1存在，创建失败！
(integer) 0
# 批量设置值
127.0.0.1:6379> mset k1 v1 k2 v2 k3 v3 #同时设置多个值
OK
127.0.0.1:6379> keys *
1) "k3"
2) "k2"
3) "k1"
127.0.0.1:6379> mget k1 k2 k3 # 同时获取多个值
1) "v1"
2) "v2"
3) "v3"
127.0.0.1:6379> msetnx k1 v1 k4 v4 # msetnx 是一个原子性的操作，要么一起成功，要么一起失败！
(integer) 0
127.0.0.1:6379> keys *
1) "k3"
2) "k2"
3) "k1"
# 对象
 mset user:1:name zhangsan user:1:age 2
OK
127.0.0.1:6379> mget user:1:name user:1:age
1) "zhangsan"
2) "2"
getset # 先get再set
127.0.0.1:6379> getset db redis # 如果不存在，则返回nil
(nil)
127.0.0.1:6379> getset db redis
"redis"
127.0.0.1:6379> getset db mongodb # 如果存在值，获取原来的值，并设置新的值
"redis"
127.0.0.1:6379> get db
"mongodb"
```

String的使用场景：value除了我们的字符串还可以是数字

- 计数器
- 统计多单位的熟了
- 粉丝数
- 对象缓存

#### List

redis可以当作，栈、队列、阻塞队列！

```shell
127.0.0.1:6379> lpush list one two three # 将一个或多个值，插入到列表头部(左)
(integer) 3
127.0.0.1:6379> lrange list 0 -1 # 获取list中值
1) "three"
2) "two"
3) "one"
127.0.0.1:6379> lpop list # 弹出列表第一个元素
"three"
127.0.0.1:6379> rpush list four # 在尾部插入(右边)
127.0.0.1:6379> lindex list 1 # 通过下表获取list中的某一个值！
"one"
127.0.0.1:6379> llen list # 返回列表长度
(integer) 3
127.0.0.1:6379> lrem list 1 one # 移除list中指定个数的value，精确匹配
(integer) 1
127.0.0.1:6379> lpush list hello1 hello2 hello3 world
(integer) 4
127.0.0.1:6379> ltrim list 1 2 # 通过下标，这个list已经被改变了，截取指定的长度！
OK
127.0.0.1:6379> lrange list
(error) ERR wrong number of arguments for 'lrange' command
127.0.0.1:6379> lrange list 0 -1
1) "hello3"
2) "hello2"
rpoplpush # 移除列表最后一个元素添加到新的列表

127.0.0.1:6379> rpush mylist hello hello1 hello2
(integer) 3
127.0.0.1:6379> rpoplpush mylist myotherlist # 移动到新的列表
"hello2"
127.0.0.1:6379> lrange mylist 0 -1
1) "hello"
2) "hello1"
127.0.0.1:6379> lrange myotherlist 0 -1
1) "hello2"

```



#### Set

#### Hash

#### Zset

### 三种特殊数据类型

#### geospatial

#### hyperloglog

#### bitmaps

