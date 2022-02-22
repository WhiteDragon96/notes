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
####################################################
linsert
127.0.0.1:6379[1]> linsert list before 2 world # 2前面插
(integer) 5
127.0.0.1:6379[1]> lrange list 0 -1
1) "10"
2) "3"
3) "world"
4) "2"
5) "1"

```

> 小结

- 它实际上是一个链表，before Node after ,left ,right 都可以插入值
- 如果key不存在，创建新的链表，如果key存在，新增内容
- 如果移除了所有值，空链表，也代表不存在！
- 在两边插入或者改动值，效率最高！



#### Set

set中的值不是重复的

```shell
127.0.0.1:6379[2]> sadd myset hello tang love
(integer) 3
127.0.0.1:6379[2]> smembers myset
1) "tang"
2) "love"
3) "hello"
127.0.0.1:6379[2]> sismember myset hello # 判断某个值是否存在
(integer) 1
127.0.0.1:6379[2]> srem myset hello # 移除指定元素
(integer) 1
##############################################################
set 无序不重复，抽随机
127.0.0.1:6379[2]> srandmember myset # 随机取出一个元素
"world"
127.0.0.1:6379[2]> srandmember myset 2 # 随机取出指定个数元素
1) "tang"
2) "hello"
127.0.0.1:6379[2]> spop myset #  随机删除一个元素
"love"
##############################################################
将一个指定的值，移动导另一个set集合
127.0.0.1:6379[2]> sadd myset hello world tang
(integer) 3
127.0.0.1:6379[2]> sadd myset2 set2
(integer) 1
127.0.0.1:6379[2]> smove myset myset2 hello #移动
(integer) 1
127.0.0.1:6379[2]> smembers myset2
1) "hello"
2) "set2"
##############################################################
微博，B站，共同关注（并集）
数字集合类：
 - 差集
 - 交集
 - 并集
127.0.0.1:6379[2]> sdiff key1 key2 # 差集
1) "a"
2) "b"
127.0.0.1:6379[2]> sinter key1 key2 # 交集
1) "c"
127.0.0.1:6379[2]> sunion key1 key2 # 并集
1) "e"
2) "b"
3) "c"
4) "a"
5) "d"
```

#### Hash（哈希）

Map集合，key-map 值是一个map集合，本质和String没有太大区别

```shell
127.0.0.1:6379[3]> hset myhash field1 tang # 设置一个具体的key-value值
(integer) 1
127.0.0.1:6379[3]> hget myhash field1
"tang"
127.0.0.1:6379[3]> hmset myhash field1 hello field2 world # 批量设置、获取
OK
127.0.0.1:6379[3]> hmget myhash field1 field2 field3
1) "hello"
2) "world"
3) (nil)
127.0.0.1:6379[3]> hgetall myhash # 获取所有的值
1) "field1"
2) "hello"
3) "field2"
4) "world"
127.0.0.1:6379[3]> hdel myhash field1 # 删除指定的key
(integer) 1
##############################################################
hlen
127.0.0.1:6379[3]> hlen myhash # 获取长度
(integer) 4
127.0.0.1:6379[3]> hexists myyhash hello # 判断某个值是否存在
(integer) 0
127.0.0.1:6379[3]> hkeys myhash # 获取所有key
1) "field2"
2) "1"
3) "2"
4) "3"
127.0.0.1:6379[3]> hvals myhash # 获取所有value
1) "world"
2) "hello"
3) "world"
4) "tang"
##############################################################
incr decr
127.0.0.1:6379[3]> hset myhash field 5
(integer) 1
127.0.0.1:6379[3]> hincrby myhash field 1 #指定增量
(integer) 6
127.0.0.1:6379[3]> hincrby myhash field -1
(integer) 5
127.0.0.1:6379[3]> hsetnx myhash field4 hello # 如果不存在则可以设置
(integer) 1
127.0.0.1:6379[3]> hsetnx myhash field4 hello # 如果存在则不能设置
(integer) 0

```

hash变更的数据user name age,尤其是用户信息之类的，经常变动的信息！hash更适合于对象的存储，String更加适合字符串存储

#### Zset（有序集合）

在set的基础上，增加了一个值，set k1 v1 zset k1 score1 v1

```shell
127.0.0.1:6379[4]> zadd myset 1 one
(integer) 1
127.0.0.1:6379[4]> zadd myset 2 two 3 three
(integer) 2
127.0.0.1:6379[4]> zrange myset 0 -1
1) "one"
2) "two"
3) "three"
127.0.0.1:6379[4]> zadd salary 2500 xiaohong 5000 zhangsan 20000 tang
(integer) 3
127.0.0.1:6379[4]> zrangebyscore salary -inf +inf # 排序 从最小到最大
1) "xiaohong"
2) "zhangsan"
3) "tang"
127.0.0.1:6379[4]> zrangebyscore salary -inf +inf withscores # 带上分数
1) "xiaohong"
2) "2500"
3) "zhangsan"
4) "5000"
5) "tang"
6) "20000"
127.0.0.1:6379[4]> zrangebyscore salary -inf 5000 withscores # 设定最大值范围
1) "xiaohong"
2) "2500"
3) "zhangsan"
4) "5000"
127.0.0.1:6379[4]> zrevrangebyscore salary +inf -inf # 从最大到最小
1) "tang"
2) "zhangsan"
3) "xiaohong"
127.0.0.1:6379[4]> zrem salary xiaohong # 移除元素
(integer) 1
127.0.0.1:6379[4]> zcard salary # 获取有序集合个数
(integer) 2
127.0.0.1:6379[4]> zcount myset 1 2 # 统计指定区间个数
(integer) 2

