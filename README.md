# consul-config

## windows
in `Cmder`:
> export COMPOSE_CONVERT_WINDOWS_PATHS=1

start services:
> docker-compose up -d

check status in web:
> http://localhost:8500

or cli:
> docker exec -t consul1 consul members

## API 介绍
```
kv - Key/Value存储
agent - Agent控制
catalog - 管理nodes和services
health - 管理健康监测
session - Session操作
acl - ACL创建和管理event - 用户Events
status - Consul系统状态
```

1. agent endpoints：agent endpoints用来和本地agent进行交互，一般用来服务注册和检查注册，支持以下接口
```
/v1/agent/checks : 返回本地agent注册的所有检查(包括配置文件和HTTP接口)
/v1/agent/services : 返回本地agent注册的所有 服务
/v1/agent/members : 返回agent在集群的gossip pool中看到的成员
/v1/agent/self : 返回本地agent的配置和成员信息/v1/agent/join/<address> : 触发本地agent加入node/v1/agent/force-leave/<node>>: 强制删除node
/v1/agent/check/register : 在本地agent增加一个检查项，使用PUT方法传输一个json格式的数据/v1/agent/check/deregister/<checkID> : 注销一个本地agent的检查项/v1/agent/check/pass/<checkID> : 设置一个本地检查项的状态为passing/v1/agent/check/warn/<checkID> : 设置一个本地检查项的状态为warning/v1/agent/check/fail/<checkID> : 设置一个本地检查项的状态为critical
/v1/agent/service/register : 在本地agent增加一个新的服务项，使用PUT方法传输一个json格式的数据/v1/agent/service/deregister/<serviceID> : 注销一个本地agent的服务项
```

2. catalog endpoints：catalog endpoints用来注册/注销nodes、services、checks
```
/v1/catalog/register : Registers a new node, service, or check/v1/catalog/deregister : Deregisters a node, service, or check/v1/catalog/datacenters : Lists known datacenters
/v1/catalog/nodes : Lists nodes in a given DC
/v1/catalog/services : Lists services in a given DC
/v1/catalog/service/<service> : Lists the nodes in a given service
/v1/catalog/node/<node> : Lists the services provided by a node
```

3. health endpoints：health endpoints用来查询健康状况相关信息，该功能从catalog中单独分离出来
```
/v1/healt/node/<node>: 返回node所定义的检查，可用参数?dc=
/v1/health/checks/<service>: 返回和服务相关联的检查，可用参数?dc=
/v1/health/service/<service>: 返回给定datacenter中给定node中service
/v1/health/state/<state>: 返回给定datacenter中指定状态的服务，state可以是"any", "unknown", "passing", "warning", or "critical"，可用参数?dc=
```

4. session endpoints：session endpoints用来create、update、destory、query sessions
```
/v1/session/create: Creates a new session
/v1/session/destroy/<session>: Destroys a given session
/v1/session/info/<session>: Queries a given session
/v1/session/node/<node>: Lists sessions belonging to a node
/v1/session/list: Lists all the active sessions
```

5. acl endpoints：acl endpoints用来create、update、destory、query acl
```
/v1/acl/create: Creates a new token with policy
/v1/acl/update: Update the policy of a token
/v1/acl/destroy/<id>: Destroys a given token
/v1/acl/info/<id>: Queries the policy of a given token
/v1/acl/clone/<id>: Creates a new token by cloning an existing token
/v1/acl/list: Lists all the active tokens
```

6. status endpoints：status endpoints用来或者consul 集群的信息
```
/v1/status/leader : 返回当前集群的Raft leader
/v1/status/peers : 返回当前集群中同事
```

## registration service
add node and service:
> curl -X PUT -d '{"Datacenter": "dc1", "Node": "amazon", "Address": "www.amazon.com", "Service": {"Service": "shop", "Port": 80}}' http://127.0.0.1:8500/v1/catalog/register

delete node:
> curl -X PUT -d '{"Datacenter": "dc1", "Node": "amazon"}' http://127.0.0.1:8500/v1/catalog/deregister

## KV
add:
> curl -X PUT -d 'hello consul' http://127.0.0.1:8500/v1/kv/foo

delete:
> curl -X DELETE http://127.0.0.1:8500/v1/kv/foo
