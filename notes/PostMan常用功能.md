常用设置环境变量，获取token：
    ![](https://raw.githubusercontent.com/WhiteDragon96/ImgCloud/main/data/img20210913144917.png)
    编写脚本
```JavaScript
    const echoPostRequest = {
    //请求地址
    url:"http://localhost/blade-auth/oauth/token",
    method:"post",
    header:[
         "Content-Type:application/x-www-form-urlencoded",
         "Authorization:Basic c2FiZXI6c2FiZXJfc2VjcmV0",
         "Tenant-Id:000000",
        ],
    body:{
        //raw为json格式，urlencoded为url表单模式
        mode:"urlencoded",
        //请求参数
        urlencoded: 'grant_type=password&scope=all&tenantId=00000&username=neusense&password=0fc4fc2685517c7c3c6a8581c1c77344',
    },
};
pm.sendRequest(echoPostRequest,function(err,res){
    //这里可以获取res中的各种属性，并可以封装成变量供Body、Headers使用
    res = JSON.parse(res.text())
    console.log(res.access_token)
    var token = res.access_token
    //添加请求头token
    pm.request.headers.add({
        key: 'Blade-Auth',
        value: token
    })
});
```
官方api文档(https://learning.postman.com/docs/writing-scripts/script-references/postman-sandbox-api-reference/)