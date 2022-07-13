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

Redis事务本质：一组命令的集合！一个事务中的所有命令都会被序列化，在十五执行过程中，会按照顺序执行！

```
------ 队列 set set set 执行 ------
```

`Redis单条命令式保证原子性的，但是事务不保证原子性！`

redis的事务：

- 开启事务(multi)
- 命令入队(...)
- 执行事务(exec)

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

> 监控！

悲观锁：

- 很悲观，什么时候都会出问题，无论做什么都会加锁！

乐观锁：

- 很乐观，认为什么时候都不会出问题，所以不会上锁，更新数据的时候去判断下，在此期间是否有人修改过这个数据
- 获取version
- 更新数据

### Jedis

使用Java来操作Redis

> 是 Redis 官方推荐的 java链接开发工具！ 使用Java操作Redis中间件！

```xml
 <dependency>
     <groupId>redis.clients</groupId>
     <artifactId>jedis</artifactId>
     <version>3.0.0</version>
 </dependency>
```



### SpringBoot整合

SpringBoot操作数据： spring-data jpa jdbc mongodb redis！

说明：在SpringBoot 2.x之后，原来使用的jedis被替换为lettuce

jedis：采用的直连，多个线程操作的话，是不安全的，如果要避免不安全，使用jedis pool连接池！更像BIO模式

lettuce：采用netty，实例可以在多个线程中进行共享，不存在线程不安全的情况，可以减少线程数据了，更像NIO模式

源码分析

```java
    @Bean
	@ConditionalOnMissingBean(name = "redisTemplate") // 有实例替换
	@ConditionalOnSingleCandidate(RedisConnectionFactory.class)
	public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        // 默认 RedisTemplate 没有过多的设置，redis对象嗾使需要序列化！
        // 两个泛型都是 Object，Object 的类型，我们后面使用需要强制转换<String,Object>
		RedisTemplate<Object, Object> template = new RedisTemplate<>();
		template.setConnectionFactory(redisConnectionFactory);
		return template;
	}

	@Bean
	@ConditionalOnMissingBean
	@ConditionalOnSingleCandidate(RedisConnectionFactory.class) // 由于String是redis中最常使用的类型，所以单独提出来了
	public StringRedisTemplate stringRedisTemplate(RedisConnectionFactory redisConnectionFactory) {
		return new StringRedisTemplate(redisConnectionFactory);
	}
```



> 整合测试

1、导入依赖

```xml
<!--springboot自带 redis-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

2、配置连接

3、测试

```java
 // 获取redis的连接对象
RedisConnection connection = redisTemplate.getConnectionFactory().getConnection();
connection.flushDb();
```

![image-20220222232950978](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220222232950978.png)

![image-20220222233114852](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220222233114852.png)



### Redis.conf

启动的时候通过配置文件来启动

> 单位

```conf
# Redis configuration file example.
#
# Note that in order to read the configuration file, Redis must be
# started with the file path as first argument:
#
# ./redis-server /path/to/redis.conf

# Note on units: when memory size is needed, it is possible to specify
# it in the usual form of 1k 5GB 4M and so forth:
#
# 1k => 1000 bytes
# 1kb => 1024 bytes
# 1m => 1000000 bytes
# 1mb => 1024*1024 bytes
# 1g => 1000000000 bytes
# 1gb => 1024*1024*1024 bytes
#
# units are case insensitive so 1GB 1Gb 1gB are all the same.
################################## INCLUDES ###################################

```

1、配置文件unit单位，大小不敏感

> 包含

```shell
################################## INCLUDES ###################################

# Include one or more other config files here.  This is useful if you
# have a standard template that goes to all Redis servers but also need
# to customize a few per-server settings.  Include files can include
# other files, so use this wisely.
#
# Notice option "include" won't be rewritten by command "CONFIG REWRITE"
# from admin or Redis Sentinel. Since Redis always uses the last processed
# line as value of a configuration directive, you'd better put includes
# at the beginning of this file to avoid overwriting config change at runtime.
#
# If instead you are interested in using includes to override configuration
# options, it is better to use include as the last line.
#
# include /path/to/local.conf
# include /path/to/other.conf
```

> 网络

```shell
bind 0.0.0.0	# 绑定ip
protected-mode no	# 保护模式
port 6379	# 端口
```

> 通用 GENERAL

```shell
daemonize no	# 以守护进程的方式运行，默认是no
pidfile /var/run/redis_6379.pid	# 如果以后台的方式运行，我们就需要指定一个pid文件

