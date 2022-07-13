### 左侧分类树接口

---

**接口说明**

> 左侧分类树接口

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/speciesmaintenance/tree

**请求方法**
> GET

**数据提交方式**

> application/json

| 参数名称 | 数据类型 | 属性描述                       | 是否必填 | 备注 |
| -------- | -------- | ------------------------------ | -------- | ---- |
| type     | int      | 1-动物园 2-繁育场 默认为动物园 | false    |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | list     | true     | 数据结果集                                                   |

**data参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                 |
| :------- | :------- | :------- | :----------------------- |
| label    | String   | true     | 一级名称                 |
| children | list     | true     | 二级列表，非猛兽类为物种 |

**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": [
        {
            "label": "猛兽类",
            "children": [
                "狮",
                "虎"
            ]
        },
        {
            "label": "非猛兽类",
            "children": [
                "鹦鹉",
                "小熊猫"
            ]
        }
    ],
    "msg": "操作成功"
}
```



### 左侧分类树接口-三级

----

**接口说明**

> 左侧分类树接口-三级

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/speciesmaintenance/tree-detail

**请求方法**

> GET

**数据提交方式**

> application/json

| 参数名称    | 数据类型 | 属性描述 | 是否必填 | 备注 |
| ----------- | -------- | -------- | -------- | ---- |
| speciesName | string   | 物种名称 | true     |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | list     | true     | 数据结果集，物种列表                                         |

**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": [
        "东北虎",
        "华南虎"
    ],
    "msg": "操作成功"
}
```



### 一张图-动物园一级页面数据

----

**接口说明**

> 一张图-动物园一级页面数据

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/breedplace/map-zoo

**请求方法**

> GET

**数据提交方式**

> application/json

| 参数名称    | 数据类型 | 属性描述               | 是否必填 | 备注 |
| ----------- | -------- | ---------------------- | -------- | ---- |
| speciesName | string   | 物种名称，多个用，隔开 | false    |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | object   | true     | 数据结果集                                                   |

**data参数**

| 参数名称      | 数据类型 | 是否必须 | 参数描述       |
| :------------ | :------- | :------- | :------------- |
| zooNumber     | int      | true     | 动物园数量     |
| speciesNumber | int      | true     | 存栏总数       |
| placeInfo     | list     | false    | 动物园信息     |
| stockPer      | list     | false    | 各市存栏量占比 |

**placeInfo参数**

| 参数名称      | 数据类型 | 是否必须 | 参数描述           |
| :------------ | :------- | :------- | :----------------- |
| placeId       | long     | true     | 动物园id           |
| placeName     | string   | true     | 动物园名称         |
| cityCode      | string   | true     | 动物园所属城市编码 |
| speciesNumber | int      | true     | 物种数量           |
| stockNumber   | int      | true     | 存栏量             |
| icon          | string   | false    | 动物图标           |

**stockPer参数**

| 参数名称        | 数据类型 | 是否必须 | 参数描述 |
| :-------------- | :------- | :------- | :------- |
| cityName        | String   | true     | 城市名称 |
| stockPercentage | double   | true     | 占比     |
| stock           | int      | true     | 存栏数量 |

**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": {
        "zooNumber": 11,
        "speciesNumber": 805,
        "placeInfo": [
            {
                "placeName": "杭州野生动物世界",
                "speciesNumber": 2,
                "stockNumber": 20,
                "icon": ""
            }
        ],
        "stockPer": [
            {
                "cityName": "杭州市",
                "stockPercentage": 100.0
            }
        ]
    },
    "msg": "操作成功"
}
```

### 一张图-繁育场一级页面数据

----

**接口说明**

> 一张图-繁育场一级页面数据

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/breedplace/map-breedplace

**请求方法**

> GET

**数据提交方式**

> application/json

| 参数名称    | 数据类型 | 属性描述               | 是否必填 | 备注 |
| ----------- | -------- | ---------------------- | -------- | ---- |
| speciesName | string   | 物种名称，多个用，隔开 | false    |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | object   | true     | 数据结果集                                                   |

**data参数**

| 参数名称         | 数据类型 | 是否必须 | 参数描述       |
| :--------------- | :------- | :------- | :------------- |
| breedPlaceNumber | int      | true     | 繁育场数量     |
| placeInfo        | list     | false    | 繁育场信息     |
| stockPer         | list     | false    | 各市存栏量占比 |

**placeInfo参数**

| 参数名称             | 数据类型 | 是否必须 | 参数描述   |
| :------------------- | :------- | :------- | :--------- |
| cityName             | string   | true     | 城市名称   |
| breedPlaceNumber     | int      | true     | 繁育场数量 |
| breedPlacePercentage | double   | true     | 繁育场占比 |

**stockPer参数**

| 参数名称        | 数据类型 | 是否必须 | 参数描述   |
| :-------------- | :------- | :------- | :--------- |
| cityName        | String   | true     | 城市名称   |
| stockPercentage | double   | ture     | 存栏量占比 |

**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": {
        "breedPlaceNumber": 11,
        "placeInfo": [
            {
                "cityName": "杭州市",
                "speciesNumber": 2,
                "stockNumber": 20.0
            }
        ],
        "stockPer": [
            {
                "cityName": "杭州市",
                "stockPercentage": 100.0
            }
        ]
    },
    "msg": "操作成功"
}
```



