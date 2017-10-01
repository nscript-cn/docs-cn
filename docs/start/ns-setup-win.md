---
title: NativeScript Advanced Setup—Windows
description: Configure your Windows system to create, develop and build projects locally with NativeScript.
position: 30
slug: windows
publish: false
previous_url: /setup/ns-cli-setup/ns-setup-win
---

# NativeScript Advanced Setup: Windows
# NativeScript高级设置：Windows

This page contains a list of all system requirements needed to build and run NativeScript apps on Windows, as well as a guided walkthrough for getting these requirements in place.

本页将给出在Windows平台构建运行NativeScript应用所需要的全部系统要求，并引导读者完成设置。

* [System Requirements](#system-requirements)
  
  [系统要求](#system-requirements)
* [Advanced Setup Steps](#advanced-setup-steps)
  
  [高级设置步骤](#advanced-setup-steps)

> **NOTE**: On Windows systems you can only use the NativeScript CLI to develop Android apps. This is because the NativeScript CLI uses Xcode to build iOS apps, which is only available on the macOS operating system. If you’re interested in building iOS apps on Windows, you may want to try out the public preview of [NativeScript Sidekick](https://www.nativescript.org/nativescript-sidekick). NativeScript Sidekick provides robust tooling for NativeScript apps, including a service that performs iOS and Android builds in the cloud, removing the need to complete these system requirements, and allowing you to build for iOS on Windows.

> **备注**: 在Windows系统下使用NativeScript CLI只能开发安卓应用。这是因为NativeScript CLI使用了Xcode构建iOS应用，而Xcode是macOS操作系统独有的。如希望在Windows平台开发iOS应用，您可尝试公开预览版的[NativeScript Sidekick](https://www.nativescript.org/nativescript-sidekick)。 NativeScript Sidekick针对NativeScript应用提供了强大的构建工具，包括一项在云端进行iOS和安卓应用开发的服务，您无需完成这些配置要求即可进行开发，且允许您在Windows平台进行iOS开发。

## System Requirements
## 系统要求

* Windows 7 Service Pack 1 or later

  Windows 7 Service Pack 1或更高
* The latest stable official release of Node.js (LTS) [6.x](https://nodejs.org/dist/latest-v6.x/)

  Node.js最新的稳定正式版本 (LTS) [6.x](https://nodejs.org/dist/latest-v6.x/)
* (Optional) Chocolatey to simplify the installation of dependencies

  （可选项）使用Chocolatey简化依赖安装
* JDK 8 or a later stable official release

  JDK 8或更新的稳定正式版本
* Android SDK 22 or a later stable official release

  Android SDK 22或更新的稳定正式版本
* Android Support Repository

  Android Support Repository
* (Optional) Google Repository

  （可选项）Google Repository
* Android SDK Build-tools 25.0.2 or a later stable official release

  Android SDK Build-tools 25.0.2或更新的稳定正式版本
* Set up Android virtual devices to expand your testing options

  设置安卓虚拟设备 (AVD)，以扩展测试选项

You must also have the following two environment variables setup for Android development, which will automatically be added for you as part of the installation:

对于安卓开发，还必须设置以下两个环境变量（安装时将自动添加）：

* JAVA_HOME
* ANDROID_HOME

## Advanced Setup Steps
## 高级设置步骤

Complete the following steps to set up NativeScript on your Windows development machine:
完成下列步骤，在您的Windows开发机上完成NativeScript的设置：

1. Install [Chocolatey](https://chocolatey.org) to simplify the installation and configuration of the requirements.
  安装[Chocolatey](https://chocolatey.org) 以简化安装和配置。
    - Run the command prompt as an Administrator.
    
      以管理员身份运行命令行。
    - Copy and paste the following script in the command prompt.
    
      将以下脚本复制黏贴到命令行中。

        <pre class="add-copy-button"><code class="language-terminal">@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
        </code></pre>
    - Restart the command prompt.
    
      重启命令行。

2. Install the latest Node.js [6.x](https://nodejs.org/dist/latest-v6.x/) or [7.x](https://nodejs.org/dist/latest-v7.x/) stable official release. We recommend using Node.js v4.x.
  安装Node.js[6.x](https://nodejs.org/dist/latest-v6.x/)或[7.x](https://nodejs.org/dist/latest-v7.x/)的最新稳定版本。推荐使用Node.js v4.x。

    - In the command prompt, run the following command.
    
      进入命令行，运行以下命令。

        <pre class="add-copy-button"><code class="language-terminal">choco install nodejs-lts -y
        </code></pre>

3. Install [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html) or a later stable official release.
  
    安装[JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html)或更新版本的JDK
    - In the command prompt, run the following command.
      进入命令行，运行以下命令。

        <pre class="add-copy-button"><code class="language-terminal">choco install jdk8 -y
        </code></pre>

4. Install the [Android SDK](http://developer.android.com/sdk/index.html).
   
    安装[Android SDK](http://developer.android.com/sdk/index.html)。
    - In the command prompt, run the following command.
      进入命令行，运行以下命令。

        <pre class="add-copy-button"><code class="language-terminal">choco install android-sdk -y
        </code></pre>

    - Restart the command prompt.
      重启命令行。

5. Install all packages for the Android SDK Platform 25, Android SDK Build-Tools 25.0.2 or later, Android Support Repository, Google Repository and any other SDKs that you may need. You can alternatively use the following command, which will install all required packages.
  
    为Android SDK Platform 25、Android SDK Build-Tools 25.0.2（或更新版本）、Android Support Repository、Google Repository以及其他SDK安装所有需要的包。您可选择在命令行中输入以下命令，即可完成所有依赖包的安装。

    <pre class="add-copy-button"><code class="language-terminal">"%ANDROID_HOME%\tools\bin\sdkmanager" "tools" "platform-tools" "platforms;android-25" "build-tools;25.0.2" "extras;android;m2repository" "extras;google;m2repository"
    </code></pre>

6. Install Android virtual devices (AVDs)
   安装安卓虚拟设备 (AVD)
    - Go to [Setup Android emulators](https://docs.nativescript.org/tooling/android-virtual-devices)
      
      访问[Setup Android emulators](https://docs.nativescript.org/tooling/android-virtual-devices)
    - Follow the steps to create and start AVD with enabled HAXM.
      
      跟随教程步骤创建并启动AVD

    Alternatively a [Visual Studio Emulator for Android](https://www.visualstudio.com/vs/msft-android-emulator/) can be used.
    
    您也可选用[Visual Studio安卓模拟器](https://www.visualstudio.com/vs/msft-android-emulator/)。 

7. Install the NativeScript CLI.
   
   安装NativeScript CLI。
    - Run the following command.
      
      运行以下命令。

        <pre class="add-copy-button"><code class="language-terminal">npm i -g nativescript
        </code></pre>

    - Restart the command prompt.
      
      重启命令行。

8. To check if your system is configured properly, run the following command.
   
   运行以下命令，检查系统系统是否已经正确配置。

    <pre class="add-copy-button"><code class="language-terminal">tns doctor
    </code></pre>

## What’s Next
## 接下来

* [Return to the JavaScript tutorial](http://docs.nativescript.org/tutorial/chapter-1#11-install-nativescript-and-configure-your-environment)
  
  [返回JavaScript版文档](http://docs.nativescript.org/tutorial/chapter-1#11-install-nativescript-and-configure-your-environment)
* [Return to the TypeScript & Angular tutorial](http://docs.nativescript.org/angular/tutorial/ng-chapter-1#11-install-nativescript-and-configure-your-environment)
  
  [返回TypeScript & Angular版文档](http://docs.nativescript.org/angular/tutorial/ng-chapter-1#11-install-nativescript-and-configure-your-environment)