# 日志
# Specify the server verbosity level.
# This can be one of:
# debug (a lot of information, useful for development/testing)
# verbose (many rarely useful info, but not a mess like the debug level)
# notice (moderately verbose, what you want in production probably)
# warning (only very important / critical messages are logged)
loglevel notice
logfile "" # 日志的文件位置名
ddatabases 16 # 数据库的数量，默认16个
always-show-logo yes # 是否总是显示LOGO
```

> 快照

持久化，在规定的时间内，执行了多少次操作，则会持久化到文件.rdb .aof

```shell
save 900 1 # 900s内，如果至少有1个key进行了修改，我们就进行持久化操作
save 300 10 # 300s内，如果至少有10个key进行了修改，我们就进行持久化操作
save 60 10000 # 60s内，如果至少有10000个key进行了修改，我们就进行持久化操作

stop-writes-on-bgsave-error yes # 持久化出错后是否继续工作
rdbcompression yes # 是否压缩rdb文件 需要消耗一些cpu资源
rdbchecksum yes # 保存rdb文件的时候，进行错误检查
dir ./ # rdb文件保存的目录
```

> REPLICATION复制，主从复制

> SECURITY

可以在这里设置redis密码，默认是没有密码

> 限制 CLIENTS

```shell
# 设置最大客户端数量
maxclients 10000 
maxmemory <bytes>	# redis 配置最大的内存容量
maxmemory-policy noeviction	# redis内存到达上限后的处理策略
	1、volatile-lru：只对设置了过期时间的key进行LRU（默认值） 
	2、allkeys-lru ： 删除lru算法的key   
	3、volatile-random：随机删除即将过期key   
	4、allkeys-random：随机删除   
	5、volatile-ttl ： 删除即将过期的   
	6、noeviction：永不过期，返回错误
```

>  APPEND ONLY MODE  aof的配置

```shell
appendonly no # 默认是不开启aof模式，默认是使用rdb方式持久化的，在大部分所有情况下，rdb完全够常用
appendfilename "appendonly.aof" # 持久化文件名字

