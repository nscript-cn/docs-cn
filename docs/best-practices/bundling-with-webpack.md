---
title: Bundling Script Code with Webpack
description: Learn how to optimize your code and reduce application size.
position: 40
slug: bundling-with-webpack
previous_url: /core-concepts/bundling-with-webpack,/tooling/bundling-with-webpack
---

# Using Webpack to Bundle Your Code

# 使用Webpack打包代码

1. [Overview](#overview)

1. [概况](#概况)

1. [Introducing Webpack](#introducing-webpack)

1. [Webpack介绍](#Webpack介绍)

1. [Installation](#installation-and-configuration)

1. [安装与配置](#安装与配置)

1. [How nativescript-dev-webpack works](#how-nativescript-dev-webpack-works)

1. [nativescript-dev-webpack工作原理](#nativescript-dev-webpack工作原理)

1. [Usage](#usage)

1. [使用](#使用)
    1. [NPM scripts](#npm-scripts)

    1. [NPM脚本](#NPM脚本) 

    1. [Publishing Application](#publishing-application)

    1. [发布应用](#发布应用)

    1. [Angular and Ahead-of-Time Compilation](#angular-and-ahead-of-time-compilation)

    1. [Angular和预编译](#Angular和预编译)

    1. [Bundling Extra Assets](#bundling-extra-assets)

    1. [打包额外资源](#打包额外资源)    

1. [Advanced Optimizations](#advanced-optimizations)

1. [优化进阶](#优化进阶)

    1. [Uglify.js](#uglifyjs)

    1. [Uglify压缩](#uglify压缩)

    1. [V8 heap snapshot generation](#v8-heap-snapshot)

    1. [V8堆快照](#v8堆快照)

1. [Debugging common errors](#debugging-common-errors)

1. [常见错误调试](#常见错误调试)

    1. [Dynamic Imports](#dynamic-imports)

    1. [动态引入](#动态引入)

    1. [Debugging Bundling Errors](#debugging-bundling-errors)

    1. [处理打包错误](#处理打包错误)

    1. [Inspecting Bundles](#inspecting-bundles)

    1. [检查生成的Bundle文件](#检查生成的Bundle文件)

1. [Recommendations for Plugin Authors](#recommendations-for-plugin-authors)

1. [給插件作者的一些建议](#给插件作者的一些建议)

1. [Webpack resources](#webpack-resources)

1. [Webpack相关文档](#Webpack相关文档)

1. [Showcase apps](#showcase-apps)

1. [示例应用](#示例应用)

## Overview

## 概况

JavaScript code and general asset bundling has been a member of the web developer toolbox for a long time. Tools like [webpack](https://webpack.github.io/) have been providing support for an enjoyable development experience that lets you assemble client-side code from various module sources and formats and then package it together. Most importantly, they allow for page load time optimizations that reduce or parallelize the number of requests a browser makes to the server.

在web开发中，Javascript代码和普通资源进行打包的做法已经有很长一段时间了。类似于[webpack](https://webpack.github.io/)的工具能够将客户端的中来自不同模块的代码进行格式整合并且打包，带来了非常棒的开发体验。更重要的是，这些工具的使用通过减少或并行浏览器对服务器发起的请求来够降低页面加载的时间。

Why bundle scripts in a mobile app though? Aren't all files stored on the local device, so requesting them should be faster than an HTTP request?! Yes, that is the case, but bundling still has an important place in mobile app optimizations:

那么为什还要在移动应用中打包这些脚本文件呢？难道请求这些保存在设备本地的文件不会比向服务器请求更快吗？诚然，但是在移动应用中打包资源文件依然是应用优化的重要一步：

* Fewer filesystem operations on app startup since all code is loaded from a single bundle file. Mobile file storage is not known for being very performant.

* 应用启动时只需要从一个文件中加载所有代码，降低了文件系统的操作。要知道，手机的文件存储和读取并不是那么高效的。

* Smaller code size. Bundlers traverse the module import graph and do not bundle unused modules. Not using that obscure feature in module X? Don't make your users pay for it then.

* 更小的代码量。打包工具会遍历模块的引用情况，因此打包时会忽略那些从未使用到的模块。

    * Tree-shaking. With the advent of ECMAScript 2015 modules, we have new tools that allow stripping unused parts of big modules and further reduce our application size.

    * Tree-shaking. 随着ECMAScript2015带来的全新模块机制，能够借助新工具来删掉那些大模块中未使用的代码部分，进一步降低应用大小。

* Preprocessing and interoperability hooks (not covered in this article). Webpack provides a way to resolve modules and expressions differently according to its configuration. It also contains a lot of plugins and loaders that let you embed different content in your application or use code written in different programming languages.

* 预处理和互相操作性（本文并未详述）。Webpack根据配置文件不同，对模块和表达式有不同的处理方式。Webpack还提供了许多插件或者处理器，使得开发者能够在应用中嵌入不同的内容或者是其他语言写成的代码。


## Introducing Webpack

## Webpack介绍

Webpack works by traversing your source tree starting from a number of "entry" modules and navigating through module imports. This makes it possible to collect just modules that are actually used in your program. Webpack is very extensible -- you can customize every step of the bundling process and add support for all sorts of asset generation and manipulation procedures.

Since bundling can be a slow and resource intensive operation, we do not enable it for every build. It is easiest to develop and debug your code without bundling, and use bundled code for QA/release builds.

Webpack会从一些入口文件开始，遍历所有文件的模块引入情况。这个过程能够让Webpack明确知道应用中每个模块的实际使用情况。此外，Webpack的扩展性很强，允许自定义打包过程的每一步，也允许各种资源文件的生成和操作过程。

打包过程是缓慢而又消耗资源的过程，NativeScript并没有在每一个应用的构建中启用了Webpack。在应用开发过程中，不需要打包就可以编写代码进行开发以及调试，等需要进行使用测试版／发行版时才进行打包过程。

## Installation and Configuration

## 安装与配置

Since every project is unique and can have quite complex requirements for bundling we tried to make webpack configuration as simple as possible. After installation, the plugin will configure the bundling dependencies, and add a basic configuration that should work for most projects. Developers can (and should) extend that to fit their specific project needs.

每个应用项目都是不一样的，对于打包又可能各有各的复杂要求。NativeScript尽量使得Webpack的配置变得简单。安装完成之后，插件(nativescript-dev-webpack)会自动处理打包所需要的配置依赖，添加一些适用于大多数应用开发的基础配置。开发者可以根据自己的需要进行进一步的配置。

The easiest way to enable webpack support for your application is to install the `nativescript-dev-webpack` plugin. To do that, run this in your application folder:

在应用项目中使用Webpack的方法很简单，只要安装 `nativescript-dev-webpack`就可以了。在项目根目录下，运行语句：

```
$ npm install --save-dev nativescript-dev-webpack
```

The plugin adds a few dependencies to the project. Don't forget to install them:

该插件为应用添加了一些额外的依赖，别忘了一并安装：

```
$ npm install
```

#### XML Pages and Code-behind Files

#### XML页面和对应的JS文件

XML page definitions load JavaScript modules named with the same name as the XML file that contains the UI markup. To make those work with webpack bundles, you need to register them as dynamic modules:

XML页面文件中包含了UI标签，运行时会加载同名的JS文件。为了能使这样的过程在Webpack中依然有效，需要将他们注册成为动态模块：

```JavaScript
global.registerModule("main-page", () => require("./main-page"));
```

Here's an example [configuration](https://github.com/NickIliev/NativeScript-Cosmos-Databank/blob/master/app/bundle-config.ts).

可查看[例子](https://github.com/NickIliev/NativeScript-Cosmos-Databank/blob/master/app/bundle-config.ts)。

For non-Angular apps, make sure to add `bundle-config.js|ts` file in the `app` folder with the following content:

对于没有使用Angular框架的应用，需要在`app`文件夹下的`bundle-config.js|ts`文件中加入以下内容：

```
if (global["TNS_WEBPACK"]) {
    require("tns-core-modules/bundle-entry-points");
    global.registerModule("main-page", function () { return require("./main-page"); });
    // register more application modules here following the example above
}
```

Then import `bundle-config` on top of `app.js|ts`

然后在`app.js|ts`的顶部引入`bundle-config`

```JavaScript
require("./bundle-config");
```

```TypeScript
import "./bundle-config";
```
## How nativescript-dev-webpack Works

## nativescript-dev-webpack工作原理

Installing the plugin adds several updates to your project:

`nativescript-dev-webpack`插件安装时会对应用项目进行一些更新：

- `devDependencies` settings that will contain the most popular webpack package and several loaders and plugins.

- 新增`devDependencies`设置，增加一些常用的Webpack包和一些处理器及插件等。

- `webpack.config.js` -- this is the configuration file. It contains sensible defaults, but it is designed to be as readable and easy to modify as possible.

- 新增`webpack.config.js`。该文件是Webpack的配置文件，包含一些基本配置，允许开发者根据需要进行改写。

- Application source files configuring bundle chunks:

- 新增应用源代码文件配置通用模块：

    - `app/vendor`. Defines vendor modules which get bundled separately from application code.

    - 新增`app/vendor`文件。定义了独立于应用的一些通用模块代码。

    - `app/vendor-platform.android` and `app/vendor-platform.ios`. Define platform-specific vendor modules.

    - 新增`app/vendor-platform.android`和`app/vendor-platform.ios`文件。定义了跟平台相关的通用模块代码。

- Several helper scripts in your project's `package.json` files that let you build a bundled version: `build-<platform>-bundle`, `start-<platform>-bundle` and others.

- `package.json`文件中新增一些帮助脚本，比如允许进行版本打包：`build-<platform>-bundle`或`start-<platform>-bundle`，等等。


## Usage

## 使用

### NPM scripts

### NPM脚本

`nativescript-dev-webpack` changes the usual workflow of working with your project. Instead of using `tns` CLI commands, we will use `npm run` commands to invoke scripts that prepare the bundled version.

`nativescript-dev-webpack`改变了项目的工作流程。因此不需要使用`tns`这个命令，只需要运行`npm run`即可运行脚本，进行打包或构建。

Given that you have your project running in its non-bundled state, you can test the bundled version with the following command(s):

假设某个开发项目，想要在尚未打包的状态中运行，可以尝试下面的命令来测试打包版本的情况：

```
$ npm run start-android-bundle
```

or

或者

```
$ npm run start-ios-bundle
```

If you want to package your application, you need the `build-...` commands:

如果需要对应用进行打包，则尝试`build-...`的命令：

```
$ npm run build-android-bundle
```

or

或者

```
$ npm run build-ios-bundle
```

The former will produce an android `.apk` archive, while the latter will create an `.app` or `.ipa` package.

前者会生成一个Android的`.apk`文件，后者会生成iOS的`.app`或`.ipa`文件。

Note that the `build-<platform>-bundle` commands will ultimately call `tns build <platform>` behind the scenes. By default it will not pass any extra parameters to the `tns` tool, so, if you need a release build, signed with a certain key, you would need to provide the parameters prefixed by a `--` marker. For example, here is how you'd create a release build for an iOS device containing bundled scripts:

注意，`build-<platform>-bundle`命令最终还是会调用`tns build <platform>`命令。默认情况下，不会给`tns`命令传递任何参数。如果需要在打包时传递一些参数，需要提供以`--`前置修饰的参数。例如，下面的命令可以用来生成一个iOS的发行版本：

```
$ npm run build-ios-bundle -- --release --forDevice --teamId TEAM_ID
```

The corresponding command for android looks like:

相应的，发行Android的版本命令如下：

```
$ npm run build-android-bundle -- --release --keyStorePath ~/path/to/keystore --keyStorePassword your-pass --keyStoreAlias your-alias --keyStoreAliasPassword your-alias-pass
```

You can also use the same method to provide environmental variables to the webpack build:

利用同样的方式也可以进行环境参数的传递：

```
$ npm run build-android-bundle -- --env.development --env.property=value
```

They can be accessed through the `env` object in the webpack configuration:

这些参数可以在Webpack配置文件的`env`对象中获取：

```js
// webpack.config.js

...
module.exports = env => {
    console.dir(env); // { development: true, property: 'value' }
    ...
}
```

### Publishing Application

### 发布应用

A bundled version of the application for Android can be built in release with this script:

下面的脚本可以用来打包一个`bundled`过的安卓应用：

```
$ npm run build-android-bundle -- --release --keyStorePath ~/path/to/keystore --keyStorePassword your-pass --keyStoreAlias your-alias --keyStoreAliasPassword your-alias-pass
```

Once this is finished, proceed with uploading the output .apk file in the <project>/platforms/android/build/outputs/apk directory on Google Play store.

当上述过程结束的时候，会自动将`<project>/platforms/android/build/outputs/apk`下生成的`.apk`文件上传到Google Play Store。

You can build a bundled version of the application for iOS in release with this script:

同样的用类似的脚本打包一个iOS应用：

```
$ npm run build-ios-bundle -- --release --forDevice --teamId TEAM_ID
```

Once the release build is ready, you have two options:

当发行包完成的时候，通常可以有两种选择：

* Open `<project/platforms/ios/<project>.xcodeproj>` (or `<project/platforms/ios/<project>.xcworkspace>` if present) in Xcode to configure project signing and upload the archive to App Store. This is the recommended option.

* 在Xcode中打开`<project/platforms/ios/<project>.xcodeproj>` (或者优先打开 `<project/platforms/ios/<project>.xcworkspace>`)， 配置好项目签名，将应用包上传到App Store。

* Specify your development team in `<project>/app/App_Resources/iOS/build.xcconfig` from the command line and execute 

* 在 `<project>/app/App_Resources/iOS/build.xcconfig` 中配置好Apple开发的`team`信息，然后运行下面的脚本：

```
$ npm run publish-ios-bundle --  --teamId TEAM_ID APPLE_ID APPLE_PASSWORD
```

>If there are multiple mobile provisioning profiles for the selected development team available on the machine, it is not guaranteed that Xcode will select the desired one and publishing using the command line will be successful. Therefore, in such cases we recommend manually configuring and uploading the project from Xcode.

如果电脑上有多个`mobile provisioning`文件，命令行的脚本命令不能保证Xcode在上传时能够选择正确的那一个。因此建议在Xcode中进行手动配置，然后进行上传。

### Angular and Ahead-of-Time Compilation

### Angular和预编译

NativeScript Angular projects will also have the [`@ngtools/webpack`](https://www.npmjs.com/package/@ngtools/webpack) plugin added. The former performs Ahead-of-Time compilation and code splitting for lazy loaded modules. Also, if your application is Ahead-of-Time compiled, you won't have Angular compiler included in your bundle which results in smaller application size and improved start up time.

NativeScript的Angular项目已经包含了[`@ngtools/webpack`](https://www.npmjs.com/package/@ngtools/webpack)插件。该插件能够进行预编译，并分离出那些需要懒加载的代码。而且，如果应用是预编译过的，应用包中将不再需要Angular的编译器，这又可以减少应用的体积，提高启动速度。

To take advantage of Ahead-of-Time compilation, you need to bootstrap your app with the static NativeScript Angular platform instead of the dynamic one. For that, you will have to create a `main.aot.ts` file next to your `app/main.ts` file. Also make sure, that the `main` property in your `app/package.json` is `main.js`. If your root NgModule is named `AppModule` and is located in `app/app.module.ts`, the content of the `main.aot.ts` file should be the following:

只有用静态（非动态）的NativeScript Angular平台启动应用，才能享受到预编译带来好处。因此，需要在`app/main.ts`同级目录下新建`main.aot.ts`文件，以及`app/package.json`中的属性`main`的值为`main.js`。如果Angular的根模块是`AppModule`而且在`app/app.module.ts`中声明，那么`main.aot.ts`文件应该跟下面的一样：

```ts
// app/main.aot.ts
import { platformNativeScript } from "nativescript-angular/platform-static";
import { AppModuleNgFactory } from "./app.module.ngfactory";

platformNativeScript().bootstrapModuleFactory(AppModuleNgFactory);
```

Note that the `./app.module.ngfactory` file still does not exist. It will be in-memory generated by the Angular compiler (ngc) during build time. That's why you don't want TypeScript to try to compile the `main.aot.ts` file and fail. You can exclude it from compilation by configuring your `tsconfig.json`:

不过，即使这样，`./app.module.ngfactory`文件依然不存在。它只存在于NativeScript Angular编译器(ngc)在打包时的内存中。因此，为了避免失败，TypeScript不应该编译`main.aot.ts`文件，在`tsconfig.json`中配置好TypeScript排除掉的文件。

```ts
// tsconfig.json
{
    "compilerOptions": {
    ...
    },
    "exclude": [
        ...
        "app/main.aot.ts"
    ]
}

```

PS: If you created your project with `tns create AppName --ng`, it will already be prepared for Ahead-of-Time compilation.

PS： `tns create AppName --ng`命令创建的项目中预编译功能已经集成好了。

### Bundling Extra Assets

### 打包额外资源

The default webpack configuration tries to copy certain files to your app folder:

默认的Webpack配置会把一些特定的文件直接复制到应用文件夹下：

- HTML/XML markup files.

- HTML／XML等置标语言文件

- App/theme CSS files.

- App／主题 的CSS文件

- Images: png/jpg/etc.

- 图片：png、jpg等等。

If you need other files bundled with your app, find the `CopyWebpackPlugin` configuration in `webpack.config.js`, and add a new config:

如果需要复制其他文件，可以在`webpack.config.js`中的`CopyWebpackPlugin`中配置，添加新的选项：

```JavaScript
new CopyWebpackPlugin([
    ...
    {from: "**/*.pdf"},
    ...
], {ignore: ["App_Resources/**"]}),

```

## Advanced Optimizations

## 优化进阶

### Uglify.js

### Uglify压缩

The webpack configuration includes the `uglifyjs-webpack-plugin`(https://github.com/webpack-contrib/uglifyjs-webpack-plugin). The plugin performs code minification and improves the size of the bundle.

Webpack的配置还包括了`uglifyjs-webpack-plugin`(https://github.com/webpack-contrib/uglifyjs-webpack-plugin)。该插件能够精简代码，减小应用包的体积。

That plugin is disabled by default because it slows down the building process. You can enable it by providing the `--uglify` flag to the bundling command. Example usage:

默认情况下，由于会减缓打包过程，该插件并不启用。可以在打包命令中添加参数`--uglify`来启用它。正如：

```
$ npm run build-android-bundle --uglify

```

or, if you are building for release:

或者，打包一个发行用的应用包：

```
$ npm run build-ios-bundle --uglify -- --release --forDevice --teamId TEAM_ID
```

### V8 Heap Snapshot

### V8堆快照

The webpack configuration also includes the [`NativeScriptSnapshotPlugin`](https://github.com/NativeScript/nativescript-dev-webpack/blob/master/plugins/NativeScriptSnapshotPlugin.js). The plugin loads a single webpack bundle in an empty V8 context, aka snapshotted context, and after its execution, captures a snapshot of the produced V8 heap and saves it in a blob file. Next the blob file is included in the apk bundle and [is loaded by the Android Runtime](https://docs.nativescript.org/runtimes/android/advanced-topics/V8-heap-snapshots) on app initialization. This will obviate the need for loading, parsing and executing the script on app startup which can drastically decrease the starting time.

Webpack的配置中也包含了[`NativeScriptSnapshotPlugin`](https://github.com/NativeScript/nativescript-dev-webpack/blob/master/plugins/NativeScriptSnapshotPlugin.js)。该插件会将单独的webpack `bundle`文件倒入到空的`V8`环境中（即快照环境），然后捕获一部分产生的`V8`堆快照，并将这些快照存入一个二进制文件中。在`apk`文件打包时，会将该二进制文件一起打包，并在应用启动时的[安卓运行环境 Android Runtime](https://docs.nativescript.org/runtimes/android/advanced-topics/V8-heap-snapshots)中使用。这样的策略能够省去应用启动是加载、解析、执行脚本文件的步骤，因此大幅度降低了启动时间。

To include the `NativeScriptSnapshotPlugin` in already existing webpack configuration regenerate your `webpack.config.js` or use the `update-ns-webpack` script to update it:

为了将`NativeScriptSnapshotPlugin`引入到已有的webpack配置文件，需要重新生成`webpack.config.js`文件，或者运行脚本`update-ns-webpack`来更新它：

```
$ ./node_modules/.bin/update-ns-webpack
$ npm install
```

Once you have updated your `webpack.config.js`, you can enable the feature by providing the `--snapshot` flag to the bundling command:

在`webpack.config.js`更新完成后，就可以在打包时添加`--snapshot`参数来使用堆快照特性了。

```
$ npm run start-android-bundle --snapshot

```

Snapshot generation can be used in combination with uglify (`--uglify`) which will result in smaller heap size.

快照功能和压缩功能(`--uglify`)一起使用，这会使得堆的体积更小。

Known limitations:

已知的限制：

* No iOS support. Heap snapshot is a V8 feature which is the engine used in the Android Runtime. Providing `--snapshot` flag on the iOS bundling commands will have no effect.

* 不支持iOS。堆快照功能是`V8引擎`在安卓运行环境中的一个特性。在iOS打包时，即使输入了`--snapshot`参数也不会对打包过程产生影响。

* No Windows support. Providing `--snapshot` flag on the Android bundling command will have no effect on Windows machine.

* 不支持Windows。在装了Windows系统的电脑中，安卓打包时输入`--snapshot`也不会对打包过程产生影响。

* Only one webpack bundle can be snapshotted. By default, this is the `vendor` bundle because in most of the cases it is the largest one.

* 只有Webpack的`bundle`文件才会被进行快照。默认情况下，通常只有体积较大的`vendor bundle`会被进行快照。

#### NativeScriptSnapshotPlugin configuration

#### 配置NativeScriptSnapshotPlugin

The `NativeScriptSnapshotPlugin` by default comes with the following configuration:

`NativeScriptSnapshotPlugin`在使用时的默认配置如下：

```
if (env.snapshot) {
    plugins.push(new nsWebpack.NativeScriptSnapshotPlugin({
        chunk: "vendor",
        projectRoot: __dirname,
        webpackConfig: config,
        targetArchs: ["arm", "arm64", "ia32"],
        tnsJavaClassesOptions: { packages: ["tns-core-modules" ] },
        useLibs: false
    }));
}
```

* `chunk` - the name of the chunk to be snapshotted

* `chunk` - 将要被进行快照的`chunk`文件名

* `projectRoot` - path to the app root folder

* `projectRoot` - 应用根目录所在路径

* `webpackConfig` - Webpack configurations object. The snapshot generation modifies the webpack config object to ensure that the specified bundle will be snapshotted successfully

* `webpackConfig` - Webpack的配置对象. 快照的生成过程会修改webpack的配置对象，以保证特定的`bundle`文件能被正确的捕捉快照

* `targetArchs` - Since the serialization format of the V8 heap is architecture-specific we need a different blob file for each V8 library target architecture. The Android Runtime library contains 3 architecture slices - `ia32` (for emulators), `arm` and `arm64` (for devices). However, [if not explicitly specified](https://github.com/NativeScript/android-runtime/issues/614), the `arm` slice will be used even on `arm64` devices. In other words, generating heap snapshot for all supported architectures (`arm`, `arm64`, `ia32`) will guarantee that the snapshotted heap will be available on every device/emulator. However, when building for release you can leave only `arm` (and `arm64` in case you have [explicitly enabled `arm64` support](https://github.com/NativeScript/android-runtime/issues/614)) in the `targetArchs` array which will decrease the size of the produced APK file.

* `targetArchs` - `V8`堆的序列化格式跟生成目标的`architecture`有关，因此对于不同的目标需要不同形式的二进制文件存储堆快照。安卓运行环境包含3种不同的`architecture`切片 —— 用于模拟器的`ia32`， 和用于真机设备的`arm`和`arm64`。 不过，[不指定`architecture`时](https://github.com/NativeScript/android-runtime/issues/614), `arm`切片会在`arm64`的设备上运行。换言之，为所有支持的`architectures`即 (`arm`, `arm64`, `ia32`)生成对应的堆快照，能保证这些快照在所有的设备甚至模拟器上正常工作。 另外，针对发行版本，只保留`arm`就足够用了，(而且万一需要[支持一些`arm64`设备](https://github.com/NativeScript/android-runtime/issues/614)时在属性`targetArchs`中添加上`arm64`参数就可以了减小产生的APK文件。

* `tnsJavaClassesOptions` - Basically, every Java class successor, declared in NativeScript, consists of two parts - native Java part generated by the [static binding generator](https://www.nativescript.org/blog/static-binding-generator---what-is-it-good-for) and JavaScript counterpart, created when the [JavaScript extending](https://docs.nativescript.org/runtimes/android/generator/extend-class-interface#classes) is evaluated. Both parts must be loaded in order to instantiate the class. The native Java definition is compiled with the app, so it is loaded by the JVM without requiring any additional work. Since the JavaScript counterpart is created by [the extend function](https://docs.nativescript.org/runtimes/android/generator/how-extend-works#the-extend-function) we should make sure that it is evaluated before using the successor class. This is not a concern, when the class is instantiated from JavaScript, because its constructor is created by the `extend` function call, which means that there is no way to refer to the extended class without having the `extend` call executed beforehand. However, there are classes defined in JavaScript that are instantiated from native code. For example, the `NativeScriptActivity` class defined in `ui/frame/activity` is instantiated on app startup by the system. When bundling is disabled, such cases are handled by the Android runtime in the following way:

* `tnsJavaClassesOptions` - 通常情况下，NativeScript中每个Java的继承类都由两部分组成，一部分是原来的Java类部分，由[静态绑定生成器static binding generator](https://www.nativescript.org/blog/static-binding-generator---what-is-it-good-for)实现，另一部分则是JavaScript配位部分，由[JavaScript](https://docs.nativescript.org/runtimes/android/generator/extend-class-interface#classes)扩展而来。两部分需要一起加载后才能实例化一个类。原生的Java类声明和应用一起编译，由Java虚拟机直接加载，并没有过程。而JavaScript配位内容的生成依赖[扩展函数](https://docs.nativescript.org/runtimes/android/generator/how-extend-works#the-extend-function)，因此，需要确保它已经加载完成，然后才能在JavaScript中使用Java继承类。不过这不是需要关心的重点，因为当某个类在JavaScript中实例化时，它构造函数就已经由`extend`函数调用而生成，这种方式意味着不可能在`extend`函数调用之前就引用继承类。此外，在JavaScript中有一些类是直接从原生代码中实例化而来的。例如，`ui/frame/activity`中的`NativeScriptActivity`类就是在应用启动时由系统实例化生成。当webpack的`bundling`被禁用时，安卓运行环境是这么处理这些情形的：

    1. The static binding generator saves the path to the file containing its JavaScript implementation in the class metadata.

    1. 静态绑定生成器将这些类的JavaScript实现文件的路径保存到这个类的`metadata`属性中。

    2. Before instantiating the class, the runtime loads and executes the module at the path saved in the metadata, assuming that this will evaluate the class extending code.

    2. 在类的实例化之前，运行环境加载病运行类`metadata`属性中的文件/模块，这步会执行类的扩展代码`extending code`。

    When bundling with Webpack, the saved path in the metadata always points to the bundle script. However, depending on configurations, executing the bundle script may not evaluate the module containing the Java class definition. Therefore, instead of relying on the Android runtime mechanism to automatically load the JavaScript counterparts we load them on startup by explicitly adding `require` calls to such modules in our default `app/vendor-platform.android` module:

    在webpack的打包时，类的`metadata`属性中保存的文件路径总是指向一个`bundle`文件。不过，根据配置不同，运行这个`bundle`文件并不会执行包含类声明的扩展模块。因此为了确保模块加载的完整，与其依赖安卓运行环境的机制让其自动加载JavaScript的配位模块，不如在`app/vendor-paltform.android`模块中明确声明这些模块的引用：

    ```
    require("application");
    if (!global["__snapshot"]) {
        /*
        In case snapshot generation is enabled these modules will get into the bundle but will not be required/evaluated.
        The snapshot webpack plugin will add them to the tns-java-classes.js bundle file. This way, they will be evaluated on app start as early as possible.
        */
        require("ui/frame");
        require("ui/frame/activity");
    }
    ```

    However, when we add the V8 heap snapshot in the whole story, we are not allowed to extend native classes in snapshotted context. Therefore, we always include `ui/frame` and `ui/frame/activity` in the bundle but when snapshot is enabled they are not evaluated. Here is where the `tns-java-classes.js` file comes into play. Just after initialization, the Android runtime [will evaluate the script at `app/tns-java-classes.js` path if such exists](https://github.com/NativeScript/android-runtime/commit/d13189e4206b374142dc61d309d5aa708fb8095f). The snapshot generator creates such file and populates it with `require` calls to a user defined list of paths. This way, they are explicitly evaluated on app startup. You can add paths to be `require`-d in `tns-java-classes.js` like this:

    V8的堆快照功能的引入并没有使得在快照环境中扩展原生的Java类成为可能。通常的做法是在快照功能启用的情况下，`bundle`中声明`ui/frame`和`ui/frame/activity`。此时就需要`tns-java-classes.js`文件。在应用启动后？，安卓运行环境会[检测`app/tns-java-classes.js`文件存在并尝试执行它](https://github.com/NativeScript/android-runtime/commit/d13189e4206b374142dc61d309d5aa708fb8095f)。快照生成器会生成这个文件，并根据用户定义的引用模块路径写入一系列的`require`调用。在应用启动时，引用模块就是通过这种方式被加载和执行的。可以像下面的方式在`tns-java-classes.js`文件中添加引用的模块路径：

    ```
    new nsWebpack.NativeScriptSnapshotPlugin({
        ...
        tnsJavaClassesOptions: { modules: ["path/to/file1.js", "path-to-module", "path/to/other-script"] }
        ...
    });
    ```
    If you are a plugin author and your plugin contains a module that have to be listed here, you can specify it in your plugin's `package.json` file:

    对于插件开发者而言，当插件中包含一些特定模块时，需要在插件的`package.json`文件中明确列出引用模块：

    ```
    "snapshot": {
        "android": {
            "tns-java-classes": {
            "modules": ["ui/frame/activity", "ui/frame/fragment"]
            }
        }
    }
    ```
     This gives the opportunity to the plugin's clients to add all needed paths in their `tns-java-classes.js` file only by specifying the name of your package:

    这样对于插件的使用者来说只需要在`tns-java-classes.js`文件中声明所用的插件名字即可： 

    ```
    new nsWebpack.NativeScriptSnapshotPlugin({
        ...
        tnsJavaClassesOptions: { packages: ["my-package" ] }
        ...
    });
    ```

#### Checking if snapshot is enabled

#### 检查快照功能是否启用

If you want to toggle whether specific logic is executed only in snapshotted context you can use the `global.__snapshot` flag. Its value is `true` only if the current execution happens in the snapshotted context. Once the app is deployed on the device, the value of the flag is changed to `false`. There is also `global.__snapshotEnabled` flag. Its only difference compared to `global.__snapshot` is that its value is `true` in both snapshotted and runtime contexts, given that snapshot generation is enabled.

当遇到需要某些仅在快照环境下才执行的逻辑功能的场景时，可以通过`global.__snapshot`参数来进行判定。当`global.__snapshot`的值为`true`时，当前的执行环境就是快照环境。当应用在真机设备上运行时，`global.__snapshot`的值就变成了`false`。此外，还有参数`global.__snapshotEnabled`，两者之间的区别在于`global.__snapshotEnabled`在快照已经生成的情况下，它的值快照环境和运行环境均为`true`。

```
function logMessage(message) {
    if (global.__snapshotEnabled) {
        if (!global.__snapshot) {
            console.log("The current execution is happening in runtime context when we have all {N} APIs available, including console.log, so this line of code won't fail.");
        }
        console.log("This will fail if logMessage is called in snapshotted context because console.log is not available there.");
    }
}
```

#### Using snapshot without Webpack

#### 非Webpack环境下的快照使用

The `nativescript-dev-webpack` plugin adds `generate-android-snapshot` npm script in the app's `package.json` file. The command will check if `__snapshot.js` file exists in the app root folder and will generate and install blob files using the file as input. Make sure you have prepared the android platform beforehand, because a subsequent prepare will clear some installed artefacts. This is how V8 heap snapshot can be generated from a single file, without using Webpack bundling. However, generating snapshot from something different than a Webpack bundle is not a common scenario. Packing all scripts into one fat bundle in advance, is what makes the snapshot so beneficial. Generating snapshot for a single script only will rarely have some notable effect on the app performance.

`nativescript-dev-webpack`插件会在根目录下的`package.json`文件中添加一条`npm`脚本语句`generate-android-snapshot`。这条命令会检查根目录下是否含有`__snapshot.js`文件，并且将根据该文件的内容来生成及安装`snapshot`二进制文件。应当先确保安卓平台已经配置完成，因为后续的配置过程会清除掉一些已安装的`artefacts`？。上述过程就是V8虚拟机在没有Webpack打包的情况下如何根据单个文件生成堆快照。然而，从非Webpack的`bundle文件`中生成快照的过程并不常见。将所有代码打包进一个文件，并且根据这个文件进行快照，这样能尽可能享受堆快照功能带来的益处。仅仅从单个脚本文件生成堆快照并不会显著地提升应用性能。

## Debugging Common Errors

## 常见错误调试

Webpack bundling can fail for different reasons. It sometimes fails to resolve certain modules, or it generates code that breaks at runtime. We'll try to cover a few common failure reasons with steps to resolve them in the following sections.

Webpack打包过程的失败原因是多种多样的，有时候是因为没能正确的解析一些模块，有时候则是因为运行环境中的代码运行错误。下面的文章会简单的对失败原因进行分析并提供一些解决办法。

### Dynamic Imports

### 动态引入

A significant drawback to using bundled code is that you have to know the names of all imported modules in advance at bundle time. That means code using variables and passing them to `require` will not work:

一个显著的缺点就是需要在打包之前就要知道`bundle`代码中将要使用的模块的名字，这意味着`require`的语句会失效：

```JavaScript
// THROWS AN ERROR!
require(myPlugin);
```

You can solve this if you have a known set of resolvable modules and you need to switch between them by registering those so that webpack discovers them. You do that by adding a set of `global.registerModule` calls to your application bootstrap code (or some other module that is discovered by webpack when traversing the module import graph):

如果预先知道可引用的模块名字并且在webpack中注册，那么上述问题就迎刃而解。因此需要通过在`bootstrap`代码中多次调用`global.registerModule`方法来注册多个模块：

```JavaScript
require("globals");
global.registerModule("my-plugin", function() { return require("my-plugin"); });
```

Then you will be able to import this module using the `global.loadModule` API:

这样之后就可以用`global.loadModule`方法来引入相应模块：

```JavaScript
const myPlugin = "my-plugin";
//...
global.loadModule(myPlugin);
```

### Passing extra flags

### 额外参数

Webpack may not show all error details by default, but you can always enable that by passing the `--display-error-details` [configuration option](https://webpack.js.org/api/cli/#stats-options). You can manually invoke the webpack tool, and pass the extra options using the same `--` trick we mentioned above:

默认情况下，Webpack不会显示所有的错误细节。[配置选项](https://webpack.js.org/api/cli/#stats-options)中的`--display-error-details`参数能使得在打包过程中显示错误细节。当然也可以在webpack工具中手动调用，就像之前一样使用`--`就可以了：

```
$ npm run start-android-bundle -- --display-error-details
```

Note that the above command will not run a full build. Use it only to run the webpack process manually and troubleshoot failed builds.

注意，上面的命令不会进行一次完整的打包过程。当需要手动进行webpack打包过程或者打包错误后调试使用。

Other options that can be useful when diagnosing a problem are: `--display-modules`, `--display-reasons`, `--display-chunks`.

错误调试时可能用到的参数有：`--display-modules`, `--display-reasons`, `--display-chunks`。

### Inspecting Bundles

### 检查生成的Bundle文件

Bundles are generated in the platform output folders. Look for the `bundle.js` and `tns-bundle.js` files in your `platforms/android/...` and `platforms/ios/...` "app" folders. You could change the destination directory by editing your configuration.

You could also rely on webpack analysis and visualization plugins that can help you diagnoze bundle problems and reduce bundle size. The default webpack configuration includes the `webpack-bundle-analyzer` plugin.

When you build your project, the analyzer plugin will generate a `report` directory in the app root, which contains two files - `${platform}-report.html` and `${platform}-stats.json`. You can open the html in any web browser and inspect the generated bundles.

![Android report](../img/webpack/android-report.png)

For analyzing the dependency graph between the modules, you can use [webpack.github.ui/analyse](http://webpack.github.io/analyse/) and open the `${platform}-stats.json` file.

## Recommendations for Plugin Authors

## 给插件作者的一些建议

Most third party packages are problem free, and get picked up by webpack without any issues. Some libraries though require a bit of tweaking. When you encounter a library that does not get recognized by your webpack configuration, please open up an issue on that library's GitHub repository.

大多数第三方插件都是没有问题的，而且能在webpack中引用时不出差错。不过有些插件可能需要做一点小小的改动。在使用某个插件时遇到无法正确在webpack中进行配置的时候，请到相应的GitHub仓库提出一个`issue`。

### Referencing Platform-specific modules from "package.json"

### 从"package.json"中引用与平台相关的模块

This is the most common problem with third party plugins. Most plugins provide two platform-specific implementations stored in modules named like `my-plugin.android.js` and `my-plugin.ios.js`. The `package.json` file for the plugin looks like this:

对于大多数第三方插件来说，这个问题是最常见的。大多数插件对于iOS和Android两个平台都会提供不同的实现过程，并且存储在命名情况类似于`my-plugin.android.js`或者`my-plugin.ios.js`。因此插件的`package.json`文件可能会像下面：

```JSON
{
    "main": "my-plugin.js"
}
```

Webpack will read the `package.json` file and try to find a `my-plugin.js` module and will fail. The correct way to reference a platform-specific module would be to remove the `.js` extension:

Webpack会读取`package.json`文件，试图找到`my-plugin.js`模块，这样会导致失败。因此，正确的引用一个与运行平台相关的模块应该去掉`.js`扩展名，如下：

```JSON
{
    "main": "my-plugin"
}
```

That will allow webpack to correctly reference `my-plugin.android.js` or `my-plugin.ios.js`.

这些配置能够使得webpack正确的引用到`my-plugin.android.js`或者`my-plugin.ios.js`。

### Emitting Helper Functions in TypeScript Plugins

### TypeScript插件中的帮助函数

The TypeScript compiler implements class inheritance, decorators and other features using a set of helper functions that get emitted at compile time. NativeScript ships with its own implementations of those helpers to allow features like extending platform native classes. That is why plugin authors need to configure their compiler **NOT** to emit helpers. The easiest way is to edit the `tsconfig.json` file and set the `noEmitHelpers` option to `true`:

TypeScript编译器中在实现类的继承、装饰器等其他特性时，借助了一系列帮助函数，这些函数在编译的时候会冒泡事件。NativeScript在扩展平台原生类的时候，对于这些帮助函数有自己的实现过程。因此插件作者需要在他们的编译器选项中设定不允许冒泡这些帮助函数。最简单的方式就是在`tsconfig.json`文件中设置属性`noEmitHelper`的值为`true`：

```JSON
{
    "compilerOptions": {
        ...
        "noEmitHelpers": true,
        ...
    },
    ...
}
```


## Webpack Resources

## Webpack相关文档

Bundling JavaScript code can get complex quickly, and encountering webpack for the first time can be daunting. A full introduction to webpack and related technologies is beyond the scope of this article, and we recommend the following resources:

打包Javascript代码很容易就变得复杂，第一次使用webpack时可能会让人望而却步。对于webpack的全面介绍和相关使用技巧不是本文的重点，可以参考阅读以下文档：

* [Introduction](https://webpack.js.org/guides/getting-started/)

* [简介](https://webpack.js.org/guides/getting-started/) 

* [Tutorial](https://webpack.js.org/concepts/)

* [教程](https://webpack.js.org/concepts/)

* [Webpack CLI Reference](https://webpack.js.org/api/cli/#components/sidebar/sidebar.jsx)

* [Webpack CLI文档](https://webpack.js.org/api/cli/#components/sidebar/sidebar.jsx)

## Showcase apps

## 示例应用

Apps using the nativescript-dev-webpack plugin:

使用`nativescript-dev-webpack`的示例应用：

* [Groceries](https://github.com/NativeScript/sample-Groceries)
* [NativeScript SDK Examples](https://github.com/NativeScript/nativescript-sdk-examples-ng)
* [NativeScript-UI SDK Examples](https://github.com/telerik/nativescript-ui-samples-angular)
* [Cosmos Databank](https://github.com/NickIliev/NativeScript-Cosmos-Databank)
* [Tests app NG](https://github.com/NativeScript/tests-app-ng)