```

其余一些API，可以通过官方文档查询。

案例思路：存储班级成绩表，工资表排序！

普通消息1、重要消息2，带权重判断，排行榜应用实现

### 三种特殊数据类型

#### geospatial（地理位置）

朋友的定位，附近的人，打车距离计算

Redis的 Geo在redis3.2就有了，可以推算地理位置的信息，两地之间的距离，方圆几里的人

可以查询一些数据：http://www.jsons.cn/lngcode/

只有 六个命令

![image-20220218153159458](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220218153159458.png)

> geoadd

```shell
# geoadd 添加地理位置
# 规则 两级地理位置是无法添加的，一般会下载城市数据，直接通过java陈旭一次性导入 
# 有效的经度从-180度到180度。有效的纬度从-85.05112878度到85.05112878度。当坐标位置超出上述指定范围时，该命令将会返回一个错误。
# 参数：key （纬度、经度、名称）
127.0.0.1:6379[5]> geoadd china:city 115.40 39.90 beijing
(integer) 1
127.0.0.1:6379[5]> geoadd china:city 121.47 41.23 shanghai
(integer) 1
127.0.0.1:6379[5]> geoadd china:city 106.50 29.53 chongqing 114.05 22.52 shenzhen
(integer) 2
127.0.0.1:6379[5]> geoadd china:city 120.16 30.24 hangzhou 108.96 34.26 xian

```

> geopos

获得当前定位：一定是一个坐标值

```shell
127.0.0.1:6379[5]> geopos china:city beijing # 获取指定城市的经度和纬度
1) 1) "115.40000170469284058"
   2) "39.90000009167092543"
```

> geodist

两地之间的距离：

- **m** 表示单位为米。
- **km** 表示单位为千米。
- **mi** 表示单位为英里。
- **ft** 表示单位为英尺。

```shell
127.0.0.1:6379[5]> geodist china:city beijing chongqing km # 查看上海到北京的直线距离 km
"1409.8347"
127.0.0.1:6379[5]> geodist china:city beijing shanghai km
"1109.0541"

```

> georadius 以给定的经纬度为中心， 返回键包含的位置元素当中

附近的人（获得所有附近的人的地址，定位）通过半径来查询

获取指定数量的人，200

```shell
# 100,30 半径1000km在集合中的位置
127.0.0.1:6379[5]> georadius china:city 100 30 1000 km
1) "chongqing"
2) "xian"
127.0.0.1:6379[5]> georadius china:city 110 30 500 km withdist # 显示到中心的距离
1) 1) "chongqing"
   2) "341.9374"
2) 1) "xian"
   2) "483.8340"
127.0.0.1:6379[5]> georadius china:city 110 30 500 km withcoord # 显示其他人的位置
1) 1) "chongqing"
   2) 1) "106.49999767541885376"
      2) "29.52999957900659211"
2) 1) "xian"
   2) 1) "108.96000176668167114"
      2) "34.25999964418929977"

127.0.0.1:6379[5]> georadius china:city 110 30 500 km withdist count 1 # 限制显示1条
1) 1) "chongqing"
   2) "341.9374"

```

> georadiusbymember

```shell
# 找出指定元素周围的其他元素！
127.0.0.1:6379[5]> georadiusbymember china:city beijing 1000 km
1) "beijing"
2) "xian"
```

> geohash

改命令将返回11个字符的Geohash字符串

```shell
# 将二维的经纬度转换为一堆的字符串， 如果两个字符串越接近，那么距离越近
127.0.0.1:6379[5]> geohash china:city beijing chongqing
1) "wx44czxdqg0"
2) "wm5xzrybty0"
```

> GEO 底层的实现原理其实就是Zset！我们可以使用Zset命令来操作geo!

```shell
127.0.0.1:6379[5]>  zrange china:city 0 -1 # 查看地图中全部元素
1) "chongqing"
2) "xian"
3) "shenzhen"
4) "hangzhou"
5) "shanghai"
6) "beijing"
127.0.0.1:6379[5]> zrem china:city beijing # 移除地图指定元素
(integer) 1

