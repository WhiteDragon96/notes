- 使用redis缓存登录次数+过期时间，限制用户输入密码次数过多，防止暴力破解。
- aspect配合EventListener，自定义ApiLog完成注解加log。



## 前端定义一个显示按钮 赋值一个布尔值
top-notice.vue 有记录


## 书单
《把时间当做朋友》
《被讨厌的勇气》
《非暴力沟通》

CREATE TABLE `taitan_aco_sync_log` (
  `id` bigint(64) NOT NULL COMMENT '主键',
  `log_type` int(10) DEFAULT NULL COMMENT '许可类型 1-猎捕许可、2-繁育许可、3-动物利用许可、4-进出口许可',
  `ywlsh` bigint(64) DEFAULT NULL COMMENT '外部业务流水号',
  `is_success` int(2) DEFAULT '0' COMMENT '是否同步成功 0-成功 1-失败',
  `fail_reason` text DEFAULT NULL COMMENT '失败原因 ',
  `original_data` text DEFAULT NULL COMMENT '原始数据内容 ',
  `is_handle` int(2) DEFAULT '0' COMMENT '是否处理 0-未处理 1-已处理',
  `handle_number` bigint(64) DEFAULT '0' COMMENT '重试次数',
  `handle_status` int(2) DEFAULT NULL COMMENT '处理状态 0-成功 1-失败',
  `data_time` datetime DEFAULT NULL COMMENT '业务数据时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` int(2) DEFAULT '0' COMMENT '是否已删除0-未删除 1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='泰坦同步日志表';



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



自带service没结果查出来是个null,mapper没结果会是个空的对象