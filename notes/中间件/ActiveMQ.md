## **ActiveMQ**

### JMS规范
  ---   
### 消息中间件的角色 <br/>
- Queue：队列存储，常用于点对点模型，默认只能由唯一的消费者处理。一旦处理消息删除。
- Topic：主题存储，用于订阅/发布消息模型，主题中的消息，会发送给所有消费者同时处理。只有在消息可以重复处理的业务场景可以使用。
- ConnectionFactory：连接工厂，客户用来创建连接对象，例如，ActiveMQ提供的ActiveMQConnectionFactory。
- Connection：JMS Connection封装了客户与JMS提供者之间的一个虚拟连接。
- Destination：消息的目的地，目的地是客户用来指定它生产的消息的目标和它消费的消息的来源的对象。

### JMS消息格式
#### JMS消息由下面三部分组成：
- 消息头：每个字段都有对应的getter和setter方法
- 消息属性：如果需要除消息头字段以外的值，那么可以使用消息属性。
- 消息体：JMS定义消息类型有TextMessage、MapMessage、BytesMessage、StreamMessage和ObjectMessage

    
   