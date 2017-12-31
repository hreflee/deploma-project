# 技术调研

## 数据层选型

| 方案             | 优点                                | 缺点/风险                                         |
| ---------------- | ------------------------------------ | ------------------------------------------------- |
| RPC(gRPC/thrift) | 复用原有Java代码                     | 同学中实践经验少                                  |
|                  | 在node层解序列化                     | 需要部署Java的RPC实现 - 非常陌生,耗时长           |
|                  | 接触RPC                              | 熟悉node层RPC需要时间                             |
|                  |                                      | 在服务器上同时部署node和Tomcat/分开两个服务器部署 |
| HTTP调用         | node层调用方便                       | 调用时间更长                                      |
|                  | 同学中已经有人实践过Java层JSON序列化 | Java层部署序列化JSON需要时间                      |
|                  |                                      | 在服务器上同时部署node和Tomcat/分开两个服务器部署 |
| node层实现       | 服务端全部掌控                       | 需要重写所有db处理逻辑                            |
|                  | 不需要同时部署node和Tomcat           |                                                   |


**无论选用任何方案,websocket服务器db处理逻辑必须重写*

<br> 

## 中间层组件选择

- websocket组件

    [koa-websocket](https://www.npmjs.com/package/koa-websocket)

- PWA自动化工具

    ?

