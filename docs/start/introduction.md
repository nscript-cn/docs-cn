---
title: Welcome
description: Meet NativeScript - an open-source framework for the cross-platform development of truly native apps.
position: 10
publish: true
slug: introduction
previous_url: /index
---

{% nativescript %}
# Welcome to NativeScript
# 初识 NativeScript

NativeScript is how you build cross-platform, native iOS and Android apps without web views. Use Angular, TypeScript or modern JavaScript to get truly native UI and performance while sharing skills and code with the web. Get 100% access to native APIs via JavaScript and reuse of packages from npm, CocoaPods and Gradle. Open source and backed by Progress.

NativeScript 是一种用来开发iOS和Android应用程序的跨平台技术，它摆脱了Web View的限制。NactiveScript与Web共享同样的技能和代码，同时，还可以通过Angular、TypeScript或者现代JavaScript来生成高性能的原生UI。NativeScript可以访问全部原生API，可以复用网络上大量的npm包、CocoaPods包和Gradle包。NativeScript是个开源项目，由Progress公司维护。

{% endnativescript %}

{% angular %}
# NativeScript with Angular
# 使用Angular
NativeScript doesn’t require Angular, but it’s even better when you use it. You can fully reuse skills and code from the web to build beautiful, high performance native mobile apps without web views. NativeScript features deep integration with Angular, the latest and greatest (and fastest) Angular framework. Open source and backed by Progress.

NativeScript 并不强制要求使用Angular，但如果用Angular则会更好。使用Angular可以复用web开发上的经验和技能，创作漂亮、高性能的原生应用，而不用借助Web View。NativeScript深度集成了Angular（最新，最强，最快的框架），它开源，并持续由Progress更新维护。

{% endangular %}

New to NativeScript? [Try out NativeScript on your phone](https://www.nativescript.org/nativescript-example-application?utm_medium=referral&utm_source=documentation&utm_campaign=getting-started) to see what a truly native app feels like.

如果是NativeScript的新手 [可以在手机上安装NativeScript的样例App](https://www.nativescript.org/nativescript-example-application?utm_medium=referral&utm_source=documentation&utm_campaign=getting-started)，来体验原生应用的效果。

## Get Started

## 快速起步

Ready to get started developing with NativeScript? We offer a set of comprehensive tutorials that walk you through installing NativeScript, and building a real-world iOS and Android app from scratch.

准备用NativeScript进行开发了吗？我们提供了一系列教程，涵盖了如何安装NativeScript以及如何从零开始开发一个完整的ios或者Android app。

<div id="start-button-container">
  <a href="http://docs.nativescript.org/angular/tutorial/ng-chapter-0" class="Btn" id="ng-start-button">快速开始（TypeScript & Angular版）</a>
  <a href="http://docs.nativescript.org/tutorial/chapter-0" class="Btn" id="js-start-button">快速开始（JavaScript版）</a>
</div>

<script>
  // Quick script to randomize the tutorial button order
  var container = document.getElementById("start-button-container");
  var ngButton = document.getElementById("ng-start-button");
  var jsButton = document.getElementById("js-start-button");

  if (Math.floor(Math.random() * 2) == 0) {
    container.insertBefore(jsButton, ngButton);
    ngButton.style.marginTop = "1em";
    ngButton.style.marginBottom = "1em";
  } else {
    jsButton.style.marginTop = "1em";
    jsButton.style.marginBottom = "1em";
  }
</script>

> **NOTE**: NativeScript also lets you use TypeScript _without_ Angular. If you’re interested in this approach, start with [our JavaScript tutorial](http://docs.nativescript.org/tutorial/chapter-0) to familiarize yourself with the basic NativeScript concepts, and then refer to [our TypeScript documentation](https://www.nativescript.org/using-typescript-with-nativescript-when-developing-mobile-apps) for your next steps.

> **注意** 开发NativeScript程序也可以只用TypeScript而*不*用Angular。如果对这种方式感兴趣，可以从[JavaScript教程](http://docs.nativescript.org/tutorial/chapter-0) 开始熟悉NativeScript的基本概念，然后再读一下 [关于TypeScript](https://www.nativescript.org/using-typescript-with-nativescript-when-developing-mobile-apps) 章节的内容，之后就可以进行下一步的程序开发了。

## Join the NativeScript Community
## 加入 NativeScript 社区

We have a vibrant, engaged community and are here to help. You can find us on [Twitter](https://twitter.com/nativescript) and our [community forum](http://forum.nativescript.org/).

NativeScript的社区非常活跃，从这里可以获得各种帮助。请关注我们的
[Twitter](https://twitter.com/nativescript)和官方 [论坛](http://forum.nativescript.org/).

