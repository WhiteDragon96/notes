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

