- [List 、Set、 Map有什么区别和联系](#list-set-map有什么区别和联系)
- [集合中接口和类的关系](#集合中接口和类的关系)
  - [Iterator：所有集合类都实现了Iterator接口](#iterator所有集合类都实现了iterator接口)
- [层次图](#层次图)
- [List](#list)
- [Set](#set)


### List 、Set、 Map有什么区别和联系

- list 和set 有共同的父类 它们的用法也是一样的 唯一的不太就是set中不能有相同的元素 list中可以，list是有序集合
- list和set的用途非常广泛 list可以完全代替数组来使用
- map是独立的集合，它使用键值对的方式来储存数据，键不能有重复的

### 集合中接口和类的关系
- Collection接口是集合类的根接口，Java中没有提供这个接口的直接实现类。但是却让它被继承，产生了两个接口，就是Set和List。
- Map是另一个接口，与Collection是相互独立的

#### Iterator：所有集合类都实现了Iterator接口
  1. 用于遍历集合元素，主要有三个方法
- hasNext()是否有下一个元素
- next()返回下一个元素
- remove()删除当前元素
### 层次图
![](https://img-blog.csdn.net/20170905084526091?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTGl2ZW9yX0RpZQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


### List
1、 最常用集合：ArrayList  </br>
 特点：ArrayList集合中元素存储的位置是连续的，所以查询起来会比较快捷，但是执行插入删除操作会比较麻烦一点，会引起其他元素位置的变化。
 注意：list中储存的是对象引用，而不是对象本身，如果对象变化，list中储存的也会变。
 ```Java
    User user = new User(1, "迪丽热巴", 18, new Date());
    List<User> userList = new ArrayList<User>();
    userList.add(user);
    System.out.println(userList); // [User(id=1, username=迪丽热巴, ...)]
    user.setUsername("德玛西亚");
    System.out.println(userList); // [User(id=1, username=德玛西亚, ...)]
```
2、与最常用集合相反的集合：LinkedList  </br>
LinkedList与ArrayList是互补的，所以ArrayList的优点就是LinkedList的缺点，ArrayList的缺点就是LinkedList的优点。 </br>
特点：LinkedList中元素位置是任意的，所以执行插入删除操作效率较高，查询效率较低。

LinkedList要头部插入才能体现它的效率
```Java
    LinkedList<Integer> linkedList = new LinkedList<>();
        long linkedStart = System.currentTimeMillis();
        for (int i = 0; i < 1000000; i++) {
            linkedList.addFirst(i);
        }
```
![](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/img20210525170510.png)
- 在尾部插入数据，数据量较小时LinkedList比较快，因为ArrayList要频繁扩容，当数据量大时ArrayList比较快，因为ArrayList扩容是当前容量*1.5，大容量扩容一次就能提供很多空间，当ArrayList不需扩容时效率明显比LinkedList高，因为直接数组元素赋值不需new Node
- 在首部插入数据，LinkedList较快，因为LinkedList遍历插入位置花费时间很小，而ArrayList需要将原数组所有元素进行一次System.arraycopy
- 插入位置越往后，ArrayList效率越高，因为数组需要复制后移的数据少了，那么System.arraycopy就快了，因此在首部插入数据LinkedList效率比ArrayList高，尾部插入数据ArrayList效率比LinkedList高

3、与一般集合都相反的集合：Vector </br>
特点：多个线程同时访问不会发生不确定的结果，但是它的效率会比较低，如果要考虑线程安全的话可以用它。

### Set
1、Set中最常用的集合：HashSet  </br>
HashSet是使用Hash表实现的，集合里面的元素是无序得，可以有null值，但是不能有重复元素。</br>
特点：因为相同的元素具有相同的hashCode，所以不能有重复元素

2、Set中第二常用的集合：TreeSet

TreeSet是用二叉树结构实现的集合

特点：集合中的元素是有顺序得，不允许放入null，同样不能放入重复元素。

