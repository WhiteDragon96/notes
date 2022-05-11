## I/O

### File

```java
String filePath = "e:\\test01.txt";
File file = new File(filePath);
try {
    // 这里file对象，再java程序中，只是一个对象
    // 只有执行了 createNewFile，才会在池畔中创建中构建
    boolean newFile = file.createNewFile();
} catch (IOException e) {
    e.printStackTrace();
}
    
```



### 字节流、字符流

字符流更快，二进制文件用字节流操作更好

![image-20220316223617847](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220316223617847.png)

它们都是抽象类，Java的IO流都是上面派生出来的 

![image-20220316224830980](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/imgimage-20220316224830980.png)

流就像外卖小哥

![image-20220318214423049](C:\Users\neu\AppData\Roaming\Typora\typora-user-images\image-20220318214423049.png)



#### 标准输入流、输出流

![image-20220322210632254](C:\Users\neu\AppData\Roaming\Typora\typora-user-images\image-20220322210632254.png)

```java
		// System.in 编译类型 InputStream
        // System.in 运行类型 BufferedInputStream
        // 标准输入：键盘
        System.out.println(System.in.getClass()); //class java.io.BufferedInputStream
 
        // 输出类型 PrintStream
        // 标准输出：显示器
        System.out.println(System.out.getClass()); //class java.io.PrintStream
```

#### 转换流

> 字节流 -> 字符流