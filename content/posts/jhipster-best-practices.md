---
title: "Jhipster 最佳实践"
date: 2016-05-15T10:34:21+08:00
draft: false
---

我用 JHipster 制作的公共安全平台 Fort https://github.com/boyuanitsm/fort

## JHipster 介绍

- Spring Boot + AngularJS 应用生成器
- 完全开源
- 300+贡献者
- 6300+ GitHub stars
- 100+ 公司在生产环境使用它

## 服务端框架

![](/resources/server-side.png)

## 客户端框架

![](/resources/client-side.png)

## 安装 & 生成应用

使用 Yarn 安装

```
$ yarn global add generator-jhipster
```

### 创建一个应用

根据你的需求回答问题来生成一个应用

```
$ mkdir myapp & cd myapp
$ yo jhipster
```

### 集成开发环境配置

Intellij IDEA(recommend), Eclipse

```
$ idea .
```

### 我们生成了什么？

- Spring Boot 应用
- AngularJS 应用
- Liquibase 更新日志文件
- 配置文件

### Gradle / Maven 使用方法

- 可用的功能: clean, compile, run, test…
- 特别的配置文件: 'dev' and 'prod'

```
$ ./gradlew clean test
```

## Docker and Docker Compose

- JHipster 生成了全部的 Docker & Docker Compose 配置
  - 为当前应用构建一个镜像
  - 运行服务: MySQL, ElasticSearch, Kafka
- 配合微服务使用是很好的

```
$ docker-compose -f src/main/docker/mysql.yml up -d
```

## 数据库支持

- 在开发 & 生产可以使用不同的数据库
- H2 基于硬盘和内存
- 目前已支持的数据库: MySQL, MariaDB, PostgreSQL, Oracle
- Spring Data JPA
- HikariCP

## 特性

### Liquibase

- Liquibase 用来管理数据库的更新
  - 使用变更日志
- 非常适合多人协作
  - 当你运行 “git pull”, 你的数据库就保持最新了！
- 表，关系，数据都在 JHipster 生成时就已经创建好了

### 国际化

- i18n 在客户端使用 Angular Translate 来管理
- Java i18n 使用 “normal”
- 目前已经支持 26 种语言，扩展也很容易

### Swagger

- 自动化文档
- 简单易用
- 对 AngularJS 开发者是很友好的 

### WebSockets

- 可选的附加组件
- 使用 Spring WebSockets
- 已经生成了一个用户追踪的例子
  - 追踪目前已登陆用户，当前页面，都是实时的

## 代码生成器 jhipster entity

### 如何创建第一个实体

- 实体子生成器是我们最完整的和最流行的子生成器
- 创建一个实体，完整的增删改查支持
  - Liquibase changelog
  - Spring Data JPA repository
  - Spring MVC REST endpoint
  - AngularJS router/controller/service/view
  - i18n
  - Tests

小提示: 在使用子生成器之前和之后务必使用 Git 保存你的代码

### 如何创建一个字段

- 丰富的可用类型
- 可以使用验证规则
  - 在客户端使用 AngularJS 验证
  - Bean 验证使用 Spring MVC REST 和 Hibernate
  - 数据库约束

### 关系管理

- 使用数据库主键外键关联
- 支持所有的 JPA 关系类型
  - one-to-one, many-to-one, one-to-many, many-to-many
- 单向和双向关系

### 重新生成一个实体

- 实体子生成器可以重新生成一个已存在的实体
- 小提示：高级用户可以直接修改 .jhipster/*.json 文件

## 开始在生成好的应用上开发

### Spring Data JPA

根据 Java 方法名生成 SQL 请求

```
List<Product> findByOrderByName()
List<Item> findByUser(User user)
List<Customer> findByLastName(String lastName)
```

小提示：可以使用 IDE 自动化生成方法

### Liquibase

- 更新日志由 JHipster 生成，也可以手工编写
- 另一个解决方案是使用 Gradle “liquibase:diff” 任务
  - 修改 JPA 代码
  - 编译应用
  - 运行 './gradlew liquibase:diff'
  - 这将生成更新日志更新你的数据库
  - 将生成的更新日志添加到你的主更新日志中
- 更新日志将在应用启动时应用

### Profiles

- JHipster 可以在运行时管理配置文件 (Spring profiles) 和构建时 (Maven/Gradle profiles)
- 两个主 Profiles
  - 'dev' 开发：专注于更好的开发体验
  - 'prod' 生产: 专注于最好的性能和产品化

## 测试已生成的应用

### Spring 集成测试

- JHipster 提供了 JUnit 和 Spring 集成测试支持
- 实体子生成器已经生成了增删改查的测试

### Sonar 代码质量检查

- Sonar 提供了一个完整的应用程序质量报告
  - Java 和 Spring 代码
  - Javascript 代码
- JHipster 提供了一个 Docker Compose 配置可以直接运行 Sonar 服务

```
$ docker-compose -f src/main/docker/sonar.yml up -d
$ ./gradlew clean test sonar:sonar
```

## 产品化

### JHipster 产品化构建

- 生成一个可执行 WAR 文件使用产品化
  - 前端压缩
  - GZip 过滤器
  - HTTP 缓存头部

```
$ ./gradlew clean build -Pprod
$ docker-compose -f src/main/docker/mysql.yml up -d
$ cd build/libs
$ ./myapplication-0.0.1-SNAPSHOT.war
```

### 监控 JHipster

- 标准 Spring Boot Actuator 可用 （图形化的）
- Dropwizard 指标已配置
  - JVM & HTTP 请求指标
  - Spring Beans 指标
  - Ehcache 指标
- 日志可以发送到一个 ELK 服务

### 构建 Docker 镜像

- 全部的 Docker 配置已经生成到 src/main/docker 文件夹
  - 一个 Dockerfile
  - 一个 Docker Compose 配置，包括应用和它的依赖
- 在构建 Docker 镜像时，Docker 守护进程必须已经运行

```
$ ./gradlew clean bootRepackage -Pprod buildDocker
$ docker-compose -f src/main/docker/app.yml up
```

## 工具和子项目

### JDL

- JHipster Domain Language
- 适合制作复杂的实体模块
- 支持所有的实体子生成器特性