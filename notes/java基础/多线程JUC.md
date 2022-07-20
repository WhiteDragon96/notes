# JUC并发编程

### 1、什么是JUC

源码+官方文档

![image-20211028153822963](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211028153822963.png)

业务：普通的线程代码 THread

Runnable 没有返回值、效率相比 Callable相对

### 2、线程和进程

进程：一个程序，QQ。exe Music.exe 程序集合；一个进程有多个线程

java有`两个`线程：main、GC

线程：开一个进程 Typora,写字，自动保存（线程负责）

### 5、8锁对象

new：this 具体的一个手机

static：锁的是 Class模板

### 6、集合类不安全

> List 不安全

```java
public class ListTest {
    public static void main(String[] args) {
        // 并发下 ArrayList 不安全的
        /**
         * 解决方案：
         * 1、List<String> list = new Vector<>();
         * 2、List<String> list = Collections.synchronizedList(new ArrayList<>());
         * 3、List<String> list = new CopyOnWriteArrayList<>();
         *  CopyOnWrite 写入时复制 COW 计算机程序设计领域的一种优化策略；
         *  多个线程调用的时候，list，读取的时候，固定的，写入（覆盖）
         *  在写入的时候避免覆盖，造成数据问题 读写分离
         *  CopyOnWriteArrayList 和 Vector 比较：
         *
         */
//        List<String> list = new ArrayList<>();
//        List<String> list = new Vector<>();
//        List<String> list = Collections.synchronizedList(new ArrayList<>());
        List<String> list = new CopyOnWriteArrayList<>();

        for (int i = 0; i < 10; i++) {
            new Thread(() -> {
                list.add(UUID.randomUUID().toString().substring(0, 5));
                System.out.println(list);
            }, String.valueOf(i)).start();

        }
    }
}
```

  

> Set 不安全

```java
/**
 * 同理可证 java.util.ConcurrentModificationException
 *
 * 1、Set<String> set = Collections.synchronizedSet(new HashSet<>());
 */
public class SetTest {
    public static void main(String[] args) {
//        Set<String> set = new HashSet<>();
        Set<String> set = Collections.synchronizedSet(new HashSet<>());
        for (int i = 0; i < 30; i++) {
            new Thread(() -> {
                set.add(UUID.randomUUID().toString().substring(0, 8));
                System.out.println(set);
            }, "t" + i).start();
        }
    }
}
```

hashSet 底层是什么？

```java
public HashSet() {
        map = new HashMap<>();
    }
// add set 本质是 map key是无法重复的
public boolean add(E e) {
        return map.put(e, PRESENT)==null;
    }
private static final Object PRESENT = new Object(); // 不变的值    
```



> map 不安全

```java

    /**
     * The default initial capacity - MUST be a power of two.
     */
    static final int DEFAULT_INITIAL_CAPACITY = 1 << 4; // aka 16

    /**
     * The maximum capacity, used if a higher value is implicitly specified
     * by either of the constructors with arguments.
     * MUST be a power of two <= 1<<30.
     */
    static final int MAXIMUM_CAPACITY = 1 << 30;

    /**
     * The load factor used when none specified in constructor.
     */
    static final float DEFAULT_LOAD_FACTOR = 0.75f;
```

`test`

```java
/**
 * java.util.ConcurrentModificationException
 *
 * 1、 Map<String, String> map = Collections.synchronizedMap(new HashMap<>(16, 0.75f));
 * 2、 Map<String, String> map = new ConcurrentHashMap<>(16, 0.75f);
 */
public class MapTest {
    public static void main(String[] args) {
        // map 是这样用的吗？ 不是 工作中不用HashMap
        // 默认等价于什么? new HashMap<>(16, 0.75f);
//        Map<String, String> map = new HashMap<>(16, 0.75f);
//        Map<String, String> map = Collections.synchronizedMap(new HashMap<>(16, 0.75f));
        Map<String, String> map = new ConcurrentHashMap<>(16, 0.75f);
        for (int i = 0; i < 30; i++) {
            new Thread(() -> {
                map.put(Thread.currentThread().getName(), UUID.randomUUID().toString().substring(0, 5));
                System.out.println(map);
            },"t" + i).start();
        }
    }
}
```

### 7、Callable

1、可以有返回值

2、可以抛出异常

3、方法不同，run()/call()

> 代码测试

