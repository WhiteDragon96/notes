[toc]


### 变量

我们可以使用 var、let 或 const 声明变量来存储数据。
* let — 现代的变量声明方式。
* var — 老旧的变量声明方式。一般情况下，我们不会再使用它。
* const — 类似于 let，但是变量的值无法被修改。

### 数据类型

JavaScript 中有 8 种基本的数据类型（注：7 种原始类型和 1 种引用类型）。
* Number类型，代表整数和浮点数。
* BigInt 类型，number” 类型无法表示大于 (253-1)，或小于 -(253-1) 的整数
* String类型、Boolean类型
* object 类型和 symbol 类型，object 则用于储存数据集合和更复杂的实体。
* typeof 运算符，typeof 运算符返回参数的类型 
  ```
  typeof 0 // "number"
  typeof 10n // "bigint"  

  ```
### 严格模式
为了完全启用现代 JavaScript 的所有特性，我们应该在脚本顶部写上 "use strict" 指令。
  ```
    'use strict';
    ...
  ```
### 交互：alert、prompt 和 confirm
* alert  弹出的这个带有信息的小窗口被称为 模态窗。“modal” 意味着用户不能与页面的其他部分（例如点击其他按钮等）进行交互，直到他们处理完窗口。在上面示例这种情况下 —— 直到用户点击“确定”按钮。
* prompt，title： 显示给用户的文本，default：可选的第二个参数，指定 input 框的初始值。
  ```
  let age = prompt('How old are you?', 100);
  alert(`You are ${age} years old!`); // You are 100 years old!
  ```
* confirm， 函数显示一个带有 question 以及确定和取消两个按钮的模态窗口。点击确定返回 true，点击取消返回 false。
  ```
    let isBoss = confirm("Are you the boss?");
    alert( isBoss ); // 如果“确定”按钮被按下，则显示 true
  ```
  ### 基础运算符，数学
  支持以下数学运算：
* 加法 +,
* 减法 -,
* 乘法 *,
* 除法 /,
* 取余 %,
* 求幂 **.
  ```
  alert( 2 ** 2 ); // 4  (2 * 2，自乘 2 次)
  alert( 4 ** (1/2) ); // 2（1/2 次方与平方根相同)
  ```
  ### 值的比较
  * `>`  < == !=
  ```
    == 存在一个问题，它不能区分出 0 和 false
    alert( 0 == false ); // true
    alert( '' == false ); // true
  ```
  这是因为在比较不同类型的值时，处于相等判断符号 == 两侧的值会先被转化为数字。空字符串和 false 也是如此，转化后它们都为数字 0。
  * 严格相等运算符 === 在进行比较时不会做任何的类型转换。
  ```
        alert( 0 === false ); // false，因为被比较值的数据类型不同
  ```

### 条件分支：if 和 '?'
  *  if(...) 语句计算括号里的条件表达式，如果计算结果是 true，就会执行对应的代码块。
  ```
    if ("0") { // 只要字符串不为空，都是true
     alert( 'Hello' );
    }   
  ```
  *  条件运算符 ‘?’,三元运算符
    
  ```
    let result = condition ? value1 : value2;
  ```
### 逻辑运算符
JavaScript 中有三个逻辑运算符：||（或），&&（与），!（非）。

### 函数
  ```
    我们的新函数可以通过名称调用：showMessage()。
    function showMessage() {
     alert( 'Hello everyone!' );
    }

    showMessage();
    showMessage();
  ```
  * 作为参数传递给函数的值，会被复制到函数的局部变量。
  * 函数可以访问外部变量。但它只能从内到外起作用。函数外部的代码看不到函数内的局部变量。
  * 函数可以返回值。如果没有返回值，则其返回的结果是 undefined。
#### 回调函数 
我们写一个包含三个参数的函数 ask(question, yes, no)：

question
关于问题的文本


yes
当回答为 “Yes” 时，要运行的脚本


no
当回答为 “No” 时，要运行的脚本


函数需要提出 question（问题），并根据用户的回答，调用 yes() 或 no()：
  ```
    function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

function showOk() {
  alert( "You agreed." );
}

function showCancel() {
  alert( "You canceled the execution." );
}

// 用法：函数 showOk 和 showCancel 被作为参数传入到 ask
ask("Do you agree?", showOk, showCancel);
  ```
  #### 匿名函数
  这里直接在 ask(...) 调用内进行函数声明。这两个函数没有名字
  ```
    ask(
  "Do you agree?",
  function() { alert("You agreed."); },
  function() { alert("You canceled the execution."); }
);
  ```
* 函数声明：在主代码流中声明为单独的语句的函数。
  ```
    // 函数声明
    function sum(a, b) {
    return a + b;
    }
  ```
* 函数表达式：在一个表达式中或另一个语法结构中创建的函数。下面这个函数是在赋值表达式 = 右侧创建的
  ```
        // 函数表达式
    let sum = function(a, b) {
    return a + b;
    };
  ```

### 箭头函数
  ```
    let sum = (a, b) => a + b;

    /* 这个箭头函数是下面这个函数的更短的版本：

    let sum = function(a, b) {
    return a + b;
    }; */

    // 当只有一个参数时 可以去了括号
    let alone = a => console.log(a)
    alone(666);
    // 没有参数时要保留括号
    let empty = () => console.log("empty paramter")
    empty();
  ```

### JavaScript 特性
