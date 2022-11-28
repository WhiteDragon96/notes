- [SQL](#sql)
  - [DISTINCT 去重](#distinct-去重)
  - [GROUP BY](#group-by)
    - [HAVING 可以指定筛选](#having-可以指定筛选)
    - [配合聚合函数](#配合聚合函数)
  - [数据库批量插入](#数据库批量插入)
- [Aspect](#aspect)
- [Redis](#redis)
- [设计模式](#设计模式)
  - [建造者模式](#建造者模式)
### SQL
#### DISTINCT 去重
- distinct 只能放在所有字段前面，并且后面的字段都会生效
  ```SQL
    select distinct id, name from table_name
    会把 id,name 一样的归为一条
  ```

#### GROUP BY 
- group by 字段 可以根据不同字段分组 随机显示一条
##### HAVING 可以指定筛选
    是对group by后的结果进行筛选
  ```SQL
    select * from user where name = '张三' HAVING age < 15;
    搜索名字叫张三小于15岁的
  ```
##### 配合聚合函数
常见聚合函数：count() 计数、sum() 求和、avg() 平均数、max() 最大值、min() 最小值

#### 数据库批量插入
  insertBatch插入方式比for循环插入方式效率更高。
  ```SQL
    <insert id="insertBatch">
        INSERT INTO t_user
        (id, name, password)
        VALUES
        <foreach collection ="userList" item="user" separator =",">
            (#{id}, #{name}, #{password})
        </foreach >
    </insert>
  ```

#### SUBSTRING_INDEX 

按分隔符截取字符串

返回一个 str 的子字符串，在 delimiter 出现 count 次的位置截取。
如果 count > 0，从则左边数起，且返回位置前的子串；
如果 count < 0，从则右边数起，且返回位置后的子串。

delimiter 是大小写敏感，且是多字节安全的。

```sql
SUBSTRING_INDEX(str, delimiter, count)
mysql> SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2); -> 'www.mysql'

mysql> SELECT SUBSTRING_INDEX('www.mysql.com', '.', -2); -> 'mysql.com'
```



### Aspect


### Redis
redis key命名时为什么防止重复一般 前缀+key,前缀名名时用：分开可以建立目录， 比如， dic:dic2: + key


### 设计模式

#### 建造者模式
思路：
- 在Bean内新建一个静态内部类，XxxBuilder
- 把Bean内所有参数复制到XxxBuilder,然后在XxxBuild新建必须含有参数的构造器，其他参数使用变量名作为方法然后返回自身（this）以便形成链式调用；
- 在 Bean 类里面新建一个接收 XxxBuilder 参数的私有构造器，避免使用 new 创建对象；
- 在 XxxBuilder 类新建一个 build 方法开始构建 Bean 类，也是作为链式调用的结束；
  ```Java
  @Data
  public class Task {
  
      private Long id;
      private String name;
      private String content;
      private int type;
      private int status;
  
      public Task(Long id, String name, String content, int type, int status) {
          this.id = id;
          this.name = name;
          this.content = content;
          this.type = type;
          this.status = status;
      }
  
      public Task(TaskBuilder taskBuilder) {
          this.id = taskBuilder.id;
          this.name = taskBuilder.name;
          this.content = taskBuilder.content;
          this.type = taskBuilder.type;
          this.status = taskBuilder.status;
      }
  
      public static class TaskBuilder {
          private Long id;
          private String name;
          private String content;
          private int type;
          private int status;
  
          public TaskBuilder(Long id, String name) {
              this.id = id;
              this.name = name;
          }
  
          public TaskBuilder content(String content) {
              this.content = content;
              return this;
          }
  
          public TaskBuilder type(int type) {
              this.type = type;
              return this;
          }
  
          public TaskBuilder status(int status) {
              this.status = status;
              return this;
          }
  
          public Task build() {
              return new Task(this);
          }
      }
  }
  
  test:
  Task task = new Task.TaskBuilder(1239878L,"迪丽热巴").build();
  Task task1 = new Task.TaskBuilder(9527L,"古力娜扎").status(1).type(2).build();
  ```
  Lombok @Builder注解支持，易维护

### CPU占用过高排查方法

```
1.先用top命令,找到cpu占用最高的进程 PID

2.再用ps -mp pid -o THREAD,tid,time 查询pid进程中,那个线程的cpu占用率高 记住TID

3.jstack 29099 >> xxx.log 打印出29099该进程下线程日志

4.将xxx.log 日志文件下载到本地

5.将查找到的 线程占用最高的 tid 第二步查到的线程 29108 转成16进制 — 71b4

6.打开下载好的 xxx.log 通过 查找方式 找到 对应线程 进行排查
```



### 通过thumbnailator压缩图片

```xml
1、引入依赖
<dependency>
   <groupId>net.coobird</groupId>
   <artifactId>thumbnailator</artifactId>
   <version>0.4.8</version>
</dependency>

// scale: 缩小的倍数，1代表保持原有的大小(默认1) 范围 1 - 0
// outputQuality : 压缩的质量，1代表保持原有的质量(默认1) 范围 1 - 0
 
Thumbnails.of(new String[]{"源图片路径.jpg"}).scale(1D).outputQuality(0.5).toFile("输出路径.jpg");
```

#### thumbnailator 应发 OutOfMemoryError: Java heap space

thumbnailator库对图片的要求其实是极其严苛的，对图片的处理会消耗大量的内存，Thumbnailator需要加载原始图像，大致需要至少两倍的宽度*高度* 4个字节的堆空间。例如，一个20M像素的图像需要160 MB的堆。这个数字计算出来相当惊人了，一般对于JVM的内存会设置在1G左右，然而单次请求一个图片裁剪接口就占用了大量的内存！！！

解决方法：

​	1、调整JVM的内存大小，2、可以对原图片做限制，大于多少像素提示用户图片不符合。或者你也可以使用其他的第三方库，例如：ImageMagick



### springboot集成mybatis-plus

- 引入 mysql：mysql-connector-java，连接池Druid：druid-spring-boot-starter，Mybatis-plus：mybatis-plus-boot-starter
- 配置：添加MapperScan，配置driver-class-name，datasource.type
- xml中要配置打包文件加上xml，不然找不到

```xml
	<build>	
		<resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.xml</include>
                </includes>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
            </resource>
        </resources>
    </build>
```

