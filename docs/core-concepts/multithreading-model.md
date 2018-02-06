---
title: Multithreading Model
description: Learn how to offload heavy work on a non-UI thread to create a responsive UI without slowing down rendering.
position: 110
---

# Multithreading Model

# 多线程模型

One of NativeScript's benefits is that it allows fast and efficient access to all native platform (Android/Objective-C) APIs through JavaScript, without using (de)serialization or reflection. This however comes with a tradeoff - all JavaScript executes on the main thread (AKA the `UI thread`). That means that operations that potentially take longer can lag the rendering of the UI and make the application look and feel slow.

NativeScript 的优势之一是它允许通过 JavaScript 快速高效地访问所有原生平台（Android/Objective-C）的 API，而不是使用序列化（反序列化）或反射。然而这带来了折中条件 - 所有 JavaScript 代码在主线程（又称 `UI线程`）上执行。这意味着可能消耗较长时间的操作会延迟 UI 的渲染，让应用看起来很慢。

To tackle issues with slowness where UI sharpness and high performance are critical, developers can use NativeScript's solution to multithreading - worker threads. Workers are scripts executing on a background thread in an absolutely isolated context. Tasks that could take long to execute should be offloaded on to a worker thread. 

为了解决 UI 锐度和高性能至关重要的问题，开发人员可以使用 NativeScript 的多线程解决方案 - 工作线程（worker threads）。Workers 是在绝对孤立的环境中在后台线程上执行的脚本。可能耗时很久的任务应该放到工作线程上执行。

