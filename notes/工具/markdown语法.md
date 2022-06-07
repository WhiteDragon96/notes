[toc]




# 一级标题

（# 标题）

**加粗**

（** 字体 **）

*斜体*

（* 字体 *）

***斜体加粗***

（*** 字体  ***）

~删除线~

（~~字体~~）

> 引用内容

(>字体)

分割线

---

（---或***)

### 图片

![start](https://s1.ax1x.com/2020/06/24/Nd36gK.png "start1")

[超链接](www.baidu.com "百度")

[超链接](链接 “title 可写可不写”)

[blog](www.codedragon.top)

html语言的a标签   <a href="链接地址" >超链接</a>

### 无序列表

* 无序列表
* 无序列表
  - 或 + 或 *

### 有序列表

1. 有序列表
2. 有序列表
3.

### 表格

<figure class="md-table-fig" cid="n40" mdtype="table"><table class="md-table"><thead><tr class="md-end-block" cid="n41" mdtype="table_row"><th><span class="td-span" cid="n42" mdtype="table_cell"><span md-inline="plain" class="md-plain">表头</span></span></th><th><span class="td-span" cid="n43" mdtype="table_cell"><span md-inline="plain" class="md-plain">表头</span></span></th><th><span class="td-span" cid="n44" mdtype="table_cell"><span md-inline="plain" class="md-plain">表头</span></span></th><th><span class="td-span" cid="n45" mdtype="table_cell"></span></th></tr></thead><tbody><tr class="md-end-block" cid="n46" mdtype="table_row"><td><span class="td-span" cid="n47" mdtype="table_cell"><span md-inline="plain" class="md-plain">内容</span></span></td><td><span class="td-span" cid="n48" mdtype="table_cell"><span md-inline="plain" class="md-plain">内容</span></span></td><td><span class="td-span" cid="n49" mdtype="table_cell"><span md-inline="plain" class="md-plain">内容</span></span></td><td><span class="td-span" cid="n50" mdtype="table_cell"></span></td></tr></tbody></table></figure>

### 代码

`代码内容`

```<


public static String doGet(String url, String requestJson) throws IOException {
        HttpClient httpClient = HttpClients.createDefault();
        RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(5000).setConnectTimeout(5000).build();
        HttpGet get = new HttpGet(url);
        get.setConfig(requestConfig);
        StringEntity myEntity = new StringEntity(requestJson, ContentType.APPLICATION_JSON);
        get.setHeader("accept", "*/*");
        get.setHeader("connection", "Keep-Alive");
        get.setHeader("accept", "*/*");
        get.setHeader("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
        String result;
        HttpResponse execute = httpClient.execute(get);
        result = EntityUtils.toString(execute.getEntity(), Consts.UTF_8);

        return result;
    }
```
 `[toc]` 写在文章开头，自动生成目录