```

#### hyperloglog

HyperLogLog 是一种概率数据结构，用于对独特事物进行计数（从技术上讲，这指的是估计集合的基数）。通常计算唯一项目需要使用与您要计算的项目数量成比例的内存量，因为您需要记住过去已经看到的元素以避免多次计算它们。

> 什么是基数

A{1,3,5,7,8,1} B{1,3,5,7,8} 基数（不重复的元素） = 5，可以接受误差！

> 简介

HyperLogLog  基数统计的算法！

有点：占用的内存是固定的，2^64不同的元素的技术，只需要12KB内存

**网页的UV （一个人访问一个网站多次，但还是算作一个人）**

传统的方式，set保存用户的id，然后就可以统计set中的元素数量作为判断！

> 测试使用

```shell
127.0.0.1:6379[6]> PFadd mykey a b c d e f g h i j # 创建第一组元素 mykey
(integer) 1
127.0.0.1:6379[6]> Pfcount mykey # 统计 mykey 元素的基数数量
(integer) 10
127.0.0.1:6379[6]> Pfadd mykey2 i j z x c v b m
(integer) 1
127.0.0.1:6379[6]> pfcount mykey2
(integer) 8
127.0.0.1:6379[6]> pfmerge mykey3 mykey myke2 # 合并两组mykey mykey2 => mykey3 并集
OK
127.0.0.1:6379[6]> pfcount mykey3 # 查看并集数量！
(integer) 14

```

#### Bitmaps

> 位存储

统计用户信息，活跃，不活跃！登录、未登录！

Bitmaps位图，数据结构！都是操作二进制位来进行记录，就只有0和1两种状态

```shell
# 使用bitmap来记录周一到周日的打卡！
周一：1 周二：0...周天 0
127.0.0.1:6379[7]> setbit sign 0 1
(integer) 0
127.0.0.1:6379[7]> setbit sign 1 0
(integer) 0
127.0.0.1:6379[7]> setbit sign 3 0
(integer) 0
127.0.0.1:6379[7]> setbit sign 4 0
(integer) 0
127.0.0.1:6379[7]> setbit sign 5 1
(integer) 0
127.0.0.1:6379[7]> setbit sign 6 1
(integer) 0
127.0.0.1:6379[7]> setbit sign 7 0
(integer) 0
# 查看某一天是否有打卡
127.0.0.1:6379[7]> getbit sign 1
(integer) 0
127.0.0.1:6379[7]> getbit sign 0
(integer) 1
# 统计操作，统计打卡天数
127.0.0.1:6379[7]> bitcount sign
(integer) 3

```

### 事务

```shell
redis 127.0.0.1:6379> MULTI            # 标记事务开始
OK
 
redis 127.0.0.1:6379> INCR user_id     # 多条命令按顺序入队
QUEUED
 
redis 127.0.0.1:6379> INCR user_id
QUEUED
 
redis 127.0.0.1:6379> INCR user_id
QUEUED
 
redis 127.0.0.1:6379> PING
QUEUED
 
redis 127.0.0.1:6379> EXEC             # 执行
1) (integer) 1
2) (integer) 2
3) (integer) 3
4) PONG
==========================Watch 命令 - 监视一个(或多个) key==========================
# 如果在事务执行之前这个(或这些) key 被其他命令所改动，那么事务将被打断。
# 监视 key ，且事务成功执行
redis 127.0.0.1:6379> WATCH lock lock_times
OK
redis 127.0.0.1:6379> MULTI
OK
redis 127.0.0.1:6379> SET lock "huangz"
QUEUED
redis 127.0.0.1:6379> INCR lock_times
QUEUED
redis 127.0.0.1:6379> EXEC
1) OK
2) (integer) 1

# 监视 key ，且事务被打断
redis 127.0.0.1:6379> WATCH lock lock_times
OK
redis 127.0.0.1:6379> MULTI
OK
redis 127.0.0.1:6379> SET lock "joe"        # 就在这时，另一个客户端修改了 lock_times 的值
QUEUED
redis 127.0.0.1:6379> INCR lock_times
QUEUED
redis 127.0.0.1:6379> EXEC                  # 因为 lock_times 被修改， joe 的事务执行失败
(nil)
==========================Unwatch 命令 - 取消 WATCH 命令对所有 key 的监视==========================
redis 127.0.0.1:6379> WATCH lock lock_times
OK
redis 127.0.0.1:6379> UNWATCH
OK
==========================Discard 命令 - 取消事务==========================
redis 127.0.0.1:6379> MULTI
OK
redis 127.0.0.1:6379> PING
QUEUED
redis 127.0.0.1:6379> SET greeting "hello"
QUEUED
redis 127.0.0.1:6379> DISCARD
OK
```



### Jedis

### SpringBoot整合

### Redis.conf

### Redis持久化

### Redis主从复制

### Redis缓存穿透和雪崩