```java
public class CallAbleTest {
    public static void main(String[] args) {
        // new Thread(new Runnable)).start();
        // new Thread(new FutureTask<String>(new Callable<String>()).start();
        // new THread(new FutureTask<V>(new Callable<V>()).start();
        new Thread().start();// 怎么启动Callable
        MyThread myThread = new MyThread();
        FutureTask futureTask = new FutureTask(myThread);
        new Thread(futureTask,"A").start();
        new Thread(futureTask,"B").start();
        try {
            // 获取返回结果 方法可能产生阻塞 把它放到最后/或者使用异步通信
            String o = String.valueOf(futureTask.get());
            System.out.println(o);
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
    }
}

class MyThread implements Callable<String>{

    // Callable<V> 的 V 是什么类型就返回什么类型
    @Override
    public String call() throws Exception {
        System.out.println("call()");
        return "call";
    }
}
```

细节：

1、结果有缓存

2、结果可能需要等待，有阻塞

### 8、常用的辅助类

 #### 8.1 CountDownLatch

> 允许一个或多个线程等待直到在其他线程中执行的一组操作完成的同步辅助，减法计数器

```java
// 计数器
public class CountDownLatchTest {
    public static void main(String[] args) throws InterruptedException {
        // 总数是6
        CountDownLatch countDownLatch = new CountDownLatch(6);
        for (int i = 0; i < 6; i++) {
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + " Go out");
                countDownLatch.countDown(); //数量-1
            }, "线程" + i).start();
        }
        countDownLatch.await(); //等待计数器归零，然后再向下执行
        System.out.println("close the door");
    }
}
```

原理：

​	`countDownLatch.countDown();` // 数量-1

​	`countDownLatch.await(); `// 等待计数器归零，然后向下执行

每次有线程调用 countDown()数量-1，假设计数器变为0，countDownLatch.await()就会被唤醒，继续执行！

#### 8.2 CyclicBarrier

> 加法计数器 

```java
public class CyclicBarrierTest {
    public static void main(String[] args) {
        /**
         * 集齐7颗龙珠招唤神龙
         */
        // 招唤龙珠的线程
        CyclicBarrier cyclicBarrier = new CyclicBarrier(7, () -> {
            System.out.println("招唤神龙成功");
        });
        for (int i = 0; i < 7; i++) {
            final int temp = i;
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + "招唤第" + temp  + "颗龙珠");
                try {
                    cyclicBarrier.await();
                } catch (InterruptedException | BrokenBarrierException e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }
}
```



#### 8.3 Semaphore

> 信号量

抢车位！

6车---3个停车位置

```JAVA
public class SemaphoreTest {
    public static void main(String[] args) {
        // 3个线程数量，停车位 限流!
        Semaphore semaphore = new Semaphore(3);
        for (int i = 0; i < 6; i++) {
            new Thread(() -> {
                try {
                    // acquire()方法是一个阻塞方法，如果没有车位，则会一直等待
                    semaphore.acquire();
                    System.out.println(Thread.currentThread().getName() + "抢到车位");
                    TimeUnit.SECONDS.sleep(2);
                    System.out.println(Thread.currentThread().getName() + "离开车位");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }finally {
                    // release() 释放
                    semaphore.release();
                }
            },"t" +i).start();
        }
    }
}
```



**原理：**

`acquire()`获得，假设如果已经满了，等待，等待被释放位置

`release();`释放，会将当前的型号量释放+1,然后唤醒等待的线程！

作用：多个共享资源互斥的使用！并发限流，控制最大线程数



### 9、读写锁

