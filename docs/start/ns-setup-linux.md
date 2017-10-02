---
title: NativeScript Advanced Setup—Linux
description: Configure your Linux system to create, develop and build projects locally with NativeScript.
position: 50
slug: linux
publish: false
previous_url: /setup/ns-cli-setup/ns-setup-linux
---

# NativeScript Advanced Setup: Linux

# NativeScript高级设置：Linux

This page contains a list of all system requirements needed to build and run NativeScript apps on Linux, as well as a guided walkthrough for getting these requirements in place.

本页将给出在Linux平台构建运行NativeScript应用所需的全部系统要求，并引导读者完成设置。

* [System Requirements](#system-requirements)

  [系统要求](#system-requirements)

* [Advanced Setup Steps](#advanced-setup-steps)

  [高级设置步骤](#advanced-setup-steps)

> **NOTE**: On Linux systems you can only use the NativeScript CLI to develop Android apps. This is because the NativeScript CLI uses Xcode to build iOS apps, which is only available on the macOS operating system. If you’re interested in building iOS apps on Linux, you may want to try out the public preview of [NativeScript Sidekick](https://www.nativescript.org/nativescript-sidekick). NativeScript Sidekick provides robust tooling for NativeScript apps, including a service that performs iOS and Android builds in the cloud, removing the need to complete these system requirements, and allowing you to build for iOS on Linux.

> **备注**：在Linux系统下使用NativeScript CLI只能开发安卓应用。这是因为NativeScript CLI使用了Xcode构建iOS应用，而Xcode是macOS操作系统独有的。如希望在Linux平台开发iOS应用，您可尝试公开预览版的[NativeScript Sidekick](https://www.nativescript.org/nativescript-sidekick)。 NativeScript Sidekick针对NativeScript应用提供了强大的构建工具，包括一项在云端进行iOS和安卓应用开发的服务，您无需完成这些配置要求即可进行开发，且允许您在Linux平台进行iOS开发。

## System Requirements

## 系统要求

* Ubuntu 14.04 LTS

* The latest stable official release of Node.js (LTS) [6.x](https://nodejs.org/dist/latest-v6.x/)

  Node.js [6.x](https://nodejs.org/dist/latest-v6.x/)的最新稳定正式版本 (LTS)

* G++ compiler

  G++编译器

* JDK 8 or a later stable official release

  JDK 8或更新的稳定正式版本

* Android SDK 22 or a later stable official release

  Android SDK 22或更新的稳定正式版本

* Android Support Repository

* (Optional) Google Repository

  （可选项）Google Repository

* Android SDK Build-tools 25.0.2 or a later stable official release

  Android SDK Build-tools 25.0.2或更新的稳定正式版本

You must also have the following two environment variables setup for Android development:

对于安卓开发，还必须设置以下两个环境变量：

* JAVA_HOME
* ANDROID_HOME

## Advanced Setup Steps

## 高级设置步骤

Complete the following steps to set up NativeScript on your Linux development machine:

跟随下列步骤，在您的Linux开发机上完成NativeScript的设置：

1. Install the latest Node.js [6.x](https://nodejs.org/dist/latest-v6.x/) or [7.x](https://nodejs.org/dist/latest-v7.x/) stable official release. We recommend using Node.js v6.x.

    安装Node.js [6.x](https://nodejs.org/dist/latest-v6.x/)或[7.x](https://nodejs.org/dist/latest-v7.x/)的最新稳定正式版本。推荐使用Node.js v6.x。

1. If you are running on a 64-bit system, install the runtime libraries for the ia32/i386 architecture.
   
   如您使用的是64位系统，请运行以下命令安装ia32/i386架构的运行时库。

    <pre class="add-copy-button"><code class="language-terminal">sudo apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0 libstdc++6:i386
    </code></pre>

    If you encounter an error showing "Unable to locate package lib32bz2-1.0" then use

    如出现错误"Unable to locate package lib32bz2-1.0"，请使用以下命令

    <pre class="add-copy-button"><code class="language-terminal">sudo apt-get install lib32z1 lib32ncurses5 libbz2-1.0:i386 libstdc++6:i386
    </code></pre>

1. Install the G++ compiler.

   安装G++编译器。

    <pre class="add-copy-button"><code class="language-terminal">sudo apt-get install g++
    </code></pre>

1. Install [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html) or a later stable official release.
   
   安装[JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html)或更新的稳定正式版本

    1. Run the following commands.

       运行以下命令。

        <pre class="add-copy-button"><code class="language-terminal">sudo apt-get install python-software-properties
        sudo add-apt-repository ppa:webupd8team/java
        sudo apt-get update
        sudo apt-get install oracle-java8-installer
        </code></pre>

    1. After installation if you have multiple installations of java you can choose which to use:

       安装之后，如果您安装了多个版本的Java，您可运行以下命令选择需要使用的版本：

        <pre class="add-copy-button"><code class="language-terminal">sudo update-alternatives --config java
        </code></pre>

    1. Set the JAVA_HOME system environment variable.

       设置JAVA_HOME系统环境变量。

        <pre class="add-copy-button"><code class="language-terminal">export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')
        </code></pre>

1. Install the [Android SDK](http://developer.android.com/sdk/index.html).

    安装[Android SDK](http://developer.android.com/sdk/index.html)。

    1. Go to [Android Studio and SDK Downloads](https://developer.android.com/sdk/index.html#Other) and in the **SDK Tools Only** section download the package for Linux at the bottom of the page.

       访问[Android Studio和SDK下载](https://developer.android.com/sdk/index.html#Other)，在**SDK Tools Only**部分的页面底部下载Linux的安装包。

    1. After the download completes, unpack the downloaded archive.

       下载完成后，解压下载文件。

    1. Set the ANDROID_HOME system environment variable.

       设置ANDROID_HOME系统环境变量。

        <pre><code class="language-terminal">export ANDROID_HOME=Path to Android installation directory
        </code></pre>
        For example: ANDROID_HOME=/android/sdk

        例如：ANDROID_HOME=/android/sdk

        <blockquote><b>NOTE</b>: This is the directory that contains the <code>tools</code> and <code>platform-tools</code> directories.</blockquote>

        <blockquote><b>备注</b>：这里所使用的路径下应包含<code>tools</code>和<code>platform-tools</code>路径。</blockquote>        

1. Install all packages for the Android SDK Platform 25, Android SDK Build-Tools 25.0.2 or later, Android Support Repository, Google Repository and any other SDKs that you may need. You can alternatively use the following command, which will install all required packages.

    为Android SDK Platform 25、Android SDK Build-Tools 25.0.2（或更新版本）、Android Support Repository、Google Repository以及其他SDK安装所有需要的包。您还可以在命令窗口中输入以下命令，所有依赖包将自动进行安装。

    <pre class="add-copy-button"><code class="language-terminal">sudo $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-25" "build-tools;25.0.2" "extras;android;m2repository" "extras;google;m2repository"
    </code></pre>

1. Setup Android Emulators (AVD) by following the article [here]({%slug android-emulators%})

   按照[这篇]({%slug android-emulators%})文章中的步骤设置安卓模拟器 (AVD) 

1. Install the NativeScript CLI.

   安装NativeScript CLI。

    1. Run the following command.

       运行以下命令。

    <pre class="add-copy-button"><code class="language-terminal">sudo npm install nativescript -g --unsafe-perm
    </code></pre>

    1. Restart the command prompt.

       重启命令窗口。

1. To check if your system is configured properly, run the following command.

   运行以下命令，检查系统系统是否已经正确配置。

    <pre class="add-copy-button"><code class="language-terminal">tns doctor
    </code></pre>

## What’s Next

## 接下来

* [Return to the JavaScript tutorial](http://docs.nativescript.org/tutorial/chapter-1#11-install-nativescript-and-configure-your-environment)

  [返回JavaScript版教程](http://docs.nativescript.org/tutorial/chapter-1#11-install-nativescript-and-configure-your-environment)  

* [Return to the TypeScript & Angular tutorial](http://docs.nativescript.org/angular/tutorial/ng-chapter-1#11-install-nativescript-and-configure-your-environment)

  [返回TypeScript & Angular版教程](http://docs.nativescript.org/angular/tutorial/ng-chapter-1#11-install-nativescript-and-configure-your-environment)
