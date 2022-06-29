### 其他

- 使用redis缓存登录次数+过期时间，限制用户输入密码次数过多，防止暴力破解。
- aspect配合EventListener，自定义ApiLog完成注解加log。

#### 前端定义一个显示按钮 赋值一个布尔值

top-notice.vue 有记录




自带service没结果查出来是个null,mapper没结果会是个空的对象

#### select...for update使用方法

select * from t for update 会等待行锁释放之后，返回查询结果。
select * from t for update nowait 不等待行锁释放，提示锁冲突，不返回结果
select * from t for update wait 5 等待5秒，若行锁仍未释放，则提示锁冲突，不返回结果
select * from t for update skip locked 查询返回查询结果，但忽略有行锁的记录

#### 判断一个状态是否包含

```Java
  Optional<AnimalChangeReasonEnum> any = Arrays.stream(AnimalChangeReasonEnum.values())
				.filter(acre -> acre.getReason().equals(animal.getReason()))
				.findAny();
			if (!any.isPresent()) {
				throw new Exception("没有预料到的利用类型");
			}
```

实体类链式@Accessors(chain = true)

工具类库：Guava，hutool

wsl上Linux
username:tangcs password 7167*****59

#### 构建父子module

- 新建一个父module，packaging改为pom

```xml
<packaging>pom</packaging>
```

- 子moudle parent的改为父

```xml
	<parent>
        <artifactId>yongkang-wetland-boot</artifactId>
        <groupId>org.springblade</groupId>
        <version>2.9.0.RELEASE</version>
    </parent>
```

- 子moudle的jar和父module jar的关系

如果父pom中使用的是

```xml
<dependencies>....</dependencies>
```

的方式，则子pom会自动使用pom中的jar包，
如果父pom使用

```xml
<dependencyManagement>
    <dependencies>....</dependencies>
</dependencyManagement>
```

方式，则子pom不会自动使用父pom中的jar包，这时如果子pom想使用的话，就要给出groupId和artifactId，无需给出version

> <dependencyManagement> 是管理子类jar版本的





### SpringCloud

#### @FeignClient注解详解

FeignClient注解被@Target(ElementType.TYPE)修饰，表示FeignClient注解的作用目标在接口上

声明接口之后，在代码中通过@Resource注入之后即可使用。@FeignClient标签的常用属性如下：

- name：指定FeignClient的名称，如果项目使用了Ribbon，name属性会作为微服务的名称，用于服务发现
- url: url一般用于调试，可以手动指定@FeignClient调用的地址
- decode404:当发生http 404错误时，如果该字段位true，会调用decoder进行解码，否则抛出FeignException
- configuration: Feign配置类，可以自定义Feign的Encoder、Decoder、LogLevel、Contract
- fallback: 定义容错的处理类，当调用远程接口失败或超时时，会调用对应接口的容错逻辑，fallback指定的类必须实现@FeignClient标记的接口
- fallbackFactory: 工厂类，用于生成fallback类示例，通过这个属性我们可以实现每个接口通用的容错逻辑，减少重复的代码
- path: 定义当前FeignClient的统一前缀



### SpringBoot

