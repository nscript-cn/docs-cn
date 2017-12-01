---
title: How to Build NativeScript Apps That Start Up Fast
description: A straight-to-the-point list of steps you can take to make sure your NativeScript apps start up as fast as possible.
position: 50
slug: startup-times
---

# How to Build NativeScript Apps That Start Up Fast

# 构建一个快速启动的NativeScript应用

NativeScript allows you to write native iOS and Android applications using JavaScript. Although there are many advantages to taking this approach—using one language to write multiple apps, faster development times from using an interpreted language, and so forth—there is one fact NativeScript developers can’t avoid: NativeScript apps can take longer to start up than applications written with native development languages such as Objective-C and Java.

开发者可以借助NativeScript来使用JavaScript就可以开发原生的iOS或者Android应用。这样的开发方式有很多优势，比如使用一种语言就可以开发多种平台的应用，亦或者是使用解释型语言会有更快的开发速度，等等。不过，下面这种情况是多数NativeScript的开发者无法避免的：NativeScript的应用的启动时间可能会比使用如Object-C或者Java原生语言开发的应用要更长一些。

Don’t worry though—with a few optimizations, NativeScript apps can startup fast enough for the overwhelming majority of app use cases. This article is a straight-to-the-point list of steps you can take to make sure your NativeScript apps start up as fast as possible. 

不过不要担心，只需要一些配置优化即可使得NativeScript移动应用在大部分使用情形下的启动速度变得很快。本文秉要执本，列举了一系列能够大幅度提高NativeScript移动应用启动速度的步骤。