# appendfsync always # 每次修改都会sync，消耗性能
appendfsync everysec # 每秒同步一次sync，可能会丢失这1s的数据
# appendfsync no # 不执行sync，这个时候操作系统自己同步数据，速度最快
```

### Redis持久化

Redis 是内存数据库，如果不将内存中的数据库状态保存到磁盘，那么一旦服务器进程退出，服务器中的数据库状态也会消失。所
以Redis提供了持久化功能！

#### RDB (Redis DataBase)

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Foscimg.oschina.net%2Foscnet%2Fcceeb085e2730b934b5d67905fe49631d60.jpg&refer=http%3A%2F%2Foscimg.oschina.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648645251&t=069972bfb77b7b3c6fc83b3dc461154d)

> 什么是RDB

在指定的时间间隔内将内存中的数据集快照写入磁盘，也就是行话讲的Snapshot快照，它恢复时是将快照文件直接读到内存里。Redis会单独创建`（fork）一个子进程来进行持久化`，会先将数据写入到一个临时文件中，待持久化过程都结束了，再用这个临时文件替换上次持久化好的文件。整个过程中，主进程是不进行任何IO操作的。这就确保了极高的性能。如果需要进行大规模数据的恢复，且对于数据恢复的完整性不是非常敏感，那RDB方式要比AOF方式更加的高效。RDB的缺点是最后一次持久化后的数据可能丢失。

> 触发机制

1、save的规则满足的情况下，会自动触发rdb规则

2、执行flushall命令，也会触发

3、退出redis，也会产生rdb文件

备份就会自动生成一个dump.rdb

> 如何恢复rdb文件！

1、只需要把dump.rdb文件放在redis的启动目录就可以

2、查看需要存的位置

```shell
127.0.0.1:6379> config get dir
1) "dir"
2) "/data" # 如果这个目录下存在dump.rdb文件，启动的时候就会自动恢复
```

**优点：**

- 适合大规模的数据恢复
- 对数据的完整性要求不高！

**缺点：**

- 需要一定的时间间隔进行操作！如果redis意外宕机了，这个最后一次修改数据就没有了
- fork进程的时候，会阻塞主线程



#### AOF(Append Only File)

将我们得所有命令都记录下来，history，恢复的时候就是把这个文件全部执行一遍

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.showdoc.cc%2Fserver%2Fapi%2Fcommon%2Fvisitfile%2Fsign%2F0f6d07aa611c5de018bd14dd74b35f4b%3Fshowdoc%3D.jpg&refer=http%3A%2F%2Fwww.showdoc.cc&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648645336&t=4694327fabecc16d0d13e8840efeaf84)

​        以日志的形式来记录每个写操作，将Redis执行过的所有指令记录下来（读操作不记录），只许追加文件但不可以改写文件，redis启动之初会读取该文件重新构建数据，换言之，redis重启的话就根据日志文件的内容将写指令从前到后执行一次以完成数据的恢复工作

​		如果这个aof有错位，这个时候redis是启动不起来的，我们需要修复这个文件，`redis-check-aof --fix`

​		如果文件太大，默认64mb，会重新一个文件（删除重复的命令）

> 优点和缺点

**优点：**

	- 每一次修改都同步，文件完整性更加好
	- 每秒同步一次，可能会丢失数据

**缺点：**

	- 相对于数据文件来说，aof远大于rdb，修复的速度也比rdb慢
	- 运行效率也比rdb慢



### Redis发布订阅

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.w3xue.com%2Ffiles%2Fa20205%2F20200518084221361.png&refer=http%3A%2F%2Fwww.w3xue.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648647802&t=b2307d1d4a6365fd60e1a1127c123211)

第一个：消息发送者，第二个：频道，第三个：消息订阅者！

![](https://img0.baidu.com/it/u=4093550044,1178047779&fm=253&fmt=auto&app=138&f=PNG?w=349&h=291)

> 测试

**订阅端**

```shell
127.0.0.1:6379> SUBSCRIBE tang
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "tang"
3) (integer) 1
1) "message"
2) "tang"
3) "hello"
```

**发送端：**

```shell
127.0.0.1:6379> PUBLISH tang hello
(integer) 1
```

使用场景：

​	1、实时聊天

​	2、实时消息系统！

​	3、订阅、关注系统都可以的

### Redis主从复制

![image-20220228221510340](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228221510340.png)

#### 环境配置

只配置从库，不配置主库

查看redis信息

```shell
127.0.0.1:6379> info replication
# Replication
role:master # 主节点
connected_slaves:0
master_failover_state:no-failover
master_replid:588185ea7b65cf1905a0467d06eb3e796f95015c
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0
```



```shell
6378 为主节点
docker run -p 6377:6379 --name redis-1 -v /appdata/redis/conf/redis.conf:/etc/redis  -d redis redis-server /etc/redis/redis.conf --appendonly yes
docker run -p 6376:6379 --name redis-2 -v /appdata/redis/conf/redis.conf:/etc/redis  -d redis redis-server /etc/redis/redis.conf --appendonly yes
docker run -p 6375:6379 --name redis-3 -v /appdata/redis/conf/redis.conf:/etc/redis  -d redis redis-server /etc/redis/redis.conf --appendonly yes
```

#### 一主三从

```shell
127.0.0.1:6379> SLAVEOF 10.0.20.13 6378 # 配置主机
OK
127.0.0.1:6379> info replication
# Replication
role:slave
master_host:10.0.20.13
master_port:6378
master_link_status:down
master_last_io_seconds_ago:-1
master_sync_in_progress:0
slave_read_repl_offset:1
slave_repl_offset:1
master_link_down_since_seconds:-1
slave_priority:100
slave_read_only:1
replica_announced:1
connected_slaves:0
master_failover_state:no-failover
master_replid:588185ea7b65cf1905a0467d06eb3e796f95015c
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0
=================================主机中信息===================================
119.91.204.244:0>info replication
"# Replication
role:master
connected_slaves:3 #三个从机
slave0:ip=172.17.0.14,port=6379,state=online,offset=182,lag=0
slave1:ip=172.17.0.15,port=6379,state=online,offset=182,lag=0
slave2:ip=172.17.0.16,port=6379,state=online,offset=182,lag=0
master_failover_state:no-failover
master_replid:34b65b564ce619c16a055aeb67d7f0800be112fd
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:182
second_repl_offset:-1
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:1
repl_backlog_histlen:182
```

如果是docker启动

```
# 先查看内网
docker docker inspect redis
# 如果主机设置了密码 配置密码就在从机中使用config set masterauth <password> 或者在从机配置文件添加配置masterauth <password>
```

![image-20220228233008271](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228233008271.png)



真是主从配置是在配置文件中配置，命令中配置是暂时的

> Replication

![主机配置](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228233417615.png)主机配置

![image-20220228233448740](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228233448740.png)主机密码配置

> 细节

主机可以设置值，从机只能读

![image-20220228233702247](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228233702247.png)**从机不能写**

测试：主机断开连接，从机依然连接主机，但是没有写操作了，主机重新连接可以继续写

如果使用命令行配置重启后就会变成主机

![image-20220228234140873](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220228234140873.png)

> 层层链路

上一个M链接下一个S

![image-20220301000212984](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220301000212984.png)

这时候也可以主从复制



> 如果没有老大，选一个出来

如果主机断开连接，我们可以使用`SLAVEOF no one`让自己变成主机，如果这时候主机恢复了只能重新连接

#### 哨兵模式

（自动选举老大的模式）

> 概述

![image-20220301000906618](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220301000906618.png)

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fupload-images.jianshu.io%2Fupload_images%2F7896890-884d5be9a2ddfebc.png&refer=http%3A%2F%2Fupload-images.jianshu.io&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648656627&t=6ab1e5beaa0ba4ed4bdccb3ec098a23c)

![image-20220301001127494](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220301001127494.png)

![image-20220301001213248](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220301001213248.png)

> 测试

1、配置哨兵配置文件

```shell
vim sentinel.conf
# sentinel monitor 被监控的名称 host port 1
sentinel monitor myredis 172.17.0.4 6379 1
# 如果主机有密码配置密码
sentinel auth-pass <master-name> <password>
```

后面的这个数字1，代表主机挂了，slave投票看让谁接替成为主机，票树最多的，就会成为主机

2、启动哨兵

```shell
root@c214f8afdc77:/usr/local/bin# redis-sentinel /etc/redis/redis.conf/sentinel.conf
```

如果主机此时回来了，只能归并在新的master下

**优点：**

- 哨兵集群，基于主从复制模式，所有的主从配置优点，它全有
- 主从可以切换，故障可以转移，系统的可用性就会更好
- 哨兵模式就是主从模式的升级，手动到自动，更加健壮

**缺点:**

- Redis不好在线扩容，集群容量一旦达到上限，在线扩容就十分麻烦
- 实现哨兵模式配置很麻烦，其中很多选择

> 哨兵模式的全部

```shell
1.port 26379
# sentinel监听端口，默认是26379，可以修改。

