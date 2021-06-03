[TOC]

### 什么是Stream
   &emsp;&emsp; stream是对集合(Collection)对象功能的增强，它提供串行和并行两种模式进行汇聚操作，并发模式能够充分利用多核处理器的优势，使用 fork/join 并行方式来拆分任务和加速处理过程。

   &emsp;&emsp; 原始版本的 Iterator，用户只能显式地一个一个遍历元素并对其执行某些操作；高级版本的 Stream，用户只要给出需要对其包含的元素执行什么操作，比如 “过滤掉长度大于 10 的字符串”、“获取每个字符串的首字母”等，Stream 会隐式地在内部进行遍历，做出相应的数据转换。

### 流的构成
获取一个流，通常有三个步骤：

&emsp;&emsp;获取一个数据源（source）→ 数据转换→执行操作获取想要的结果，每次转换原有 Stream 对象不改变，返回一个新的 Stream 对象（可以有多次转换），这就允许对其操作可以像链条一样排列，变成一个管道

有多种方式生成 Stream Source：

- 从 Collection 和数组
   - Collection.stream()
   - Collection.parallelStream()
   - Arrays.stream(T array) or Stream.of()
- 从BufferedReader
   - java.io.BufferedReader.lines()
- 静态工厂
   - java.util.stream.IntStream.range()
   - java.nio.file.Files.walk()

### 流的操作类型分为两种：
- Intermediate: 一个流可以后面跟随零个或多个 intermediate 操作。其目的主要是打开流，做出某种程度的数据映射/过滤，然后返回一个新的流，交给下一个操作使用。


- Terminal: 一个流只能有一个 terminal 操作，当这个操作执行后，流就被使用“光”了，无法再被操作。所以这必定是流的最后一个操作。Terminal 操作的执行，才会真正开始流的遍历，并且会生成一个结果，或者一个 side effect。

### 流的构造与转换


#### 构造流的几种常见方法
  ```Java
    // 1. Individual values

    Stream stream = Stream.of("a", "b", "c");

    // 2. Arrays

    String [] strArray = new String[] {"a", "b", "c"};

    stream = Stream.of(strArray);

    stream = Arrays.stream(strArray);

    // 3. Collections

    List<String> list = Arrays.asList(strArray);

    stream = list.stream();
  ```

#### 流转换为其它数据结构
一个 Stream 只可以使用一次，下面面的代码为了简洁而重复使用了数次。
  ```Java
    // 1. Array
    String[] strArray1 = stream.toArray(String[]::new);

    // 2. Collection
    List<String> list1 = stream.collect(Collectors.toList());

    List<String> list2 = stream.collect(Collectors.toCollection(ArrayList::new));

    Set set1 = stream.collect(Collectors.toSet());

    Stack stack1 = stream.collect(Collectors.toCollection(Stack::new));

    // 3. String
    String str = stream.collect(Collectors.joining()).toString();
  ```

### 流的操作
- Intermediate：
  map (mapToInt, flatMap 等)、 filter、 distinct、 sorted、 peek、 limit、 skip、 parallel、 sequential、 unordered
  
  ```Java
    // map/flatMap 
    // Stream中map元素类型转化方法
    List<User> collect = userList.stream().map(user -> fixUser(user)).collect(Collectors.toList());

    // filter 对原始 Stream 进行某项测试，通过测试的元素被留下来生成一个新 Stream。
    // 过滤掉不满足条件的对象
    userList.stream().filter(user -> user.getAge()<20).forEach(user -> System.out.println("filter" + user));

    //peek 对每个元素执行操作并返回一个新的 Stream
    userList.stream().peek(System.out::println)

    //findFirst 这是一个 terminal 兼 short-circuiting 操作，它总是返回 Stream 的第一个元素，或者空。
    Optional<User> first = userList.stream().findFirst();
    User user = first.get();

    // limit 返回 Stream 的前面 n 个元素；skip 则是扔掉前 n 个元素
    userList.stream().limit(1).forEach(user -> System.out.println("limit: " + user));
    userList.stream().skip(2).forEach(user -> System.out.println("skip: " + user));

    //sort 排序 根据某个值排序取前几个
    userList.stream().sorted(Comparator.comparing(User::getAge)).limit(2).forEach(user -> System.out.println("sorted: " + user));

    // min/max/distinct  min 和 max 的功能也可以通过对 Stream 元素先排序，再 findFirst 来实现，但前者的<性能会更好，为 O(n)，而 sorted 的成本是 O(n log n)。同时它们作为特殊的 reduce 方法被独立出来也是因为求最大最小值是很常见的操作。
    BufferedReader bufferedReader = new BufferedReader(new FileReader("E:\\文档\\笔记\\node的安装及使用.md"));
    int asInt = bufferedReader.lines().mapToInt(String::length).max().getAsInt();
    // 找出全文的单词，转大写，并排序
        List<String> strings = br.lines().flatMap(line -> Stream.of(line.split(" ")))
                .filter(word -> word.length() > 0).map(String::toUpperCase).distinct().sorted()
                .collect(Collectors.toList());
  ```

- Terminal：
  forEach、 forEachOrdered、 toArray、 reduce、 collect、 min、 max、 count、 anyMatch、 allMatch、 noneMatch、 findFirst、 findAny、 iterator

  ```Java
    //forEach  forEach 方法接收一个 Lambda 表达式，然后在 Stream 的每一个元素上执行该表达式。
    userList.stream().filter(user -> user.getAge()>18).forEach(System.out::println);

  ```

- Short-circuiting：
   anyMatch、 allMatch、 noneMatch、 findFirst、 findAny、 limit

    Stream 有三个 match 方法，从语义上说：
    - allMatch：Stream 中全部元素符合传入的 predicate，返回 true
    - anyMatch：Stream 中只要有一个元素符合传入的 predicate，返回 true
    - noneMatch：Stream 中没有一个元素符合传入的 predicate，返回 true
  ```Java
    // 是否有所有人都大于18岁
    boolean b = userList.stream().allMatch(uesr -> uesr.getAge() > 18);

  ```