> **NOTE**: Jump to the [summary](#summary) if you want an explanation-free list of commands to run.

> **注意**： 如果想要略过解释部分，可以直接查看[总结](#总结)

* [Step 1: Enable webpack](#step-1)
* [步骤 1：使用webpack](#步骤-1)
* [Step 2: Add uglification](#step-2)
* [步骤 2: 添加uglification](#步骤-2)
* [Step 3: Perform heap snapshots](#step-3)
* [步骤 3: 使用堆快照](#步骤-3)
* [Summary](#summary)
* [总结](#总结)

<h2 id="step-1">Step 1: Enable webpack</h2>
<h2 id="步骤-1">步骤 1: 使用webpack</h2>

File I/O is one of the biggest reasons that NativeScript apps can start up slowly. Every time you do a `require()` call in your app, the NativeScript modules must retrieve a file from your app’s file system, and run that file through the [JavaScript virtual machine that NativeScript uses](http://developer.telerik.com/featured/nativescript-works/). That cost adds up, especially in larger apps that might require hundreds or thousands of modules to render their first page.

NativeScript应用启动速度慢的主要原因之一是文件读写。应用中每一次调用`require()`函数，NativeScript模块就会检索当前应用文件系统，查找目标文件，并在[NativeScript的JavaScript虚拟机](http://developer.telerik.com/featured/nativescript-works/)中使用。这些开销是会累加的。在一些较大的应用的在首页中可能需要渲染大量的模块，这将极大的减缓启动速度。

The best way to reduce this file I/O is to place all of your JavaScript code in a small number of files. For NativeScript apps the best way to do this is [enabling the NativeScript webpack plugin](https://docs.nativescript.org/best-practices/bundling-with-webpack), which gives you the ability to use the popular [webpack](https://webpack.github.io/) build tool to optimize your NativeScript apps.

减少文件读写的优化方案是将应用中所有的JavaScript代码放到尽可能少的文件数量中。对于NativeScript应用来说，最好的方式则是使用[NativeScript的webpack插件](https://docs.nativescript.org/best-practices/bundling-with-webpack)，这个插件的使用能够借助webpack构建工具来优化NativeScript应用。

First you’ll want to install the plugin.

首先，安装webpack插件。

```
npm install --save-dev nativescript-dev-webpack
```

And then run `npm install` to install its dependencies.

然后安装依赖。

```
npm install
```

When the `install` command finishes, you’ll have a series of scripts you can use to build your NativeScript apps with webpack optimizations enabled.

当`install`命令结束的时候，就可以借助webpack的很多优化工具来进行NativeScript应用的打包。

> **NOTE**: Webpack is not enabled by default as it slows down NativeScript’s build processes. Although you’re welcome to use webpack for all your builds, we recommend using webpack only for benchmarking and release builds.

> **注意**： 由于Webpack会减缓NativeScript应用的打包过程，所以默认状态下Webpack是没有启用的。虽然在各种应用打包情况下使用webpack都是没有问题的，不过仍然建议在对标分析或者发布版本的时候启用webpack来帮助优化打包。

You can go ahead and run one of the following two commands to see how much faster your apps run with the default webpack configuration in place.

在默认的webpack配置下，运行下面两条命令之一，来感受一下应用的运行速度的提升。

```
npm run start-android-bundle
```

Or

或者

```
npm run start-ios-bundle
```

> **NOTE**: If you’re having trouble enabling webpack in your own apps, feel free to reach out for help on the [NativeScript community forum](https://discourse.nativescript.org/).

> **注意**： 在应用开发过程中使用webpack遇到了困难？赶快来[NativeScript社区](https://discourse.nativescript.org/)寻求帮助。

To give you a sense of how big of a difference webpack makes, let’s look at some before and after videos of applying webpack builds to the [NativeScript Groceries sample](https://github.com/nativescript/sample-Groceries). Here’s what Groceries looks like if you start it _without_ using webpack.

下面一组关于[NativeScript Groceries](https://github.com/nativescript/sample-Groceries)示例引用的对比图片刚好能够展示出webpack的优化效果。

下面两张图是在没有__启用__webpack时，Groceries的启动情况。

<div style="display: flex; max-width: 100%;">
  <img src="../img/best-practices/ios-start-up-0.gif" style="height: 450px;">
  <img src="../img/best-practices/android-start-up-0.gif" style="height: 450px;">
</div>

And here’s the same app with webpack turned on.

下面两张图则是__启用__了webpack时，Groceries的启动情况。

<div style="display: flex; max-width: 100%;">
  <img src="../img/best-practices/ios-start-up-1.gif" style="height: 450px;">
  <img src="../img/best-practices/android-start-up-1.gif" style="height: 450px;">
</div>

> **NOTE**:
> * The above iOS and Android test runs were run on a physical iPhone 6S and a physical Nexus 6, respectively. You’re welcome to repeat the tests by cloning the [Groceries sample from GitHub](https://github.com/nativescript/sample-Groceries).

> **注意**： 上面iOS和安卓的图片分别是iPhone 6S和Nexus 6的真机测试结果。欢迎通过克隆在GitHub上的[Groceries项目](https://github.com/nativescript/sample-Groceries)来复现测试过程。

> * You can enable [far more detailed profiling information using a flag in your `package.json` file](https://www.nativescript.org/blog/deep-dive-into-nativescript-3.1-performance-improvements).

> * [配置`package.json`文件中`"profiling"`字段来获得更多关于应用分析的信息](https://www.nativescript.org/blog/deep-dive-into-nativescript-3.1-performance-improvements)

Webpack speeds up your app by placing most of your application code in two files—`vendor.js` and `bundle.js`. If you’re curious, you can find those files in your `platforms/ios/NAME_OF_YOUR_APP_/app` folder for iOS, and in your `platforms/android/src/main/assets/app` folder for Android.

Webpack通过把应用的大多数代码放到`vendor.js`和`bunlde.js`中来加快应用的运行速度。iOS平台，这些文件将会在`platforms/ios/NAME_OF_YOUR_APP_/app`文件夹中，而Android平台，则在`platforms/android/src/main/assets/app`文件夹中。

Your app should be a lot faster now that you’re using a lot fewer files, but we’re just getting started. Even though your app only uses two JavaScript files, there’s still a cost for NativeScript to parse all of the JavaScript code that lives in those files.

现在应用中使用的文件数量变少了，应用的运行速度会大幅加快。不过，这才刚开始呢。尽管现在应用只使用两个JavaScript文件，但是NativeScript解析这其中的JavaScript代码依然会有很大的开销。

Simply put, the more lines of JavaScript code in your app, the more time it’ll take NativeScript to interpret that code and get your app up and running. Luckily webpack can help with that as well.

换言之，应用中JavaScript的代码量越多，NativeScript就要花更多的时间来解析以及运行JavaScript代码。幸运的是webpack在这方面也能帮助优化。

> **TIP**: Check out the [NativeScript webpack documentation](https://docs.nativescript.org/best-practices/bundling-with-webpack) for more details on using webpack in NativeScript, including advanced configuration options.

> **提示**：[NativeScript的webpack文档](https://docs.nativescript.org/best-practices/bundling-with-webpack)中有更多关于在NativeScript中使用webpack的高阶配置。

<h2 id="step-2">Step 2: Add uglification</h2>
<h2 id="步骤-2">步骤 2: 添加uglification</h2>

Webpack has a number of plugins that extend its capabilities, but perhaps the most useful plugin is built right into webpack itself—[UglifyJS](https://github.com/mishoo/UglifyJS2). As its name implies, UglifyJS compresses and minifies your JavaScript code to reduce files sizes.

Webpack中有很多扩展其功能的插件，其中最有用当属[UglifyJS](https://github.com/mishoo/UglifyJS2)，该插件已经集成到webpack自身之中。正如UglifyJS其名所示，它的作用就是通过压缩和简化JavaScript代码来减小文件体积。

For NativeScript apps there are two advantages to using UglifyJS. First, because UglifyJS reduces the file size of JavaScript files, it’ll also reduce the file size of your app as a whole. Second, because UglifyJS removes dead code as it minifies your code, your app will start up faster because there will be fewer JavaScript instructions for NativeScript to parse.

在NativeScript应用中使用UglifyJS有两个好处。第一，UglifyJS减小了文件体积，自然就降低了最后app的整体大小。第二，UglifyJS在压缩代码的过程中，删掉了多余的冗余代码（比如未使用的变量），NativeScript需要解析的代码量就减少了，app就会更快的启动。

Using UglifyJS is easy too. To use UglifyJS as part of your NativeScript builds, all you need to do is add a `--uglify` flag to the scripts you ran earlier. That is, run one of the following commands.

使用UglifyJS也非常简单，只需要在前面运行的脚本语句中加`--uglify`选项即可，亦即下面的语句。

```
npm run start-android-bundle --uglify
```

Or

或者

```
npm run start-ios-bundle --uglify
```

If you open your `vendor.js` and `bundle.js` files, you should now see compressed code that looks something like this.

这样打包后的`vendor.js`或者`bundle.js`的内容将会跟下面的图类似。

![](compressed-code.png)

The more code you have, the more of a difference the UglifyJS optimization will make. Here’s what the NativeScript Groceries sample looks like with Uglify added to the webpack build process.

代码越多，UglifyJS优化过程就越明显。下图展示了在使用Uglify后打包的Groceries应用启动情况。

<div style="display: flex; max-width: 100%;">
  <img src="../img/best-practices/ios-start-up-2.gif" style="height: 450px;">
  <img src="../img/best-practices/android-start-up-2.gif" style="height: 450px;">
</div>

To recap our steps so far, you started by enabling webpack, which placed all of your application code into two files. Having your code in two files greatly reduced the file I/O NativeScript had to do when your app started, and your startup times improved.

现在简单回顾一下之前的步骤。

先是使用webpack。webapck把整个应用的代码整理到两个文件。应用启动时，涉及I/O操作的文件数量降低至两个，所以启动速度会变快。

Next, you enabled UglifyJS, which reduced the size of your app by removing dead code. Fewer lines of code meant less JavaScript for NativeScript to parse when your app started up, so your startup times improved again.

然后是使用UglifyJS。UglifyJS通过删除冗余代码来降低应用大小。更少的JavaScript代码意味着NativeScript在应用启动的时候解析的代码量更少，所以启动速度又一次加快。

As a next step you’re going to take things one step further, and register your JavaScript with the JavaScript virtual machine itself.

接下来还可以有一个步骤能够进一步加快启动速度，这一步需要在JavaScript虚拟机中写一些特别的JavaScript代码来实现。

<h2 id="step-3">Step 3: Perform heap snapshots</h2>
<h2 id="步骤-3">步骤 3: 使用堆快照</h2>

NativeScript runs the JavaScript code you write through a [JavaScript virtual machine](http://developer.telerik.com/featured/a-guide-to-javascript-engines-for-idiots/), which is essentially a piece of software that’s specifically designed to interpret and execute JavaScript code.

NativeScript在[JavaScript虚拟机](http://developer.telerik.com/featured/a-guide-to-javascript-engines-for-idiots/)运行应用的JavaScript代码。这个JavaScript虚拟机的出现就是为了解析并运行JavaScript代码，因此它是整个软件极其重要的一部分。

NativeScript Android apps run on top of Google’s V8 engine, and NativeScript iOS apps run on top of Apple’s JavaScriptCore engine. V8 has a [neat feature called heap snapshots](https://v8project.blogspot.bg/2015/09/custom-startup-snapshots.html), which NativeScript leverages to give a powerful boost to Android startup times.

NativeScript的Android应用是基于Google的V8引擎运行，而NativeScript的iOS应用则是基于Apple的JavaScriptCore引擎运行。V8引擎有一个被称作[堆快照Heap Snapshots](https://v8project.blogspot.bg/2015/09/custom-startup-snapshots.html)的特点，NativeScript刚好利用了这一点来加快Android应用的启动速度。

Here’s the basics of how heap snapshots work: when you start up your app, normally, the JavaScript VM has to fetch and parse every JavaScript file you use intend to use in your app. There is a cost to doing this, and that cost is one thing that can slow down the startup of your NativeScript apps.

堆快照的工作流程如下：应用启动时，JavaScript虚拟机需要去文件系统中查取并解析所有将会在应用中使用的JavaScript文件。这一步操作需要很大的开销，往往这个开销会很大程度的减缓NativeScript应用的启动速度。

What V8 lets you do, however, is provide a so-called heap snapshot, or a previously prepared JavaScript context. In other words, instead of NativeScript fetching, parsing, and executing scripts on every startup, the NativeScript Android runtime can instead look for a previously prepared binary file that is the result of those tasks, and just use that instead—greatly reducing the amount of time it takes for your app to get up and running.

而V8提供的堆快照（JavaScript缓存空间）功能可以解决这个问题。换言之，NativeScript的Android应用在启动时不是去系统中查取、解析、执行所需的JavaScript文件，它会直接去找上面三步执行完之后的二进制可执行文件，找到后就直接执行。这样的替换工作能够大幅度的降低应用的启动耗时。

In NativeScript we’re integrated this process directly within our webpack build process; therefore, running a build with V8 heap snapshots enabled is as simple as adding a `--snapshot` flag to the previous step.

NativeScript的webpack打包过程中已经集成了这个功能。因此，如果使用V8堆快照功能进行打包的操作，只需要在打包命令中加`--snapshot`选项而已，是不是跟前面的命令一样简单？

```
npm run start-android-bundle --uglify --snapshot
```

There are two important things to note:

两个重点：

1) Because heap snapshots are a feature of V8, you can only use this feature as part of your NativeScript Android builds. A similar feature is not available for NativeScript iOS builds.

1) 堆快照功能是V8引擎的功能之一，它只能在NativeScript的Android应用中使用，在iOS应用中则没有相应可用的功能。

2) Under the hood, the NativeScript snapshot generator uses a V8 tool called `mksnapshot`. The `mksnapshot` tool only supports macOS and Linux, and therefore at the moment you are unable to use the `--snapshot` flag as part of your builds on Windows. On Windows-based development machine the NativeScript CLI ignores the `--snapshot` flag.

2) NativeScript的快照生成器(snapshot generator)工作时调用了V8的`mksnapshot`工具。`mksnapshot`工具只支持MacOS和Linux系统，因此在Windows系统中无法使用`--snapshot`参数，即使使用了也会被忽略。

Because heap snapshots completely avoid the need to parse and execute the vast majority of your JavaScript on startup, they tend to speed up the startup times of NativeScript apps substantially. Here’s how the NativeScript Groceries app starts up on Android with heap snapshots enabled.

堆快照功能完全省去了应用启动时解析和执行大量JavaScript的工作，因此能够很大程度上提高应用的启动速度。下面展示了Groceries应用使用了堆快照功能后的启动情况。

<img src="../img/best-practices/android-start-up-3.gif" style="height: 450px;">

> **NOTE**: For a far more technical explanation of how V8 heap snapshots work in NativeScript, and how you can configure and optimize the snapshots, check out [this article on the NativeScript blog](https://www.nativescript.org/blog/improving-app-startup-time-on-android-with-webpack-v8-heap-snapshot).

> **注意**：[拓展阅读：详解V8堆快照功能在NativeScript中的工作原理及其配置与优化](https://www.nativescript.org/blog/improving-app-startup-time-on-android-with-webpack-v8-heap-snapshot)

<h2 id="summary">Summary</h2>
<h2 id="总结">总结</h2>

By enabling webpack, using UglifyJS, and performing V8 heap snapshot builds, you have the ability to greatly improve the startup times of your NativeScript applications. As a reference, here is a brief summary of the commands you need to run to enable all optimizations.

通过使用webpack、UglifyJS以及V8的堆快照功能，NativeScript应用的启动速度将会大幅度的提升。为了方便参考查阅，下面简单总结了优化过程所使用的命令。

1) Install webpack.

1) 安装webpack

```
npm install --save-dev nativescript-dev-webpack
```

2) Install webpack’s dependencies.

2) 安装webpack的依赖

```
npm install
```

3) Run on iOS with webpack and UglifyJS enabled.

3) 启用webpack，UglifyJS，在iOS上运行

```
npm run start-ios-bundle --uglify
```

4) Run on Android with webpack, UglifyJS, and V8 heap snapshot builds enabled.

4) 启用webpack，UglifyJS，以及V8的堆快照，在安卓上运行

```
npm run start-android-bundle --uglify --snapshot
```
