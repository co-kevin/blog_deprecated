---
title: "Golang 牛刀小试"
date: 2017-09-01T14:37:21+08:00
draft: false
---

Python 的开发效率，C 的运行效率

## 简介

Go 是一种开源的程序设计语言，它意在使得人们能够方便地构建简单、可靠、高效的软件。（来自 Go 官网 golang.org）

Go 在 2007 年 9 月形成构想，并于 2009 年 11 月发布，其发明人是 Robert Griesemer、Rob Pike 和 Ken Thompson，这几位都任职于 Google。

## Golang 可以做什么？

- 命令行程序
- 爬虫
- Web 应用后端
- 分布式程序
- 基础设施
- 桌面程序
- etc

Go 编译生成的是一个静态可执行文件，除了 glibc 外没有其他外部依赖，且一次编写，多次编译，到处运行

## Hello World

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World”)
}
```

```shell
$ go run main.go
Hello, World
```

## 一个 Web 服务器

```go
package main

import (
  "fmt"
  "log"
  "net/http"
)

func main() {
  http.HandleFunc("/", handler)
  log.Fatal(http.ListenAndServe("localhost:8000", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "URL.Path = %q\n", r.URL.Path)
}
```

## 基本概念

GOROOT 就是 Go 的源代码和环境 Home，相当于 JAVA_HOME，GOPATH 就是你的工作空间，所有的源代码和依赖都应该放在 src 目录下

- $GOROOT (GO_HOME)
- $GOPATH
- src
  - pkg
  - bin
- go run 最常用的命令之一，运行一个 go 程序
- go get 获取一个 go 代码库
- go build 构建静态文件
- go fmt 格式化源代码，不用再纠结格式
- go test 运行 go 单元测试

## 程序结构

```go
package main // 包名

import ( // 导包，在 $GOROOT 和 $GOPATH 下找
  "fmt"
  "log"
  "net/http"
)

const ( // 全局常量，包内共享
  SERVE_ADDR = "localhost:8000"
)

// 主函数，程序入口
func main() {
  http.HandleFunc("/", handler)
  log.Fatal(http.ListenAndServe(SERVE_ADDR, nil))
}

// 私有函数
func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "URL.Path = %q\n", r.URL.Path)
}
```

## 函数

每一个函数声明都包含一个名字、一个形参列表、一个可选的返回列表以及函数体

```go
func name(parameter-list) (result-list) {
  body
}
```

## try catch? 不存在的

Golang 错误处理策略: 采用多返回值的方法来处理异常，通常习惯将错误值作为最后一个结果返回。

```go
value, ok := cache.Lookup(key)
if !ok {
  // ...cache[key] 不存在...
}
```

## 多错误处理策略

没有策略，Go 源代码中到处都有类似的代码，如果调用函数时会有异常，需要多次判断异常是否为 nil，造成代码冗余

```go
req, err := http.NewRequest(http.MethodPost, LOGIN_RESOURCE, nil)
if err != nil {
  return nil, err
}
res, err := disguise.Do(req, jar)
if err != nil {
  return nil, err
}
defer res.Body.Close()
body, err := ioutil.ReadAll(res.Body)
if err != nil {
  return nil, err
}
var result LoginResponseBody
if err = json.Unmarshal(body, &result); err != nil {
  return nil, err
}
if result.Code != "0" {
  return nil, structs.NewCrawlAuthorizationErrorf(result.Message)
}
```

## goroutine 和通道

并发编程表现为程序由若干个自主的活动单元组成，它从来没有像今天这样重要。

```go
f() // 调用 f(); 等待它返回
go f() // 新建一个调用 f() 的 goroutine, 不用等待
```

## 通道

如果说 goroutine 是 Go 程序并发的执行体，通道就是他们之间的连接。

我们创建了一个 msg 通道用来接收子协程的消息

```go
package main

import "log"

func main() {
  msg := make(chan string)
  go func(){
    msg <- "Hello, go chan"
  }()
  log.Println(<- msg)
}
```

## 学习资源推荐

- https://golang.org 官网
- https://studygolang.com Go 语言中文网
- https://github.com/avelino/awesome-go 框架、库、软件集合
- https://github.com/Unknwon/the-way-to-go_ZH_CN Go入门指南
- https://github.com/astaxie/build-web-application-with-golang 使用 Go 语言构建 Web 应用