```java

/**
 * 独占锁（写锁）一次只能被一个线程占有
 * 共享锁（读锁） 多个线程同时占有
 * ReadWriteLock
 * 
 * 读-读  可以共存
 * 读-写  不能共存
 * 写-写  不能共存
 */
public class ReadWriteLockDemo {
    public static void main(String[] args) {
        MyCacheLock myCache = new MyCacheLock();
        for (int i = 0; i < 5; i++) {
            final int temp = i;
            MyThreadPool.executor.execute((() -> {
                myCache.put(temp+"",temp+"");
            }));
        }
        //读取
        for (int i = 0; i < 5; i++) {
            final int temp = i;
            MyThreadPool.executor.execute((() -> {
                myCache.get(temp+"");
            }));
        }
    }
}

/**
 * 自定义缓存
 */
class MyCache {
    private volatile Map<String,Object> map = new HashMap<>();

    // 存
    public void put(String key,Object value){
        System.out.println(Thread.currentThread().getName() + "写入"+key);
        map.put(key,value);
        System.out.println(Thread.currentThread().getName() + "写入完成");
    }

    // 取
    public void get(String key){
        System.out.println(Thread.currentThread().getName() + "读取" + key);
        Object o = map.get(key);
        System.out.println(Thread.currentThread().getName() + "读取完成" + o);
    }
}

/**
 * 加锁的
 */
class MyCacheLock {
    private volatile Map<String,Object> map = new HashMap<>();
    // 读写锁：更加细粒度的控制
    private ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
    // 存 写入的时候，只希望只有一个线程写
    public void put(String key,Object value){
        readWriteLock.writeLock().lock();
        try {
            System.out.println(Thread.currentThread().getName() + "写入"+key);
            map.put(key,value);
            System.out.println(Thread.currentThread().getName() + "写入完成");
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            readWriteLock.writeLock().unlock();
        }
    }

    // 取 所有人都可以读
    public void get(String key){
        readWriteLock.readLock().lock();

        try {
            System.out.println(Thread.currentThread().getName() + "读取" + key);
            Object o = map.get(key);
            System.out.println(Thread.currentThread().getName() + "读取完成" + o);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            readWriteLock.readLock().unlock();
        }

    }
}
```



### 10、阻塞队列

写入：如果队列满了，就必须阻塞等待

取：如果队列是空的，必须阻塞等待生产



#### BlockingQueue

什么情况下我们会使用阻塞队列：

多线程并发处理，线程池

**ArrayDeque**：双端队列，两边都可以取

**AbstractQueue**：优先级队列

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg2020.cnblogs.com%2Fblog%2F819676%2F202103%2F819676-20210306230508569-2050752848.png&refer=http%3A%2F%2Fimg2020.cnblogs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640356109&t=8ce2f08019de42bda137b10e26173431)