Workers API in NativeScript is loosely based on the [Dedicated Web Workers API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers) and the [Web Workers Specification](https://www.w3.org/TR/workers/)

NativeScript 中的 Workers API 松散地基于[专用 Web Workers API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers) 和 [Web Workers 规范](https://www.w3.org/TR/workers/)


* [Workers API](#workers-api)
* [Workers API](#workers-api)
    * [Worker Object](#worker-object-prototype)
    * [Worker 对象](#worker-object-prototype)
    * [Worker Global Scope](#worker-global-scope)
    * [Worker 全局作用域](#worker-global-scope)
* [Sample Usage](#sample-usage)
* [使用样例](#sample-usage)
* [Limitations](#limitations)
* [限制](#limitations)

## Workers API

## Workers API

### Worker Object prototype

### Worker Object prototype

 - `new Worker(path)` - creates an instance of a Worker and spawns a new OS thread, where the script pointed to by the `path` parameter is executed.

 - `new Worker(path)` - 创建一个 Worker 实例，并产生一个新的操作系统线程。在此线程中执行 `path` 参数指向的脚本。

 - `postMessage(message)` - sends a JSON-serializable message to the associated script's `onmessage` event handler.

 - `postMessage(message)` - 向关联的脚本的 `onmessage` 事件处理程序发送一个可序列化的 JSON 消息。

 - `terminate()` - terminates the execution of the worker thread on the next run loop tick.

 - `terminate()` - 在下一个运行循环中终止工作线程的执行。

**Worker** Object event handlers

**Workder** 对象事件处理器

 - `onmessage(message)` - handle incoming messages sent from the associated worker thread. The message object has the following properties:

 - `onmessage(message)` - 处理从关联的工作线程传入的消息。消息对象具有以下属性：

    - `message.data` - the message's content, as sent in the worker thread's `postMessage`

    - `message.data` - 消息的内容，即工作线程用 `postMessage` 传入的内容

 - `onerror(error)` - handle uncaught errors from the worker thread. The error object exposes the following properties:

 - `onerror(error)` - 处理工作线程未捕捉的错误。错误对象暴露了以下属性：

    - `error.message` - the uncaught error, and a stacktrace, if applicable

    - `error.message` - 未捕捉的错误，和堆栈跟踪（如果试用）
    
    - `error.filename` - the file where the uncaught error was thrown

    - `error.filename` - 抛出未捕捉错误的文件

    - `error.lineno` - the line where the uncaught error was thrown
 
    - `error.lineno` - 抛出未捕捉错误的行数

### Worker Global Scope

### Worker 全局作用域
 - `self` - returns a reference to the `WorkerGlobalScope` itself

 - `self` - 返回 `WorkerGlobalScope` 本身的引用

 - `postMessage(message)` - sends a JSON-serializable message to the Worker instance's `onmessage` event handler on the main thread.

 - `postMessage(message)` - 向主线程上的 Worker 实例的 `onmessage` 事件处理程序发送可序列化的 JSON 消息。
 
 - `close()` - terminates the execution of the worker thread on the next run loop tick

 - `close()` - 在下一个运行循环中终止工作线程的执行

**Worker** Global Scope event handlers

**Worker** 全局作用域的事件处理程序

 - `onmessage(message)` - handle incoming messages sent from the main thread. The message object exposes the following properties:

 - `onmessage(message)` - 处理主线程发来的消息。消息对象暴露了以下属性：

    - `message.data` - the message's content, as sent in the main thread's `postMessage`

    - `message.data` - 消息的内容，即主线程用 `postMessage` 传入的内容

 - `onerror(error)` - handle uncaught errors occurring during execution of functions inside the Worker Scope (worker thread). The `error` parameter contains the uncaught error. If the handler returns a true-like value, the message will not propagate to the Worker instance's `onerror` handler on the main thread. After `onerror` is called the worker thread, execution is not terminated and the worker is still capable of sending/receiving messages.

 - `onerror(error)` - 处理 Worker 作用域（worker 线程）中函数执行时发生的未捕获错误。`error` 参数包含了未捕获的错误。如果处理程序返回了一个真值，则该消息不会传播到主线程上的 Worker 实例的 onerror 处理程序。工作线程的 `onerror` 被调用后，执行并不会终止，工作线程依然能够发送/接收消息。

 - `onclose()` - handle any "clean-up" work; suitable for freeing up resources, closing streams and sockets.

 - `onclose()` - 处理所有清理工作；适用于释放资源，关闭流和套接字。

## Sample Usage

## 使用样例

![NativeScript Workers API](../img/multithreading/Workers.png)

> Note: In order to use `console`'s methods, setTimeout/setInterval, or other functionality coming from the core-modules package, the `globals` module needs to be imported manually to bootstrap the infrastructure on the new worker thread.

> 注意：为使用 `console` 方法，setTimeout/setInterval，或者其他来自核心模块的功能，在启动一个新的工作线程时需手动引入 `golbals` 模块作为基础依赖。

 main-view-model.js
 ```JavaScript
    ...

    var worker = new Worker('./workers/image-processor');
    worker.postMessage({ src: imageSource, mode: 'scale', options: options });

    worker.onmessage = function(msg) {
        if (msg.data.success) {
            // Stop idle animation
            // Update Image View
            // Terminate worker or send another message

            worker.terminate();
        } else {
            // Stop idle animation
            // Display meaningful message
            // Terminate worker or send message with different parameters
        }
    }

    worker.onerror = function(err) {
        console.log(`An unhandled error occurred in worker: ${err.filename}, line: ${err.lineno} :`);
        console.log(err.message);
    }

    ...
 ```

 workers/image-processor.js
 ```JavaScript
    require('globals'); // necessary to bootstrap tns modules on the new thread

    global.onmessage = function(msg) {
        var request = msg.data;
        var src = request.src;
        var mode = request.mode || 'noop'
        var options = request.options;

        var result = processImage(src, mode, options);

        var msg = result !== undefined ? { success: true, src: result } : { }

        global.postMessage(msg);
    }

    function processImage(src, mode, options) {
        console.log(options); // will throw an exception if `globals` hasn't been imported before this call

        // image processing logic

        // save image, retrieve location

        // return source to processed image
        return updatedImgSrc;
    }

    // does not handle errors with an `onerror` handler
    // errors will propagate directly to the main thread Worker instance

    // to handle errors implement the global.onerror handler:
    // global.onerror = function(err) {}
 ```


## General Guidelines

## 一般准则

 For optimal results when using the Workers API, follow these guidelines:

 为了在使用 Workers API 时获得最佳效果，请遵循以下准则：

  - Always make sure you close the worker threads, using the appropriate API (`terminate()` or `close()`), when the worker's finished its job. If Worker instances become unreachable in the scope you are working in before you are able to terminate it, you will be able to close it only from inside the worker script itself by calling the `close()` function.

  - 务必确保在工作线程完成任务后使用合适的API（`terminate()` 或 `close()`）关闭工作线程。如果 Worker 实例在你当前的作用域内无法访问，你只能通过在工作线程中调用 `close()` 函数来关闭它。

  - Workers are not a general solution for all performance-related problems. Starting a Worker has an overhead of its own, and may sometimes be slower than just processing a quick task. Optimize DB queries, or rethink complex application logic before resorting to workers.

  - 工作线程并不是所有性能相关问题的通解。创建一个工作线程有自己的开销，因此有时比在主线程处理小任务慢。在使用工作线程前应该先优化数据库查询，或者重新考虑一下应用的逻辑。

  - Since worker threads have access to the entire native SDK, the NativeScript developer must take care of all the synchronization when calling APIs which are not guaranteed to be thread-safe from more than one thread.

  - 由于工作线程可以访问全部的原生 SKD，NativeScript 的开发者务必在从多个线程调用不能保证线程安全的 API 时注意同步问题。

## Limitations

## 限制

There are certain limitations to keep in mind when working with workers:

在使用工作线程时要记住一些限制：

 - No JavaScript memory sharing. This means that you can't access a JavaScript value/object from both threads. You can only serialize the object, send it to the other thread and deserialize it there. This is what postMessage() function is responsible for. However, this is not the case with native objects. You can access a native object from more than one thread, without copying it, because the runtime will create a separate JavaScript wrapper object for each thread. Keep in mind that when you are using non-thread-safe native APIs and data you have to handle the synchronization part on your own. The runtime doesn't perform any locking or synchronization logic on native data access and API calls.

 - 无 JavaScript 内存共享。这意味着你无法从两个线程访问同一个 JavaScript 值/对象。只能序列化一个对象，将其发送到另一个线程并在那里反序列化。这是 postMessage() 函数所负责的。然而原生对象却不是这样。你无需复制即可从多个线程访问同一个原生对象，因为运行时将为每个线程创建一个单独的JavaScript包装器对象。请记住，当你使用非线程安全的原生 API 和数据时，你必须自己处理同步部分。 运行时不会对本机数据访问和 API 调用执行任何锁定或同步逻辑。 

 - Only JSON-serializable objects can be sent with postMessage() API. 

 - 只有可序列化的 JSON 对象可以用 postMessage() API 发送。 

   * You can’t send native objects. This means that you can't send native objects with postMessage, because in most of the cases JSON serializing a JavaScript wrapper of a native object results in empty object literal - "{}". On the other side this message will be deserialized to a pure empty JavaScript object. Sending native object is something we want to support in the future, so stay tuned. 

   * 不可以发送原生对象。这意味着你不能用用 postMessage 发送原生对象，因为大多数情况下 JSON 序列化一个 JavaScript 原生对象获得得一个空的字面值 - ”{}“。然后此消息会被反序列化一个纯空的 JavaScript 对象。发送原生对象是我们将来要支持的技术，敬请关注。

   * Also, be careful when sending circular objects because their recursive nodes will be stripped on the serialization step. 

   * 另外，发送循环对象时要小心，因为递归节点将在序列化步骤中被剥离。

 - No object transferring. If you are a web developer you may be familiar with the ArrayBuffer and MessagePort transferring support in browsers. Currently, in NativeScript there is no such concept as object transferring.

 - 没有对象转移。如果你是Web开发人员，则可能熟悉浏览器中的 ArrayBuffer 和 MessagePort 传输支持。 目前，在 NativeScript 中不存在对象传输的概念。

 - Currently, you can’t debug scripts running in the context of worker thread. It will be available in the future.

 - 目前，您无法调试在工作线程上下文中运行的脚本。它将在未来可用。

 - No nested workers support. We want to hear from the community if this is something we need to support.

 - 不支持嵌套工作线程。我们将持续关注社区的意见，如有需要我们将支持这一特性。
