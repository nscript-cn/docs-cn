---
title: Application Architecture
description: Learn the basic application structure of NativeScript apps and how to navigate inside your app.
position: 20
slug: architecture
previous_url: /navigation
environment: nativescript
---

# Architecture and Navigation

# 架构和导航

NativeScript apps consist of pages that represent the separate application screens. Pages are instances of the [`page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) class of the [`Page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) module. To navigate between pages, you can use the methods of the [`Frame`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) class of the [`Frame`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) module.

NativeScript 应用由代表着不同屏幕的页面组成。页面是 [`Page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) 模块中 [`page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) 类的实例。我们可以使用 [`Frame`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) 模块中 [`Frama`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) 类的各种方法来在各个页面之间导航。

> **TIP:** Instead of multiple pages, you can have a single page with a [tab view](http://docs.nativescript.org/api-reference/classes/_ui_tab_view_.tabview.html) and different user interfaces for each tab.

> **提示:** 相较于多页应用，我们可以创建一个拥有多个[标签视图](http://docs.nativescript.org/api-reference/classes/_ui_tab_view_.tabview.html)的单页应用，每个标签展示不同的用户界面。
* [Page management](#page-management)  
  [页面管理](#page-management)
    * [Define page](#define-page)  
      [定义页面](#define-page)
    * [Set home page](#set-home-page)  
      [设置主页](#set-home-page)
* [Navigation](#navigation)  
  [导航](#navigation)
    * [The topmost frame](#the-topmost-frame)  
      [顶层帧](#the-topmost-frame)
    * [Navigate by page name](#navigate-by-page-name)  
      [使用页面名称导航](#navigate-by-page-name)
    * [Navigate using a function](#navigate-using-a-function)  
      [使用函数导航](#navigate-using-a-function)
    * [Navigate and pass context](#navigate-and-pass-context)  
      [导航并传递上下文](#navigate-and-pass-context)
    * [Navigate and set bindingContext to the page](#navigate-and-set-bindingcontext-to-the-page)  
      [导航并设置页面的绑定上下文](#navigate-and-set-bindingcontext-to-the-page)
    * [Navigate without history](#navigate-without-history)  
      [无历史导航](#navigate-without-history)
    * [Clear history](#clear-history)   
      [清除历史](#clear-history)
    * [Navigation transitions](#navigation-transitions)  
      [导航过渡](#navigation-transitions)
    * [Navigate back](#navigate-back)  
      [导航返回](#navigate-back)
    * [Modal pages](#modal-pages)  
      [模态页](#modal-pages)
* [Supporting multiple screens](#supporting-multiple-screens)  
  [多屏幕支持](#supporting-multiple-screens)
    * [Screen size qualifiers](#screen-size-qualifiers)  
      [屏幕限定词](#screen-size-qualifiers)
    * [Platform qualifiers](#platform-qualifiers)  
      [平台限定词](#platform-qualifiers)
    * [Orientation qualifiers](#orientation-qualifiers)  
      [方向限定词](#orientation-qualifiers)

## Page management

## 页面管理

### Define page

### 定义页面

Pages represent the separate screens of your application. Each page is an instance of the [`page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) class of the [`Page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) module. Each class instance inherits the [`content`](http://docs.nativescript.org/api-reference/classes/_ui_content_view_.contentview.html) property which holds the root visual element of the UI.

页面代表应用中不同的屏幕。每个页面是 [`Page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) 模块中 [`page`](http://docs.nativescript.org/api-reference/classes/_ui_page_.page.html) 类的一个实例。
每个实例都继承了 [`content`](http://docs.nativescript.org/api-reference/classes/_ui_content_view_.contentview.html) 属性来储存 UI 元素。

NativeScript provides two approaches to instantiating your pages.

NativeScript 提供了两种方法来实例化页面。  

**Create a page in XML**

**在 XML 中创建页面**

You can define the UI declaration and the code for the page separately.  

我们可以分别定义页面的 UI 信息和逻辑代码。

To apply this approach, create a `XML` file for each page to hold the layout of the page. Thus your code will be in a `JS` or a `TS` file. The names of the `XML` and the `JS` or `TS` file must match.

要想使用这种方法，我们可以为每个页面创建一个 `XML` 文件来储存页面的布局。相应的，页面的代码会储存在一个 `JS` 或 `TS` 文件内。 `XML` 和 `JS` 或 `TS` 文件名称必须相匹配。

### Example 1:  Create page with XML.

### 示例 1: 使用 XML 创建页面

``` XML
<!-- main-page.xml-->
<Page loaded="onPageLoaded">
  <Label text="Hello, world!"/>
</Page>
```
``` JavaScript
// main-page.js
function onPageLoaded(args) {
    console.log("Page Loaded");
}
exports.onPageLoaded = onPageLoaded;
```
``` TypeScript
// main-page.ts
import observableModule from "data/observable";

export function onPageLoaded(args: observableModule.EventData) {
    console.log("Page Loaded");
}
```
**Create a page in code**

**使用代码创建页面

To apply this approach, you need to create a function named `createPage` that will return an instance of your page. NativeScript considers `createPage` a factory function.

要想使用这个方法，我们需要创建一个名为 `createPage` 的函数, 这个函数会返回一个页面的实例。 NativeScript 将 `createPage` 函数视为工厂函数。

### Example 2:  Create page via code.

### 示例 2: 使用代码创建页面。

``` JavaScript
var pagesModule = require("ui/page");
var labelModule = require("ui/label");
function createPage() {
    var label = new labelModule.Label();
    label.text = "Hello, world!";
    var page = new pagesModule.Page();
    page.content = label;
    return page;
}
exports.createPage = createPage;
```
``` TypeScript
import pagesModule from "ui/page";
import labelModule from "ui/label";

export function createPage() {
    var label = new labelModule.Label();
    label.text = "Hello, world!";
    var page = new pagesModule.Page();
    page.content = label;
    return page;
}
```

### Set home page

### 设置主页

Each application must have a single entry point - the home page.

每个应用必须有一个入口 - 主页。

To load the home page for your app, you need to pass `NavigationEntry` with the desired `moduleName` to the start() method.  NativeScript looks for an XML file with the specified name, parses it and draws the UI described in the file. Afterwards, if NativeScript finds a `JS` or a `TS` file with the same name, it executes the business logic in the file.

如要加载应用的主页，我们需用 `NavigationEntry` 向 start() 方法传递 `moduleName`。 NativeScript 将查找具有指定名称的 XML 文件，对其进行解析并绘制文件中描述的 UI。 之后，如果 NativeScript 找到一个名称相同的 `JS` 或 `TS` 文件，它将执行文件中的业务逻辑。

``` JavaScript
var application = require("application");
application.start({ moduleName: "main-page" });
```
``` TypeScript
import application from "application";
application.start({ moduleName: "main-page" });
```

## Navigation

## 导航

The [`Frame`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) class represents the logical unit that is responsible for navigation between different pages. Typically, each app has one frame at the root level - the topmost frame.

`Frame` 类 (帧类) 代表负责在不同页面之间导航的逻辑单元。通常情况下，每个应用有一个根级别的帧 - 顶层帧。

To navigate between pages, you can use the [`navigate`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) method of the topmost frame instance.

如要在页面之间导航，可以使用顶层帧实例的 [`navigate`](http://docs.nativescript.org/api-reference/classes/_ui_frame_.frame.html) 方法。

In addition, each `Page` instance carries information about the frame object which navigated to it in the `frame` property. This lets you navigate with the `frame` property as well. 

此外，每个`Page`实例都有一个`frame`属性用于储存导航信息，我们也可以通过这个`帧`属性进行导航。

### The topmost frame

### 顶层帧

The topmost frame is the root-level container for your app's UI and you can use it to navigate inside of your app. You can get a reference to this frame by using the `topmost()` method of the Frame module.

顶层帧是储存应用 UI 信息的根级容器，可以用来进行应用内的导航。我们可以使用帧模块的 `topmost()`方法获得该帧的用用。

``` JavaScript
var frameModule = require("ui/frame");
var topmost = frameModule.topmost();
```
``` TypeScript
import frameModule from "ui/frame";
var topmost = frameModule.topmost();
```

There are several ways to perform navigation; which one you use depends on the needs of your app.

NativeScript 提供了很多方法进行导航，我们可以根据实际情况选择合适的方法。

### Navigate by page name

### 使用页面名称导航

Perhaps the simplest way to navigate is by specifying the file name of the page to which you want to navigate.

最简单的导航方式是指定要导航到的页面名称。

``` JavaScript
topmost.navigate("details-page");
```
``` TypeScript
topmost.navigate("details-page");
```

### Navigate using a function

### 使用函数导航

A more dynamic way of navigating can be done by providing a function that returns the instance of the page to which you want to navigate.

我们可以通过调用一个返回目标页面实例的函数来进行更灵活的导航。

### Example 3:  How to navigate to a page dynamically created via code.

### 示例 3: 如何导航到动态创建的页面。

``` JavaScript
var factoryFunc = function () {
    var label = new labelModule.Label();
    label.text = "Hello, world!";
    var page = new pagesModule.Page();
    page.content = label;
    return page;
};
topmost.navigate(factoryFunc);
```
``` TypeScript
var topmost = frameModule.topmost();
var factoryFunc = function () {
    var label = new labelModule.Label();
    label.text = "Hello, world!";
    var page = new pagesModule.Page();
    page.content = label;
    return page;
};
topmost.navigate(factoryFunc);
```

### Navigate and pass context

### 导航并传递上下文

When you navigate to another page, you can pass context to the page with a [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) object. This approach provides finer control over navigation compared to other navigation approaches. For example, with `NavigationEntry` you can also animate the navigation.

当导航到另外的页面时，我们可以使用 [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) 对象来传递上下文。相较于其他方法，这个方法能更好地控制导航。比如，通过配置 `NavigationEntry` 来配置导航动画。

### Example 4:  How to pass content between different pages.

### 示例 4:如何在不同页面之间传递内容。

``` JavaScript
var navigationEntry = {
    moduleName: "details-page",
    context: {info: "something you want to pass to your page"},
    animated: false
};
topmost.navigate(navigationEntry);
```
``` TypeScript
var navigationEntry = {
    moduleName: "details-page",
    context: {info: "something you want to pass to your page"},
    animated: false
};
topmost.navigate(navigationEntry);
```

### Navigate and set bindingContext to the page

### 导航并设置绑定上下文

While you are navigating you could set `bindingContext` to a page.

导航时，我们可以设置页面的 `bindingContext`。

### Example 5:  How to provide `bindingContext` automaticlly while navigating to a page.

### 示例 5: 如何在导航时设置 `bindingContext`。

```JavaScript
// To import the "ui/frame" module and "main-view-model":
var frame = require("ui/frame");
var main_view_model = require("./main-view-model");
// Navigate to page called “my-page” and provide "bindingContext"
frame.topmost().navigate({ 
  moduleName: "my-page", 
  bindingContext: new main_view_model.HelloWorldModel() 
});
```
```TypeScript
// To import the "ui/frame" module and "main-view-model":
import {topmost} from "ui/frame";
import {HelloWorldModel} from "./main-view-model"
// Navigate to page called “my-page” and provide "bindingContext"
topmost().navigate({
  moduleName:"my-page", 
  bindingContext:new HelloWorldModel()
});
```

#### Example
### 示例

In this example, this master-details app consists of two pages. The main page contains a list of entities. The details page shows information about the currently selected entity.

示例中的应用由主页和详情页组成。主页包含了一个对象列表，详情页展示了当前所选对象的详细信息。

When you navigate to the details page, you transfer a primary key or ID information about the selected entity. 

当导航到详情页时，需要传入所选对象的主键或 ID 信息。

### Example 6:  Navigate to the details page and pass the content for selected item.

### 实例 6: 导航到详情页并传递所选项目的内容。

``` JavaScript
function listViewItemTap(args) {
    // Navigate to the details page with context set to the data item for specified index
    frames.topmost().navigate({
        moduleName: "cuteness.io/details-page",
        context: appViewModel.redditItems.getItem(args.index)
    });
}
```
``` TypeScript
export function listViewItemTap(args: listView.ItemEventData) {
    // Navigate to the details page with context set to the data item for specified index
    frames.topmost().navigate({
        moduleName: "details-page",
        context: appViewModel.redditItems.getItem(args.index)
    });
}
```

With the **onNavigatedTo** callback, you show the details for the entity.

使用 **onNavigatedTo** 回调函数展示对象的详细信息。

### Example 7:  Bind the content received from main page.

### 示例 7: 绑定从主页接收的内容。

``` JavaScript
function pageNavigatedTo(args) {
    var page = args.object;
    page.bindingContext = page.navigationContext;
}
```
``` TypeScript
// Event handler for Page "navigatedTo" event attached in details-page.xml
export function pageNavigatedTo(args: observable.EventData) {
    // Get the event sender
    var page = <pages.Page>args.object;
    page.bindingContext = page.navigationContext;
}
```

### Navigate without history

### 无历史导航

You can navigate to a page without adding this navigation to the history. Set the `backstackVisible` property of the [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) to `false`. If this property is set to false, then the Page will be displayed, but once navigated from it will not be able to be navigated back to.

导航时可以实现不将此次导航添加到导航历史。如果设置 [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) 的 `backstackVisible` 属性为 `false`， 那么目标页面可以呈现，但一旦离该页面就无法再次返回。

### Example 8:  Page navigation, without saving navigation history.

### 示例 8: 不保存导航历史的页面导航。

``` JavaScript
var navigationEntry = {
    moduleName: "login-page",
    backstackVisible: false
};
topmost.navigate(navigationEntry);
```
``` TypeScript
var navigationEntry = {
    moduleName: "login-page",
    backstackVisible: false
};
topmost.navigate(navigationEntry);
```

### Clear history

### 清除历史

You can navigate to a new page and decide to completely clear the entire navigation history. Set the `clearHistory` property of the [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) to `true`. This will prevent the user from going back to pages previously visited. This is extremely useful if you have a multiple-page authentication process and you want to clear the authentication pages once the user is successfully logged in and redirected to the start page of the application.

导航到新页面时可以决定是否清除所有导航历史。设置 [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) 的 `clearHistory` 属性为 `true`。 这会防止用户返回先前浏览过的页面。如果应用中存在多页面认证的流程，一旦用户成功登陆并重定向到起始页，我们就可以清除认证页的历史记录。

### Example 9:  Prevent user from going back using `clearHistory` property.

### 示例 9:使用 `clearHistory` 属性防止用户返回。

``` JavaScript
var navigationEntry = {
    moduleName: "main-page",
    clearHistory: true
};
topmost.navigate(navigationEntry);
```
``` TypeScript
var navigationEntry = {
    moduleName: "main-page",
    clearHistory: true
};
topmost.navigate(navigationEntry);
```

### Navigation transitions

### 导航过渡

By default, all navigation will be animated and will use the default transition for the respective platform (UINavigationController transitions for iOS and Fragment transitions for Android). To change the transition type, set the `navigationTransition` property of the [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) to an object conforming to the [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) interface.

默认情况下，所有导航都会添加动画效果，并会根据平台使用相应默认过渡效果(iOS 下使用 UINavigationController 过渡，Android 下使用 Fragment 过渡)。如要更改过渡类型，可以把 [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) 的 `navigationTransition` 属性设置为一个继承 [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) 接口的对象。

### Example 10:  Set up a transition property on page navigation.

### 示例 10: 设置页面导航的过渡属性。

``` JavaScript
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transition: {
        name: "slide",
        duration: 380,
        curve: "easeIn"
    }
};
topmost.navigate(navigationEntry);
```
``` TypeScript
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transition: {
        name: "slide",
        duration: 380,
        curve: "easeIn"
    }
};
topmost.navigate(navigationEntry);
```

To use one of the built-in transitions, set the `name` property of the [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) to one of the following:

如要使用内置过渡效果，可以将 [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) 的 `name` 属性设置为下列之一:
 - curl (same as curlUp) (iOS only)  
   卷曲 (与卷起相同) (仅限 iOS)
 - curlUp (iOS only)  
   卷起 (仅限iOS)
 - curlDown (iOS only)  
   卷下 (仅限 iOS)
 - explode (Android Lollipop and later)  
   爆炸 (Andorid Lollipop 及以上)
 - fade  
   渐隐
 - flip (same as flipRight)  
   翻转 (与右翻转相同)
 - flipRight  
   右翻转
 - flipLeft  
   左翻转
 - slide (same as slideLeft)  
   滑动 (与左滑相同)
 - slideLeft  
   左滑
 - slideRight  
   右滑
 - slideTop  
   上滑
 - slideBottom  
   下滑
   
The `duration` property lets you specify the transition duration in milliseconds. If left undefined, the default duration for each platform will be used &mdash; `350` ms for iOS and `300` ms for Android.  
 `duration` 属性允许指定以毫秒为单位的转换持续时间。如果未指定，则将使用每个平台默认的持续时间：iOS下`350`毫秒，Android下`300`毫秒。

The `curve` property lets you specify the animation curve of the transition. Possible values are contained in the [AnimationCurve enumeration](http://docs.nativescript.org/api-reference/modules/_ui_enums_.animationcurve.html). Alternatively, you can pass an instance of type [`UIViewAnimationCurve`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/#//apple_ref/c/tdef/UIViewAnimationCurve) for iOS or [`android.animation.TimeInterpolator`](http://developer.android.com/reference/android/animation/TimeInterpolator.html) for Android. If left undefined, and `easeInOut` curve will be used.  

`curve`属性允许指定过渡的动画曲线。可设定的值可在 [AnimationCurve enumeration](http://docs.nativescript.org/api-reference/modules/_ui_enums_.animationcurve.html) 中查阅。也可以传入一个 [`UIViewAnimationCurve`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/#//apple_ref/c/tdef/UIViewAnimationCurve)(iOS) 或 [`android.animation.TimeInterpolator`](http://developer.android.com/reference/android/animation/TimeInterpolator.html) (Android) 的实例。如果未指定，将默认使用 `easeInOut` 效果。

To specify a default transition for **all** frame navigations, set the `transition` property of the frame you are navigating with.  

如要为**所有**帧导航指定默认过渡效果，请设置要导航的帧的 `transition` 属性。

 ``` JavaScript
topmost.transition = { name: "flip" };
topmost.navigate("main-page");
```
``` TypeScript
topmost.transition = { name: "flip" };
topmost.navigate("main-page");
```

To specify a default transition for **all** navigations across the entire app, set the **static** `defaultTransition` property of the `Frame` class.

如要为**所有**导航指定应用级的默认过渡效果，请设置 `Frame` 类的 **静态**属性 `defaultTransision`。

 ``` JavaScript
var frameModule = require("ui/frame");
frameModule.Frame.defaultTransition = { name: "fade" };
```
``` TypeScript
import frameModule from "ui/frame";
frameModule.Frame.defaultTransition = { name: "fade" };
```

To specify different transitions for the different platforms use the `transitioniOS` and `transitionAndroid` properties of the [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html).

如要为不同平台指定不同的过渡效果，请设置 [`NavigationEntry`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationentry.html) 的 `transitioniOS` 和 `transitionAndroid` 属性。

### Example 11:  Set up platform specific transitions.

### 示例 11: 为不同平台指定过渡效果。

``` JavaScript
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transitioniOS: {
        name: "curl",
        duration: 380,
        curve: "easeIn"
    },
    transitionAndroid: {
        name: "explode",
        duration: 300,
        curve: "easeOut"
    }
};
topmost.navigate(navigationEntry);
```
``` TypeScript
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transitioniOS: {
        name: "curl",
        duration: 380,
        curve: "easeIn"
    },
    transitionAndroid: {
        name: "explode",
        duration: 300,
        curve: "easeOut"
    }
};
topmost.navigate(navigationEntry);
```

### Custom transitions

### 自定义过渡

Instead of setting the `name` property to one of the predefined transitions, you can set the `instance` property of the [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) to an instance of a class that inherits from [`Transition`](http://docs.nativescript.org/api-reference/classes/_ui_transition_.transition.html). You can create your own custom user-defined transition by writing platform-specific code to animate the transition. To do that you need to inherit from the [`Transition`](http://docs.nativescript.org/api-reference/classes/_ui_transition_.transition.html) class and override one method for each platform. Since there will be platform-specific code, you need to separate your code into two separate files. Here is an example of a custom transition that shrinks the disappearing page while expanding the appearing page by using a scale affine transform.

相较于将 `name` 属性设置为预定义的过渡效果，我们可以将 [`NavigationTransition`](http://docs.nativescript.org/api-reference/interfaces/_ui_frame_.navigationtransition.html) 的 `instance` 属性设置为一个继承 [`Transition`](http://docs.nativescript.org/api-reference/classes/_ui_transition_.transition.html) 的类的实例来实现自定义过渡效果。我们可以通过根据不同平台编写特定代码来创建自定义过渡动画效果。如要实现自定义过渡，我们需要继承  [`Transition`](http://docs.nativescript.org/api-reference/classes/_ui_transition_.transition.html) 类，并根据平台重载其中相应的方法。 因为平台特定代码的存在，我们需要把代码分为两个单独的文件。以下为一个自定义过渡效果示例，该示例通过使用缩放仿射变换实现了导航前页的缩小和导航后页的扩大。

### Example 12:  Create your own custom transition.

### 示例 12: 创建自定义过渡效果。

`custom-transition.android.js/ts`
``` JavaScript
var transition = require("ui/transition");
var floatType = java.lang.Float.class.getField("TYPE").get(null);
var CustomTransition = (function (_super) {
    __extends(CustomTransition, _super);
    function CustomTransition() {
        _super.apply(this, arguments);
    }
    CustomTransition.prototype.createAndroidAnimator = function (transitionType) {
        var scaleValues = java.lang.reflect.Array.newInstance(floatType, 2);
        switch (transitionType) {
            case transition.AndroidTransitionType.enter:
            case transition.AndroidTransitionType.popEnter:
                scaleValues[0] = 0;
                scaleValues[1] = 1;
                break;
            case transition.AndroidTransitionType.exit:
            case transition.AndroidTransitionType.popExit:
                scaleValues[0] = 1;
                scaleValues[1] = 0;
                break;
        }
        var objectAnimators = java.lang.reflect.Array.newInstance(android.animation.Animator.class, 2);
        objectAnimators[0] = android.animation.ObjectAnimator.ofFloat(null, "scaleX", scaleValues);
        objectAnimators[1] = android.animation.ObjectAnimator.ofFloat(null, "scaleY", scaleValues);
        var animatorSet = new android.animation.AnimatorSet();
        animatorSet.playTogether(objectAnimators);
        var duration = this.getDuration();
        if (duration !== undefined) {
            animatorSet.setDuration(duration);
        }
        animatorSet.setInterpolator(this.getCurve());
        return animatorSet;
    };
    return CustomTransition;
})(transition.Transition);
exports.CustomTransition = CustomTransition;
```
``` TypeScript
import transition from "ui/transition";
import platform from "platform";

var floatType = java.lang.Float.class.getField("TYPE").get(null);

export class CustomTransition extends transition.Transition {
    public createAndroidAnimator(transitionType: string): android.animation.Animator {
        var scaleValues = java.lang.reflect.Array.newInstance(floatType, 2);
        switch (transitionType) {
            case transition.AndroidTransitionType.enter:
            case transition.AndroidTransitionType.popEnter:
                scaleValues[0] = 0;
                scaleValues[1] = 1;
                break;
            case transition.AndroidTransitionType.exit:
            case transition.AndroidTransitionType.popExit:
                scaleValues[0] = 1;
                scaleValues[1] = 0;
                break;
        }
        var objectAnimators = java.lang.reflect.Array.newInstance(android.animation.Animator.class, 2);
        objectAnimators[0] = android.animation.ObjectAnimator.ofFloat(null, "scaleX", scaleValues);
        objectAnimators[1] = android.animation.ObjectAnimator.ofFloat(null, "scaleY", scaleValues);
        var animatorSet = new android.animation.AnimatorSet();
        animatorSet.playTogether(objectAnimators);

        var duration = this.getDuration();
        if (duration !== undefined) {
            animatorSet.setDuration(duration);
        }
        animatorSet.setInterpolator(this.getCurve());

        return animatorSet;
    }
}
```

`custom-transition.ios.js/ts`
``` JavaScript
var transition = require("ui/transition");
var CustomTransition = (function (_super) {
    __extends(CustomTransition, _super);
    function CustomTransition() {
        _super.apply(this, arguments);
    }
    CustomTransition.prototype.animateIOSTransition = function (containerView, fromView, toView, operation, completion) {
        toView.transform = CGAffineTransformMakeScale(0, 0);
        fromView.transform = CGAffineTransformIdentity;
        switch (operation) {
            case UINavigationControllerOperation.UINavigationControllerOperationPush:
                containerView.insertSubviewAboveSubview(toView, fromView);
                break;
            case UINavigationControllerOperation.UINavigationControllerOperationPop:
                containerView.insertSubviewBelowSubview(toView, fromView);
                break;
        }
        var duration = this.getDuration();
        var curve = this.getCurve();
        UIView.animateWithDurationAnimationsCompletion(duration, function () {
            UIView.setAnimationCurve(curve);
            toView.transform = CGAffineTransformIdentity;
            fromView.transform = CGAffineTransformMakeScale(0, 0);
        }, completion);
    };
    return CustomTransition;
})(transition.Transition);
exports.CustomTransition = CustomTransition;
```
``` TypeScript
import transition from "ui/transition";
import platform from "platform";

export class CustomTransition extends transition.Transition {
    public animateIOSTransition(containerView: UIView, fromView: UIView, toView: UIView, operation: UINavigationControllerOperation, completion: (finished: boolean) => void): void {
        toView.transform = CGAffineTransformMakeScale(0, 0);
        fromView.transform = CGAffineTransformIdentity;

        switch (operation) {
            case UINavigationControllerOperation.UINavigationControllerOperationPush:
                containerView.insertSubviewAboveSubview(toView, fromView);
                break;
            case UINavigationControllerOperation.UINavigationControllerOperationPop:
                containerView.insertSubviewBelowSubview(toView, fromView);
                break;
        }

        var duration = this.getDuration();
        var curve = this.getCurve();
        UIView.animateWithDurationAnimationsCompletion(duration, () => {
            UIView.setAnimationCurve(curve);
            toView.transform = CGAffineTransformIdentity;
            fromView.transform = CGAffineTransformMakeScale(0, 0);
        }, completion);
    }
}
```

Once you have `custom-transition.android.js/ts` and `custom-transition.ios.js/ts` created, you need to require the module and instantiate your CustomTransition, optionally passing a duration and curve to the constructor.

一旦创建了 `custom-transition.android.js/ts` 和 `custom-transition.ios.js/ts` 文件，我们需要引入模块并实例化自定义过渡效果，也可以向构造函数中传入持续时间和过渡曲线。

### Example 13:  Require the module and instantiate your custom transition.

### 示例 13: 引入自定义过渡模块并实例化。

```JavaScript
var customTransition = new customTransitionModule.CustomTransition(300, "easeIn");
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transition: {instance: customTransition}
};
topmost.navigate(navigationEntry);
```
```TypeScript
var customTransition = new customTransitionModule.CustomTransition(300, "easeIn");
var navigationEntry = {
    moduleName: "main-page",
    animated: true,
    transition: {instance: customTransition}
};
topmost.navigate(navigationEntry);
```

### Navigate back

### 导航返回

The topmost frame tracks the pages the user has visited in a navigation stack. To go back to a previous page, you need to use the **goBack** method of the topmost frame instance.

顶层帧会追踪访问过的页面并储存在历史导航栈里。如要返回先前的页面，需要调用顶层帧实例的 **goBack** 方法。

``` JavaScript
topmost.goBack();
```
``` TypeScript
topmost.goBack();
```

### Modal pages

### 模态页

Use the **showModal** method of the page class to show another page as a modal dialog. You must specify the location of the modal page module. You can provide a context and a callback function that will be called when the modal page is closed. You can also optionally specify whether to show the modal page in fullscreen or not. To close the modal page, you need to subscribe to its `shownModally` event and store a reference to a close callback function provided through the event arguments. Call this function when you are ready to close the modal page, optionally passing some results to the master page. Here is an example with two pages &mdash; a main page and a login page. The main page shows the login page modally; the user enters their username and password and when ready clicks the Login button. This closes the modal login page and returns the username/password to the main page which can then log the user in.

使用页面类的 **showModal** 方法来将其他页面作为模态框展示。需指定模态页面模块的位置。我们可以提供一个上下文和一个模态页面关闭时调用的回调函数。也可以指定是否全屏展示模态页。如要关闭模态页，我们需要订阅它的 `shownModally` 事件，通过该事件函数参数传入页面关闭回调函数，并储存它的引用。当准备关闭模态页时，调用这个回调函数，如有需要可以向主页面传递内容。以下示例应用包含了一个主页面和一个登录页面。主页面会以模态框的形式显示登录页。当用户输入用户名和密码并点击登录按钮时，模态登录页会关闭并将用户名/密码返回给主页面，然后在主页面执行登陆操作。

> **TIP:** By design on iPhone, a modal page appears only in fullscreen.

> **提示:** 由于 iPhone 的设计原因，模态页只会全屏展示。

### Example 14:  Receive data from the modal page.

### 示例 14: 从模态页接收数据。

**main-page**

**主页**

``` JavaScript
 var modalPageModule = "./modal-views-demo/login-page";
 var context = "some custom context";
 var fullscreen = true;
 mainPage.showModal(modalPageModule, context, function closeCallback(username, password) {
     // Log the user in...
 }, fullscreen);
```
``` TypeScript
 var modalPageModule = "./modal-views-demo/login-page";
 var context = "some custom context";
 var fullscreen = true;
 mainPage.showModal(modalPageModule, context, function closeCallback (username: string, password: string) {
     // Log the user in...
 }, fullscreen);
```
>  Note: Only one Modal Page could be opened in the application (For example: opening a Modal Page from another Modal Page is not supported). In case we need to open second Modal, we should close the first one and then to open the second.

> 注意：应用中只能同时打开一个模态页 (比如：在一个模态页中无法打开另一个模态页)。如要打开第一个模态页，可以先关闭第一个，再打开第二个。

**login-page**

**登录页**

``` JavaScript
var context;
var closeCallback;
function onShownModally(args) {
    context = args.context;
    closeCallback = args.closeCallback;
}
exports.onShownModally = onShownModally;
function onLoginButtonTap() {
    closeCallback(usernameTextField.text, passwordTextField.text);
}
exports.onLoginButtonTap = onLoginButtonTap;
```
``` TypeScript
var context: any;
var closeCallback: Function;
export function onShownModally(args: pages.ShownModallyData) {
    context = args.context;
    closeCallback = args.closeCallback;
}

export function onLoginButtonTap() {
    closeCallback(usernameTextField.text, passwordTextField.text);
}
```

You can find the complete source code [here](https://github.com/NativeScript/NativeScript/tree/master/apps/app/ui-tests-app/modal-view).
你可以在[这里](https://github.com/NativeScript/NativeScript/tree/master/apps/app/ui-tests-app/modal-view)找到源代码。
## Supporting multiple screens

## 多屏幕支持

Mobile applications run on different devices with different screen sizes and form factors. NativeScript provides a way to define different files (.js, .css, .xml, etc.) to be loaded based on the screen's size, platform and orientation of the current device. The approach is somewhat similar to [multi screen support in Android](http://developer.android.com/guide/practices/screens_support.html). There is a set of *qualifiers* that can be added inside the file that will be respected when the file is loaded. Here is how the file should look:

移动端应用会在不同屏幕、外形尺寸的设备上运行。NativeScript 提供了一种基于当前设备的屏幕尺寸，平台和方向来决定加载哪类对应文件（.js，.css，.xml等）的方法。这个方法有点类似于 [Android 下的多屏幕支持](http://developer.android.com/guide/practices/screens_support.html)。文件中可以添加一组 *限定符*，文件会按照限定符进行加载。以下是文件名格式：

`<file-name>[.<qualifier>]*.<extension>`

In the next section we will go through the list of supported qualifiers.

接下来我们来看一下支持的限定符清单。

### Screen size qualifiers

### 屏幕尺寸限定符

All the values in screen size qualifiers are in density independent pixels(dp) &mdash; meaning it corresponds to the physical dimensions of the screen. The assumptions is that there are ~160 dp per inch. For example, according to Android guidelines, if the device's smaller dimension is more than 600 dp (~3.75 inches) it is probably a tablet.

屏幕尺寸限定符中的所有值均为与密度无关的像素 (dp) &mdash; 意味着它对应屏幕的物理尺寸。假设每英寸约为160 dp。例如，根据 Android 指南，如果设备的较小尺寸超过600 dp (约3.75英寸），则它可能是平板电脑。

* `minWH<X>` - The smaller dimension (width or height) should be at least **X** dp.  
  `minWH<X>` - 较小的尺寸（宽度或高度）应至少为 X dp。
* `minW<X>` - Width should be at least **X** dp.  
  `minW<X>` - 宽度应至少为 X dp。
* `minH<X>` - Height should be at least **X** dp.
  `minH<X>` - 高度应至少为 X dp。

*Example (separate XML file for tablet and phone)*:

*示例 (单独用于平板电脑和手机的XML文件)*:

* `main-page.minWH600.xml` - XML file to be used for tablet devices.  
  `main-page.minWH600.xml` - 用于平板电脑的 XML 文件。
* `main-page.xml` - XML to be used for phones.   
  `main-page.xml` - 用于手机的 XML 文件。

### Platform qualifiers

### 平台限定符

* `android` – Android platform  
  `android` – Android 平台
* `ios` – iOS platform  
  `ios` – iOS 平台
* `windows` (coming soon) – Windows platform  
  `windows` (即将推出) – Windows 平台

*Example (platform specific files)*:

*示例 (平台限定符文件)* :

* `app.android.css` - CSS styles for Android.  
  `app.android.css` - 用于 Android 的 CSS 样式。
* `app.ios.css` - CSS styles for iOS.   
  `app.ios.css` - 用于 iOS 的 CSS 样式。 

The platform qualifiers are executed during build time, while the others are executed during run time. For example, the app.ios.css file will not be taken in consideration when building for the Android platform. Contrary, the screen size qualifiers will be considered just after the application runs on a device with a specific screen size. 

平台限定符在构建时执行，而其他限定符在运行时执行。例如，在构建 Android 平台时，app.ios.css文件将被忽略。在具有特定屏幕尺寸的设备上运行应用程序之后，将考虑屏幕尺寸限定符。

### Orientation qualifiers

### 方向限定符

* `land` - orientation is in landscape mode.  
  `land` - 方向是横向模式。
* `port` - orientation is in landscape mode.   
  `port` - 方向是纵向模式。

> Note: All qualifiers are taken into account when the page is loading. However, changing the device orientation will not trigger page reload and will not change the current page.

> 注意：当页面加载时，会考虑所有限定符。但是，更改设备方向将不会触发页面重新加载，并且不会更改当前页面。