### 三级页面-标记代码列表

----

**接口说明**

> 标记代码列表

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/animalinfo/list-code

**请求方法**

> GET

**数据提交方式**

> application/json

| 参数名称    | 数据类型 | 属性描述        | 是否必填 | 备注 |
| ----------- | -------- | --------------- | -------- | ---- |
| placeId     | long     | 繁育场/动物园id | true     |      |
| speciesName | string   | 动物名称        | true     |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | list     | true     | 标记代码列表                                                 |



**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": [
        "61698201602",
        "5718672386"
    ],
    "msg": "操作成功"
}
```



### 三级页面-物种基本信息

----

**接口说明**

> 物种基本信息

**接口版本**

> v1

**接口地址**

> /api/shengting-aco/animalinfo/detail

**请求方法**

> GET

**数据提交方式**

> application/json

| 参数名称    | 数据类型 | 属性描述        | 是否必填 | 备注 |
| ----------- | -------- | --------------- | -------- | ---- |
| placeId     | long     | 繁育场/动物园id | true     |      |
| speciesName | string   | 动物名称        | true     |      |
| tabCode     | string   | 标记代码        | true     |      |



**返回参数**

| 参数名称 | 数据类型 | 是否必须 | 参数描述                                                     |
| :------- | :------- | :------- | :----------------------------------------------------------- |
| code     | string   | true     | 返回码 0表示接收成功，其他表示失败                           |
| msg      | string   | true     | 返回描述-记录接口执行情况说明信息 success表示成功描述，其他表示失败 |
| data     | object   | true     | 标记代码列表                                                 |

**Data属性说明：**

| 参数名称            | 数据类型 | 是否必须 | 参数描述         |
| :------------------ | :------- | :------- | :--------------- |
| nameCh              | String   | true     | 中文名           |
| nameSci             | String   | true     | 学名             |
| nameEn              | String   | true     | 英文名           |
| sex                 | String   | true     | 性别             |
| tabBody             | String   | true     | 标记物           |
| tabCode             | String   | true     | 标记代码         |
| tabPlace            | String   | true     | 标记位置         |
| tabTime             | String   | true     | 标记时间         |
| insideCode          | String   | true     | 内管代码         |
| houseCode           | String   | true     | 栏舍号           |
| birthPlace          | String   | true     | 出生单位         |
| birthDay            | Date     | true     | 出生时间         |
| sourcePlace         | String   | true     | 来源单位         |
| sourceTime          | Date     | true     | 来源时间         |
| sourcePrope         | String   | true     | 来源性质         |
| sourceProve         | String   | true     | 来源证明         |
| motherCode          | String   | true     | 母标记码         |
| fatherCode          | String   | true     | 父标记码         |
| pedCode             | String   | true     | 谱 系 号         |
| pedProperty         | String   | true     | 谱系体系         |
| info                | String   | true     | 个体描述         |
| remark              | String   | true     | 备注             |
| guide               | String   | true     | 现场指导         |
| marker              | String   | true     | 标 记 员         |
| recorder            | String   | true     | 记录员           |
| regulater           | String   | true     | 监督员           |
| confirmBelongUnit   | String   | true     | 所属单位         |
| confirmRegulateUnit | String   | true     | 监督单位         |
| unitConfirmTime     | Date     | true     | 所属单位签章日期 |
| svConfirmTime       | Date     | true     | 监督单位签章日期 |

**返回参数举例**

```json
{
    "code": 200,
    "success": true,
    "data": {}
        "nameCh": "东北虎"，
       
        },
    "msg": "操作成功"
}
```



### 一张图新增sql

```sql
-- 新增繁育场类型
ALTER TABLE `shengting_aco`.`aco_breed_place` 
ADD COLUMN `place_type` tinyint(2) NULL COMMENT '1-为动物园 2-为繁育场' AFTER `district_code`;
```

