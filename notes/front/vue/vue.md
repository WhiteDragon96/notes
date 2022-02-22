





### VUE七大组件

> 组件是一个自定义标签

注册组件

```html
<script>
    // 定义一个Vue组件component
    Vue.component("qinjiang",{
        props: ['qin'],
        template: '<li>{{qin}}</li>'
    })
    var vm = new Vue({
        el: "#app" ,
        data: {
            items: ["java","Linux","前端"]
        }
    });
</script>
```



### 网络通信