2.sentinel monitor <master-name> <ip> <redis-port> <quorum>
# 告诉sentinel去监听地址为ip:port的一个master，这里的master-name可以自定义，quorum是一个数字，指明当有多少个sentinel认为一个master失效时，master才算真正失效。master-name只能包含英文字母，数字，和“.-_”这三个字符需要注意的是master-ip 要写真实的ip地址而不要用回环地址（127.0.0.1）。配置示例：
sentinel monitor mymaster 192.168.0.5 6379 2

3.sentinel auth-pass <master-name> <password>
#设置连接master和slave时的密码，注意的是sentinel不能分别为master和slave设置不同的密码，因此master和slave的密码应该设置相同。
# 配置示例：
sentinel auth-pass mymaster 0123passw0rd

4.sentinel down-after-milliseconds <master-name> <milliseconds> 
# 这个配置项指定了需要多少失效时间，一个master才会被这个sentinel主观地认为是不可用的。 单位是毫秒，默认为30秒
# 配置示例：
sentinel down-after-milliseconds mymaster 30000

5.sentinel parallel-syncs <master-name> <numslaves> 
这个配置项指定了在发生failover主备切换时最多可以有多少个slave同时对新的master进行 同步，这个数字越小，完成failover所需的时间就越长，但是如果这个数字越大，就意味着越 多的slave因为replication而不可用。可以通过将这个值设为 1 来保证每次只有一个slave 处于不能处理命令请求的状态。
配置示例：
sentinel parallel-syncs mymaster 1

