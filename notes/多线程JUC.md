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