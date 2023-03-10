# ByteChat_RPC

由于git push总上传大文件失败，所以生成的可执行文件没有上传成功，需要大家自己对 CMakeLists.txt rebuild

作者：gzf66666

邮箱：gzf66666@foxmail.com

开发环境：Ubuntu VS Code

编译器：g++

编译工具：CMake

数据库：MySQL Redis

注册中心：ZooKeeper

序列化格式：Protobuf

编程语言：C++

# 写在前面

针对春招各个大厂的面试官对我春招项目：[基于muduo网络库的集群聊天系统](https://github.com/gzf66666/ByteChat) 提出的问题以及建议，对原来的集群项目进行了以下改进：

* 由简单nginx集群改为分布式集群
* 序列化格式由 json 改为protobuf
* 引入自己写的RPC框架
* 引入配置注册中心 zookeeper
* 引入数据库连接池
* 增加新业务

整个项目从构思到架构设计再到服务端研发总共花费了一个月左右的时间，希望可以在春招大放异彩！！！

# ByteChat_RPC架构设计图

![image-20230218204707852](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218204707852.png)


图可能有点模糊，接下来我会把每个图放大讲解。

# ByteChat_RPC架构 —— nginx反向代理负载均衡

整个系统在客户端和实际服务的服务器中添加了一个**反向代理服务器** —— nginx，同时利用nginx的负载均衡来达到**降低网络和服务器的负载**的目的。但是，这个也有缺陷，在本文的末尾会讲到。

这里是摘自[百度百科反向代理](https://baike.baidu.com/item/%E5%8F%8D%E5%90%91%E4%BB%A3%E7%90%86)的图，这里的反向代理服务器就是我们的nginx，后面的原始服务器就是我们实际提供服务的服务器群，也就是整个架构图大圆圈圈起来的地方。
![img](https://bkimg.cdn.bcebos.com/pic/3812b31bb051f81993dddee7d4b44aed2f73e7a7?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U4MA==,g_7,xp_5,yp_5)

## nginx 反向代理的配置

这里就来看一下，针对ByteTalk，我们应该怎样去配置？
![image-20230218204857229](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218204857229.png)
这里我们配置了两个服务器群的入口地址:`172.17.0.2:6051` 和`172.17.0.2:7051`，nginx监听的则是`172.17.0.2:8000`端口。当客户端发消息过来，代理服务器来接受客户端的网络访问连接请求，然后服务器将请求有策略的转发给网络中实际工作的业务服务器，并将从业务服务器处理的结果，返回给网络上发起连接请求的客户端。但是这对代理服务器的网络I/O是一个巨大的考验，这个我们需要考虑。

# ByteChat_RPC架构 —— 服务器群（服务单元）

这里的服务器群指的是整个架构图中大圆圈的部分：
![image-20230218205015356](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218205015356.png)


根据张云鹏老师在《架构师修炼之道——思维、方法、实践》一书中第29页介绍的**set模型**。

> **set 模型**：
> 整个ByteTalk整体设计抽象为由多台服务器组合而成的一台超级性能的服务器，这些服务器形成一个小集合，部署一整套对外的服务。set模型弥补了单机能力的不足，对业务组合搭配成一个单元。本质上是对服务的一个高内聚的封装。

代理服务器Nginx收到的消息就会像这么一个个服务单元去分派，服务单元执行完，Nginx再将结果返回给客户端，这个过程对客户端来说，基本就是透明的，好像就是客户端和服务器是直连的一样。

另外，就像神经信号在神经纤维中传递一样，每个服务单元中的服务节点就是神经元，而RPC就是服务单元内的脉络，是神经纤维。这个过程必须十分频繁，且需求快速。所以，整个服务器最好是部署在一个局域网内，减少网络中信息传递所带来的耗时。

## ByteChat_RPC 服务单元 —— 抽象服务节点：ProxyService

![image-20230218211124137](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218211124137.png)


ProxyService 作为整个服务单元的入口，**整个服务单元对外暴露的也是它的 Host 信息**，对于客户端的请求信息，它会首先去判断这个信息是哪个业务，如果是以下业务，它就会去Zookeeper注册中心，找到提供这个服务的服务节点，并把这个请求信息分配给它。

**登录、注册节点：**

* 登录
* 注册
* 注销（下线）

**群组节点：**

* 加入群
* 退出群
* 创建群
* 获得群用户信息

**用户、好友节点：**

* 得到用户信息
* 加好友
* 删除好友
* 得到好友列表

**离线消息节点：**

* 读取离线消息

另外对于 一对一聊天 及 群聊两个业务的设计如下：

首先，ProxyService和其下属的ChatServer 构成主从模式：

![image-20230218211422390](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218211422390.png)
对于一个聊天消息我们要做的唯一的工作肯定就是要**转发**了。如果这个聊天信息的接受者和发送者都在同一个服务器登录，那么很简单，直接就可以获取接受者的Host信息，然后直接发送就可以了。

对于接受者和发送者不在同一服务节点的情况下，我们就需要去zookeeper注册中心，去获得我们的一个从节点：**chatserver x**，然后将这条消息交给它去处理就好。

## ByteChat_RPC 抽象服务节点 —— 聊天处理服务器：ChatServer

![image-20230218211713692](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218211713692.png)
对于一个聊天信息，ChatServer 会先去 Redis 服务器上查询这个用户是否在线；如果在线，取得它的 Host 信息（也就是用户所在的服务单元)，然后去已建立的连接map 中看是否建立过，如果没有建立，那么就建立，然后将这个连接放入map。接下来将这条信息转发过去；如果不在线，就将这个消息存储到 mysql 的OfflineMsg表中，供客户端下次上线时读取。

> 注：
> Redis 服务器主要存储了用户的Host信息如下： id号 ip：host 
> 例：10086 "127.0.0.1:3001"

## ByteChat_RPC 业务服务单元 —— 以登录、注册节点：UserService为例

对于登录功能来说，ProxyService节点会先去 mysql 表中查询，是否和数据库中的数据匹配；如果不匹配，就给客户端返回错误信息。如果正确，就由ProxyService将 此用户的 Host 信息写入Redis服务器中。

![image-20230218211838946](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218211838946.png)

对于UserService服务节点来说，采用的也是主从架构，收到这么一个消息，就会去zookeeper注册中心中获取一个可用的服务节点**UserServer x**，然后将这个消息派发给它，让它去执行。

**UserServer x**会和持久层的 mysql 进行交互，具体的读取这个用户信息。

其他的业务服务单元，也就是下图这些，都是和UserService才有相同的设计。
![image-20230218212109545](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20230218212109545.png)

具体可以看一下源码，有异议的地方可以发博主邮箱讨论。

# ByteChat_RPC架构缺陷

1. 由于博主技术栈原因（就是菜），对于数据库，包括mysql Redis部分，其并没有考虑高并发和高可用，也没有进行分库分表等设计。
2. 对于Nginx来说，这里的设计不是很好，其会承担很高的网络I/O压力。其实更应该去自己实现以下一个服务单元的注册中心，里面存储了服务单元的Host信息及负载压力等信息，然后客户端去主动拉取服务单元的信息，用哈希或者最小负载等信息去自己连接一个服务单元
3. 对于某个Service去选择具体的服务节点Server，这里博主采用的是最简单的轮询方法。但是我的Server都是动态上限的，如果Server 1上线工作了很久，处理的请求达到了3w，这个时候Server 2上线了，那么我的Service去分派请求的时候，就应该去侧重Server 2，而不是这个时候还要轮询。这个选择应该是最小负载，而不是轮询
4. 系统的容灾设计考虑还是不够全面，对于Server掉线，这方面可以用集群保证。但是对于Service节点掉线，其意味着整个具体业务服务不可用。另外，对于ProxyServiec掉线，将会导致整个服务单元不可用