6. sentinel failover-timeout <master-name> <milliseconds>
failover-timeout 可以用在以下这些方面： 

      1. 同一个sentinel对同一个master两次failover之间的间隔时间。
      2. 当一个slave从一个错误的master那里同步数据开始计算时间。直到slave被纠正为向正确的master那里同步数据时。
      3.当想要取消一个正在进行的failover所需要的时间。  
      4.当进行failover时，配置所有slaves指向新的master所需的最大时间。不过，即使过了这个超时，slaves依然会被正确配置为指向master，但是就不按parallel-syncs所配置的规则来了。
配置示例：
sentinel failover-timeout mymaster1 20000

7.sentinel的notification-script和reconfig-script是用来配置当某一事件发生时所需要执行的脚本，可以通过脚本来通知管理员，例如当系统运行不正常时发邮件通知相关人员。对于脚本的运行结果有以下规则：
        若脚本执行后返回1，那么该脚本稍后将会被再次执行，重复次数目前默认为10
        若脚本执行后返回2，或者比2更高的一个返回值，脚本将不会重复执行。
        如果脚本在执行过程中由于收到系统中断信号被终止了，则同返回值为1时的行为相同。
        一个脚本的最大执行时间为60s，如果超过这个时间，脚本将会被一个SIGKILL信号终止，之后重新执行。

1).sentinel notification-script <master-name> <script-path> 
通知型脚本:当sentinel有任何警告级别的事件发生时（比如说redis实例的主观失效和客观失效等等），将会去调用这个脚本，这时这个脚本应该通过邮件，SMS等方式去通知系统管理员关于系统不正常运行的信息。调用该脚本时，将传给脚本两个参数，一个是事件的类型，一个是事件的描述。如果sentinel.conf配置文件中配置了这个脚本路径，那么必须保证这个脚本存在于这个路径，并且是可执行的，否则sentinel无法正常启动成功。
  配置示例：
 sentinel notification-script mymaster /var/redis/notify.sh

2).sentinel client-reconfig-script <master-name> <script-path>
 当一个master由于failover而发生改变时，这个脚本将会被调用，通知相关的客户端关于master地址已经发生改变的信息。以下参数将会在调用脚本时传给脚本:
       <master-name> <role> <state> <from-ip> <from-port> <to-ip> <to-port>
目前<state>总是“failover”, <role>是“leader”或者“observer”中的一个。 参数 from-ip, from-port, to-ip, to-port是用来和旧的master和新的master(即旧的slave)通信的。这个脚本应该是通用的，能被多次调用，不是针对性的。
   配置示例：
sentinel client-reconfig-script mymaster /var/redis/reconfig.sh
```



### Redis缓存穿透和雪崩

#### **缓存穿透**

查不到，直接访问db

> 解决方案

1、布隆过滤器

2、缓存空对象

#### **缓存击穿：**

热点key，当这个key瞬间失效

> 解决方案

1、设置热点数据永不过期

2、加互斥锁

  - 分布式锁：保证每个key同时只有一个线程去查询后端服务，其他线程没有获得分布式锁的权限，只需等待。



#### 缓存雪崩

某一个时间段，缓存集中过期失效，缓存集中过期失效，或Redis宕机！

> 解决方案

1、redis高可用

2、限流降级

3、数据预热