![](https://img2.baidu.com/it/u=2067310607,2873843712&fm=253&fmt=auto&app=138&f=PNG?w=722&h=500)

**四组API**

1、抛出异常

2、不抛出异常

3、阻塞等待

4、超时等待

| 方式         | 抛出异常 | 有放回置 | 阻塞 等待 | 超时等待 |
| ------------ | -------- | -------- | --------- | -------- |
| 添加         | add      | offer()  | put()     | offer()  |
| 移除         | remove   | poll()   | take()    | poll()   |
| 检测队首元素 | element  | peek     | -         | -        |

```java
	/**
     * 抛出异常
     */
    public static void test1(){
        //队列大小
        ArrayBlockingQueue blockingQueue = new ArrayBlockingQueue<>(3);

        System.out.println(blockingQueue.add("a"));
        System.out.println(blockingQueue.add("b"));
        System.out.println(blockingQueue.add("c"));

        System.out.println("-----------------------");
        // 抛出异常  Queue full
//        System.out.println(blockingQueue.add("d"));
        System.out.println(blockingQueue.remove());
        System.out.println(blockingQueue.remove());
        System.out.println(blockingQueue.remove());

        // 抛出异常  Queue empty
        //        System.out.println(blockingQueue.remove());
    }

 	/**
     * 不抛出异常
     */
    public static void test2(){
        //队列大小
        ArrayBlockingQueue blockingQueue = new ArrayBlockingQueue<>(3);

        System.out.println(blockingQueue.offer("a"));
        System.out.println(blockingQueue.offer("b"));
        System.out.println(blockingQueue.offer("c"));
        // 不跑出异常 fasle
        System.out.println(blockingQueue.offer("d"));

        System.out.println("-----------------------");

        System.out.println(blockingQueue.poll());
        System.out.println(blockingQueue.poll());
        System.out.println(blockingQueue.poll());
        // 不抛出异常 null
        System.out.println(blockingQueue.poll());
    }
```



> SynchronousQueue 同步容量 

没有容量

进去一个元素，必须等待取出来之后，才能再往里面放一个元素！

put、take

```java

/**
 * 同步队列
 * 和其他BlockingQueue 不一样 SynchronousQueue 不存储元素
 * put一个元素必须take出来才能在put
 */
public class SynchronousQueueDemo {
    public static void main(String[] args) {
        SynchronousQueue<String> queue = new SynchronousQueue<>();

        MyThreadPool.executor.execute(() -> {
            try {
                System.out.println(Thread.currentThread().getName() + " put 1");
                queue.put("1");
                System.out.println(Thread.currentThread().getName() + " put 2");
                queue.put("2");
                System.out.println(Thread.currentThread().getName() + " put 3");
                queue.put("3");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        MyThreadPool.executor.execute(() -> {
            try {
                TimeUnit.SECONDS.sleep(3);
                System.out.println(Thread.currentThread().getName() + " take " + queue.take());
                TimeUnit.SECONDS.sleep(3);
                System.out.println(Thread.currentThread().getName() + " take " + queue.take());
                TimeUnit.SECONDS.sleep(3);
                System.out.println(Thread.currentThread().getName() + " take " + queue.take());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

    }
}
```

### 11、线程池（重点）

线程池：3个大方法、7大参数、4种拒绝策略

> 池化技术：事先准备好一些资源，有人要用，就来我这里那，用完之后还给我

程序的运行，本质：占用系统的资源！优化资源的使用....创建、销毁，侍奉浪费资源

线程池、连接池、内存池、对象池



**线程池的有点**：

1、降低资源的消耗

2、提高响应的速度

3、方便管理

线程服用、可以控制并发数、管理线程



> 三大方法

```java
//Executors 工具类、3大方法
// 使用线程池之后，使用线程池来创建线程
public class Demo1 {
    public static void main(String[] args) {
//        ExecutorService pool = Executors.newSingleThreadExecutor();//单个线程
//        ExecutorService pool = Executors.newFixedThreadPool(5);//固定线程池
        ExecutorService pool = Executors.newCachedThreadPool();//缓存线程池 可伸缩

        try {
            for (int i = 0; i < 10; i++) {
                // 使用线程池之后，使用线程池来创建线程
                pool.execute(() -> {
                    System.out.println(Thread.currentThread().getName() + "执行了");
                });
            }
        } finally {
                // 线程池用完，程序结束，关闭线程池
            pool.shutdown();
        }


    }
}
```



> 七大参数

源码分析

```java
public static ExecutorService newSingleThreadExecutor() {
        return new FinalizableDelegatedExecutorService
            (new ThreadPoolExecutor(1, 1,
                                    0L, TimeUnit.MILLISECONDS,
                                    new LinkedBlockingQueue<Runnable>()));
    }

public static ExecutorService newFixedThreadPool(int nThreads) {
        return new ThreadPoolExecutor(nThreads, nThreads,
                                      0L, TimeUnit.MILLISECONDS,
                                      new LinkedBlockingQueue<Runnable>());
    }

public static ExecutorService newCachedThreadPool() {
        return new ThreadPoolExecutor(0, Integer.MAX_VALUE,//21亿
                                      60L, TimeUnit.SECONDS,
                                      new SynchronousQueue<Runnable>());
    }

public ThreadPoolExecutor(int corePoolSize, //核心线程池大小
                              int maximumPoolSize, // 最大线程大小
                              long keepAliveTime,//超时了没有人调用就会释放
                              TimeUnit unit,// 超时单位
                              BlockingQueue<Runnable> workQueue,//阻塞队列
                              ThreadFactory threadFactory,//线程工厂，创建线程的，一般不动
                              RejectedExecutionHandler handler// 拒绝·策略) {
        if (corePoolSize < 0 ||
            maximumPoolSize <= 0 ||
            maximumPoolSize < corePoolSize ||
            keepAliveTime < 0)
            throw new IllegalArgumentException();
        if (workQueue == null || threadFactory == null || handler == null)
            throw new NullPointerException();
        this.corePoolSize = corePoolSize;
        this.maximumPoolSize = maximumPoolSize;
        this.workQueue = workQueue;
        this.keepAliveTime = unit.toNanos(keepAliveTime);
        this.threadFactory = threadFactory;
        this.handler = handler;
    }
                          
 /**
 * 核心线程：不会被释放，一直开着的大小
 * 最大线程：当队列满了会达到最大
 */
```



> 手动创建线程池

```java
ExecutorService pool = new ThreadPoolExecutor(
                2,
                5,
                3,
                TimeUnit.SECONDS,
                new LinkedBlockingQueue<>(3),
                Executors.defaultThreadFactory(),
                new ThreadPoolExecutor.AbortPolicy());// 默认拒绝策略：不处理这个，直接抛异常
```



> 四种拒绝策略

1、AbortPolicy() ：队列满了 抛出异常

2、CallerRunsPolicy()：哪里来的去哪里

3、DiscardPolicy()：队列满了不会抛出异常

4、DiscardOldestPolicy：队列满了尝试和最早的竞争 ，竞争失败丢了，不会抛出异常



#### CPU密集型和IO密集型(调优)

> 最大线程到底改如何定义

1、CPU 密集型，几核就是几，可以保持CPU的效率最高！

```java
// 获取CPU线程数   
System.out.println(Runtime.getRuntime().availableProcessors());
```



2、IO 密集型 -> 判断你的程序中十分耗IO的线程

​			程序 15个大型任务 IO十分占用资源！



### 12、四大函数式接口（必须掌握）

lambda表达式、链式编程、函数式接口、Stream流式计算

> 函数式接口：只有一个方法的接口

```java
@FunctionalInterface
public interface Runnable {
    public abstract void run();
}
// 超级多FunctionalInterface
// 简化编程模型，再新版本的框架中大量应用
// foreach(消费者类的函数式接口)
```

![image-20211207194813518](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211207194813518.png)



**代码测试：**

> Function 函数式接口

![image-20211207195312357](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211207195312357.png)

```java
/**
 * Function 函数型接口,有一个输入，一个输出
 * 只要是函数式接口 可以用 Lambda表达式简化
 *
 * @author tcs
 * @date Created in 2021-12-07
 */
public class Demo01 {
    public static void main(String[] args) {
        // 工具类：输出输入的值
        Function function = new Function<String,String>() {
            @Override
            public String apply(String o) {
                return o;
            }
        };
        System.out.println(function.apply("hello"));
        // Lambda 表达式
        Function<String,String> function1 = (str) -> {return str;};
    }
}
```

> Predicate 断定型接口

![image-20211207200545022](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211207200545022.png)

```java

/**
 * 断定型接口：有一个输入参数，返回值只能是 布尔值！
 *
 * @author tcs
 * @date Created in 2021-12-07
 */
public class PredicateDemo {
    public static void main(String[] args) {
        Predicate<String> predicate = new Predicate<String>() {
            @Override
            public boolean test(String s) {
                return s.isEmpty();
            }
        };
        System.out.println(predicate.test(""));
        Predicate<String> predicate1 = (str) -> {return str.isEmpty();};
    }
}
```

> Consumer 消费型接口

```java
/**
 * 只有输入没有返回值
 *
 * @author tcs
 * @date Created in 2021-12-07
 */
public class ConsumerDemo {
    public static void main(String[] args) {
        // 打印字符串
        Consumer<String> consumer = new Consumer<String>() {
            @Override
            public void accept(String o) {
                System.out.println(o);
            }
        };
        consumer.accept("hello");
        Consumer<String> consumer1 = (str) -> {
            System.out.println(str);
        };
        consumer1.accept("world");
    }
}
```

> Supplier 供给型接口

```java
/**
 * 没有参数只有返回值
 *
 * @author tcs
 * @date Created in 2021-12-07
 */
public class SupplierDemo {
    public static void main(String[] args) {
        Supplier<String> supplier = new Supplier<String>() {
            @Override
            public String get() {
                return "1024";
            }
        };
        System.out.println(supplier.get());
        Supplier<String> supplier1 = () -> {return "1024";};
        System.out.println(supplier1.get());
    }
}
```



### 13、Stream流式计算

> 什么是Stream流式计算

集合、MySQL本质就是存储东西的

计算都应该交给流来计算

**流式计算**

```java
/**
 *  题目要求：一分钟内完成此题，只能用一行代码实现！
 *  现在有5个用户！筛选；
 *  1、ID 必须是偶数
 *  2、年龄必须大于23岁
 *  3、用户名转为大写字母率
 *  4、用户名字母倒着排序
 *  5、只输出一个用户!
 */
public class StreamDemo {
    public static void main(String[] args) {
        User user1 = new User(1,"a",21);
        User user2 = new User(2,"b",22);
        User user3 = new User(3,"c",23);
        User user4 = new User(4,"d",24);
        User user5 = new User(6,"e",25);
        List<User> list = Arrays.asList(user1, user2, user3, user4,user5);

        list.stream()
                .filter(user -> {return user.getId()%2==0;})
                .filter(user -> {return user.getAge()>23;})
                .map(user -> {return user.getName().toUpperCase();})
                .sorted((u1,u2) -> { return ((String) u1).compareTo(u2);})
                .forEach(System.out::println);
    }
}
```



### 14、ForkJoin

ForkJoin在JDK1.7，并行执行任务！提高效率，大数据量！  

[![ogJC8J.png](https://s4.ax1x.com/2021/12/07/ogJC8J.png)](https://imgtu.com/i/ogJC8J)

> ForkJoin特点：工作窃取

当任务1执行完了，回去任务2拿任务执行，任务是放在一个双端队列中



> 如何使用ForkJoin 





[![ogU4fO.png](https://s4.ax1x.com/2021/12/07/ogU4fO.png)](https://imgtu.com/i/ogU4fO)



### 15、异步调用

>Future 设计的初衷：对将来的某个事件的结果进行建模

```java
/**
* 异步调用：CompletableFuture
* // 异步执行
* // 成功回调
* // 失败回调
*/
public class FutureDemo1 {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        // 没有返回值的异步回调
        CompletableFuture<Void> completableFuture = CompletableFuture.runAsync(() ->{
            try {
                TimeUnit.SECONDS.sleep(2);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread().getName()+ "runAsync=>Void");
        });
        System.out.println("1111");
        completableFuture.get(); //获取执行结果
        System.out.println("2222");

        // 有返回值的异步回调 supplyAsync
        // 失败返回的是错误信息
        CompletableFuture<Integer> completableFuture1 = CompletableFuture.supplyAsync( () -> {
            System.out.println(Thread.currentThread().getName()+ "runAsync=>Integer");
//            int i= 1/0;
            return 1024;
        });

        Integer integer = completableFuture1.whenComplete((t, u) -> {
            System.out.println("t=>" + t); //正常返回结果
            System.out.println("u=>" + u); // 错误信息 u=>java.util.concurrent.CompletionException: java.lang.ArithmeticException: / by zero
        }).exceptionally((e) -> {
            e.getMessage();
            return 233;
        }).get();
        System.out.println(integer);
    }
}
```



### 16、JMM

> 谈谈对 Volatile 的理解

Volatile 是 Java虚拟机提供`轻量级的同步机制`

1、保证可见性

2、不保证原子性

3、禁止指令重排



> 什么是 JMM

JMM：Java 内存模型，不存在的东西，概念！约定！



**关于JMM的一些同步的约定：**

1、线程解锁钱，必须把共享变量立刻刷回主存

2、线程枷锁前，必须读取主存中的最新值到工作内存中！

3、加锁何解锁是同一把锁

[![oqShMq.png](https://s4.ax1x.com/2021/12/12/oqShMq.png)](https://imgtu.com/i/oqShMq)

[![oqpo6I.png](https://s4.ax1x.com/2021/12/12/oqpo6I.png)](https://imgtu.com/i/oqpo6I)

Java内存模型中定义了**8种操作**来完成，虚拟机保证了每种操作都是原子的。

- lock（锁定）：作用于主存的变量，把一个变量标识为一条线程独占状态。
- unlock（解锁）：作用于主存变量，把一个处于锁定状态的变量释放出来，释放后的变量才可以被其他线程锁定。
- read（读取）：作用于主存变量，把一个变量的值从主存传输到工作内存。
- load（载入）：作用于工作内存变量，把 read 来的值放入工作内存的变量副本中。
- use（使用）：作用于工作内存变量，把工作内存中一个变量的值传递给执行引擎，每当虚拟机遇到一个给变量赋值的字节码指令时执行这个操作。
- store（存储）：作用于工作内存变量，把工作内存中一个变量的值传送到主存。
- write（写入）：作用于主存变量，把 store 操作从工作内存中得到的变量的值放入主存的变量中。



问题：线程A不知道值已经变了

### 17、Volatile

> 1、保证可见性

```java
public class JMMDemo {
    // 不加volatile程序会死循环
    private volatile static  int num = 0;

    public static void main(String[] args) {
        new Thread( () -> {
            //线程一
            while (num == 0){

            }
        }).start();

        try {
            TimeUnit.SECONDS.sleep(2);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 线程一不知道num变了
        num = num +1;
        System.out.println(num);
    }
}
```

> 2、不保证原子性

原子性：不可分割

线程A在执行任务的时候，不能被打扰的，也不能被分割，要么同时成功，要么同时失败。

```java
// 不保证原子性
public class VDemo02 {
    private volatile static int num = 0;

    public  static void add() {
        num++;
    }

    public static void main(String[] args) {
        // 理论上num结果为2 万
        for (int i = 0; i < 20; i++) {
            new Thread(() -> {
                for (int i1 = 0; i1 < 1000; i1++) {
                    add();
                }
            }).start();
        }

        while (Thread.activeCount() > 2){// main gc 一定有两个线程存活，保证都执行完了
            Thread.yield();
        }
        System.out.println(num);
    }
}
```



**如果不加lock何synchronized怎么保证原子性**

javap -c *.class 可以编译成字节码文件

num++不是原子性操作

[![oqiz5T.png](https://s4.ax1x.com/2021/12/12/oqiz5T.png)](https://imgtu.com/i/oqiz5T)

使用原子类，解决原子性操作

AtomicBoolean

AtomicInteger

AtomicLong

```java
// 不保证原子性
public class VDemo02 {
//    private volatile static int num = 0;
    // 原子类的 Integer
    private volatile static AtomicInteger num = new AtomicInteger();

    public  static void add() {
       // num++; //不是一个原子性操作
        num.getAndIncrement();// AtomicInteger的+1方法 用的底层的CAS
    }

    public static void main(String[] args) {
        // 理论上num结果为2 万
        for (int i = 0; i < 20; i++) {
            new Thread(() -> {
                for (int i1 = 0; i1 < 1000; i1++) {
                    add();
                }
            }).start();
        }

        while (Thread.activeCount() > 2){// main gc 一定有两个线程存活，保证都执行完了
            Thread.yield();
        }
        System.out.println(num);
    }
}
```



> 原子类为什么可以原子操作

这些类的底层都直接和操作系统挂钩！在内存中修改值！Unsafe类是一个

很特殊的存在！



> 指令重排

什么是指令重排：**你写的程序，计算机并不是按照你写的那样执行的。**

源代码->编译器优化你的重排->指令并行也可能会重排->内存系统也会重排->执行

处理器在进行指令重排的时候，考虑数据之间的依赖性

```java
int x = 1; // 1
int y = 2; // 2
x = x + 1; // 3
y = x*x;   // 4
我们锁期望的 1234
可能是 2134 1324
```
可能造成的结果 abxy这四个值默认都是0

| 线程A | 线程B |
| ----- | ----- |
| x=a   | y=b   |
| b=1   | a=2   |



**Volatile可以避免指令重排：**

内存屏障。CPU指令，作用：

1、保证特定的操作的执行顺序！

2、可以保证某些变量的内存可见性（利用这些特性volatile实现了可见性）

[![oqZ7GV.png](https://s4.ax1x.com/2021/12/12/oqZ7GV.png)](https://imgtu.com/i/oqZ7GV)

Volatile是可以保证可见性，不能保证原子性，由于内存屏障，可以保证避免指令重排的现象产生！

内存屏障在单例模式用的最多

### 18、彻底玩转单例模式

饿汉式 DCL懒汉式

> 饿汉式

```java
public class Hungry {
    // 可能会浪费空间
    private byte[] data1 = new byte[1024*1024];
    private byte[] data2 = new byte[1024*1024];
    private byte[] data3 = new byte[1024*1024];

    private Hungry(){

    }

    private final static Hungry HUNGRY = new Hungry();

    public static Hungry getInstance(){
        return HUNGRY;
    }
}
```

> 懒汉式

```java
public class Lazy {

    private static  boolean qinjiang = false;

    private Lazy(){
        System.out.println(Thread.currentThread().getName()+ "ok");
        synchronized (Lazy.class){
            if (LAZY !=null){
                throw new RuntimeException("不要试图用反射破坏单例");
            }
        }
    }
    private volatile static Lazy LAZY;

    // 双重监测锁模式的 懒汉式单例 DCL懒汉式
    public static Lazy getInstance(){
        if (LAZY == null){
            synchronized (Lazy.class) {
                if (LAZY == null) {
                    LAZY = new Lazy(); // 不是一个原子性操作
                    /**
                     * 1. 分配内存空间
                     * 2. 执行构造方法，初始化对象
                     * 3. 把这个对象指向这个空间
                     * 123
                     * 132
                     * 必须加volatile避免指令重排
                     */
                }
            }
        }
        return LAZY;
    }

    // 多线程并发
    public static void main(String[] args) throws NoSuchMethodException, InvocationTargetException, InstantiationException, IllegalAccessException {
        for (int i = 0; i < 10; i++) {
            new Thread(() ->{
                Lazy.getInstance();
            }).start();
        }
        // 反射 破坏单例
        Lazy instance = Lazy.getInstance();
        Constructor<Lazy> declaredConstructor = Lazy.class.getDeclaredConstructor(null);
        declaredConstructor.setAccessible(true); // 可访问私有方法
        Lazy lazy = declaredConstructor.newInstance();
        System.out.println(instance);
        System.out.println(lazy);

    }
}
```

> 静态内部类

```java
public class Holder {
    // 单例模式一定是构造器私有

    private Holder(){

    }

    public static Holder getInstance(){return InnerClass.HOLDER;}

    public static class InnerClass{
        private static final Holder HOLDER = new Holder();
    }
}
```

> 单例不安全，反射

> 枚举，里面没有无参构造

```java

/**
 * enum 本身也是一个Class类
 *
 * @author tcs
 * @date Created in 2021-12-27
 */
public enum EnumSingle {

    INSTANCE;

    public EnumSingle getInstance(){
        return INSTANCE;
    }
}

class Test{
    public static void main(String[] args) {
        EnumSingle instance = EnumSingle.INSTANCE;
        EnumSingle instance2 = EnumSingle.INSTANCE;
        System.out.println(instance);
        System.out.println(instance2);
    }
}
```



### 19、深入理解CAS

> 什么式CAS



> unsafe类

![image-20211227202000663](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211227202000663.png)

![image-20211227202218451](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211227202218451.png)



CAS：比较当前工作内存中的值和主内存中的值，如果这个值是期望的，那么则执行操作！如果不是就一直循环！

**缺点：**

1、循环会耗时

2、一次性只能保证一个共享变量的原子性

3、ABA问题



> CAS：ABA问题（狸猫换太子）

![image-20211228190906070](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211228190906070.png)

```java
public class CASDemo {

    // CAS compareAndSet：比较并交换！
    public static void main(String[] args) {
        AtomicInteger atomicInteger = new AtomicInteger(2020);

        // 对于我们平时写的SQL：乐观锁
        // 期望、更新
        // public final boolean compareAndSet(int expect, int update)
        // 如果我期望的值达到了，那么就更新，否则，就不更新
        // ============捣乱的线程============
        System.out.println(atomicInteger.compareAndSet(2020, 2021));
        System.out.println(atomicInteger.get());

        System.out.println(atomicInteger.compareAndSet(2021, 2020));
        System.out.println(atomicInteger.get());

        // ==============期待的线程==============
        System.out.println(atomicInteger.compareAndSet(2020, 6666));
        System.out.println(atomicInteger.get());
    }
}
```



### 20、原子引用

> 解决ABA问题，引入原子引用

带版本号的原子操作！

**Integer 使用了对象缓存机制，默认范围是-128～127，推荐使用静态工厂方法valueof 获取对象实例，而不是 new，因为 valueof使用缓存，而 new 一定会创建新的对象分配新的内存空间；**



### 21、各种锁的理解

#### 1、公平锁、非公平锁

公平锁：非常公平，不能够插队

非公平锁：非常不公平，可以插队

```java
// 默认非公平锁
public ReentrantLock() {
        sync = new NonfairSync();
    }
// 改成公平锁
public ReentrantLock(boolean fair) {
        sync = fair ? new FairSync() : new NonfairSync();
    }

```



#### 2、可重入锁

可重入锁（递归锁）

![image-20211228194039542](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211228194039542.png)



#### 3、自旋锁

spinlock：不断重试直到成功

![image-20211228195450110](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20211228195450110.png)



#### 4、死锁

![image-20220106192154821](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220106192154821.png)

> 怎么排除死锁

1、使用jps -l定位进程号，查看当前进程号

![image-20220106193153725](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220106193153725.png)

2、使用 jstack “进程号” 找到死锁问题



问题排查

1、日志

2、堆栈信息