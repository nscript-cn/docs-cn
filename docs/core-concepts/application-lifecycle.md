---
title: Application Lifecycle
description: Learn how to manage the life cycle of NativeScript applications from application start to storing user-defined settings.
position: 40
slug: lifecycle
previous_url: /application-management,/core-concepts/application-management
---
{% angular %}
# NativeScript application architecture and lifecycle

# NativeScript 应用架构和生命周期

The main building blocks of NativeScript applications with Angular are:

使用 Angular 开发的 NativeScript 应用主要有以下构建模块：

* [Modules](#modules)

  [模块](#modules)

* [Components](#components)

  [组件](#components)

The `application` module lets you manage the life cycle of your NativeScript apps from starting the application to storing user-defined settings.

`application` 模块可以让你管理 NativeScript 应用的生命周期，从启动程序到储存用户设置。

* [Start Application](#start-application)

  [启动应用](#start-application)

* [Use Application Events](#use-application-events)

  [使用应用事件](#use-application-events)

* [Android Activity Events](#android-activity-events)

  [安卓活动事件](#android-activity-events)

* [iOS UIApplicationDelegate](#ios-uiapplicationdelegate)

  [iOS UI程序委托](#ios-uiapplicationdelegate)

* [Persist and Restore Application Settings](#persist-and-restore-application-settings)
  
  [持久化和还原应用设置](#persist-and-restore-application-settings)
## Modules 

## 模块

Angular applications are modular. A module is a file containing a block of code dedicated to a single purpose. It exports a value that can be used by other parts of the application. For example:

Angular 应用是模块化的。一个模块致力于解决一个问题。它导出了一个可以被应用其它部分使用的值。比如：

``` TypeScript
export class AppComponent {}
```

The `export` statement is important as it makes the `AppComponent` accessible to other modules. The import clause is used to reference the `AppComponent` class from other modules:

`export` 语句非常重要，因为它使 `AppComponent` 可以被其它模块访问。其它模块可以使用 `import` 语句引入 `AppComponent`  类：

``` TypeScript
import { Component } from '@angular/core';
import { AppComponent } from './app.component';
```

Some modules are libraries of other modules. Modules installed as npm packages (like `@angular/core` in the above example) should be referenced without a path prefix. When we import from one of our own files, we prefix the module name with the file path. In this example we specify a relative file path (./). That means the source module is in the same folder (./) as the module importing it. 


一些模块是其它模块的库。模块可以作为 npm 的包安装（比如上面示例中的 `@angular/core`），这些模块被引入的时候不应该有路径前缀。当我们从自己的文件中引入模块时，我们会在模块名前加上文件路径前缀。在示例中，我们指定了一个相对路径（./）。他表示要引入的模块与当前模块在同一个文件夹内。
## Components

## 组件

Components are the fundamental building blocks of NativeScript applications built with Angular. Every NativeScript application contains a set of components that define every UI element, screen or route. The application has a root component that contains all other components. The following constitutes a component:

在使用 Angular 开发 NativeScript 应用时，组件是应用构建模块的基础。 每一个 NativeScript 应用都包含一系列组件，这些组件定义了 UI 元素，屏幕页面或路由。应用有一个根组件包含了其它所有组件。一个组件有以下几个特点：

* A component knows how to interact with its host element.

  组件知道如何与宿主元素交流。

* A component knows how to render itself.

  组件知道如何渲染自己。

* A component configures dependency injection.

  组件可以配置依赖注入。

* A component has a well-defined public API of input and output properties.

  组件有定义良好的输入、输出属性的公共 API。

* A component has well-defined lifecycle.

  组件有定义良好的生命周期。

### Component example

### 组件示例


``` TypeScript
import { Component } from "@angular/core";

@Component({
    selector: "main-component",
    template: `
        <StackLayout>
            <Label text="Hello {{ name }}"></Label>
        </StackLayout>
    `
})
export class MainComponent {
    constructor() {
        this.name = "Angular!";
    }
}
```

## Component metadata

## 组件的元数据

The `@Component` decorator contains metadata describing how to create and present the component. Here are some of the configuration options:

`@Component` 装饰器包含了描述如何创建和呈现组件的元数据。这里是一些可选的配置项：

* **selector** - a CSS selector that tells Angular to create and insert an instance of this component where it finds the selector in parent component's template. For example:

  **selector** - 一个 CSS 选择器，它告诉了 Angular 如何创建和插入这个组件的示例，你可以在父组件的模版中使用它，比如：

```HTML
<main-component></main-component>
```

* **template** - A visual tree that represents the component view. Here you can use all NativeScript UI elements and custom defined UI components.

 **teamplate** - 表示组件视图的可视化树。在这里你可以使用所有的 NativeScript UI 元素 和自定义的 UI 组件。

* **templateUrl** - The address of a file where the component template is located.
* **styles** - CSS directives that define the component style.
* **styleUrls** - An array containing URLs of CSS files that define the component style.
* **animations** - The animations associated with this component.
* **providers** - an array of dependency injection providers for services that the component requires.

## Component lifecycle

The component lifecycle is controlled by the Angular application. It creates, updates and destroys components. Lifecycle hooks are used to handle different events from the component lifecycle. Each hook method starts with the **ng** prefix. The following are some the component lifecycle methods:

* **ngOnInit** - Called after all data-bound input methods are initialized.
* **ngOnChanges** - Callled after a data-bound property has been changed.
* **ngDoCheck** - Detect and act upon changes that Angular can or won't detect on its own. Called every change detection run.
* **ngOnDestroy** - Called just before Angular destroys the component.

For a full list, see the official [Angular Lifecyle Hooks docs](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html).

## Start application

The starting point of an Angular application is the `nativeScriptBootstrap` method. It takes the root component as an argument:

### Example

``` TypeScript
import { nativeScriptBootstrap } from "./nativescript-angular/application";
import { MainComponent } from "./main-component";

nativeScriptBootstrap(MainComponent).then((compRef) => {
    console.log("The application is now running!");
}).catch((e) => {
    console.log("The application bootstrapping failed with error: " + e);
});
```

> **IMPORTANT:** You must call the `nativeScriptBootstrap` method **after** the module initialization. Any code after the `nativeScriptBootstrap` call will not be executed.
{% endangular%} 

{% nativescript %}
# Application Management

The `application` module lets you manage the life cycle of your NativeScript apps from starting the application to storing user-defined settings.

* [Start Application](#start-application)
* [Use Application Events](#use-application-events)
* [Android Activity Events](#android-activity-events)
* [iOS UIApplicationDelegate](#ios-uiapplicationdelegate)
* [Persist and Restore Application Settings](#persist-and-restore-application-settings)

## Start Application

This method is required only for iOS applications. 

> **IMPORTANT:** You must call the `start` method of the application module **after** the module initialization. Any code after the `start` call will not be executed.

### Example

``` JavaScript
/*
iOS calls UIApplication and triggers the application main event loop.
*/

var application = require("application");
application.start({ moduleName: "main-page" });
```
``` TypeScript
/*
iOS calls UIApplication and triggers the application main event loop.
*/

import { start as applicationStart } from "application";
applicationStart({ moduleName: "main-page" });
```
{% endnativescript %}

## Use Application Events

NativeScript applications have the following life cycle events.

+ `launch`: This event is raised when application launch.
+ `suspend`: This event is raised when the application is suspended.
+ `resume`: This event is raised when the application is resumed after it has been suspended.
+ `exit`: This event is raised when the application is about to exit.
+ `lowMemory`: This event is raised when the memory on the target device is low.
+ `uncaughtError`: This event is raised when an uncaught application error is present.

### Example

{% nativescript %}
``` JavaScript
var application = require("application");

application.on(application.launchEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an android.content.Intent class.
        console.log("Launched Android application with the following intent: " + args.android + ".");
    } else if (args.ios !== undefined) {
        // For iOS applications, args.ios is NSDictionary (launchOptions).
        console.log("Launched iOS application with options: " + args.ios);
    }
});

application.on(application.suspendEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(application.resumeEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(application.exitEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(application.lowMemoryEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(application.uncaughtErrorEvent, function (args) {
    if (args.android) {
        // For Android applications, args.android is an NativeScriptError.
        console.log("NativeScriptError: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is NativeScriptError.
        console.log("NativeScriptError: " + args.ios);
    }
});

application.start({ moduleName: "main-page" });
```
{% endnativescript %}
``` TypeScript
import { on as applicationOn, launchEvent, suspendEvent, resumeEvent, exitEvent, lowMemoryEvent, uncaughtErrorEvent, ApplicationEventData, start as applicationStart } from "application";
applicationOn(launchEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an android.content.Intent class.
        console.log("Launched Android application with the following intent: " + args.android + ".");
    } else if (args.ios !== undefined) {
        // For iOS applications, args.ios is NSDictionary (launchOptions).
        console.log("Launched iOS application with options: " + args.ios);
    }
});

applicationOn(suspendEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

applicationOn(resumeEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

applicationOn(exitEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(lowMemoryEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an android activity class.
        console.log("Activity: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is UIApplication.
        console.log("UIApplication: " + args.ios);
    }
});

application.on(uncaughtErrorEvent, function (args: ApplicationEventData) {
    if (args.android) {
        // For Android applications, args.android is an NativeScriptError.
        console.log("NativeScriptError: " + args.android);
    } else if (args.ios) {
        // For iOS applications, args.ios is NativeScriptError.
        console.log("NativeScriptError: " + args.ios);
    }
});
applicationStart({ moduleName: "main-page" });
```
## Android Activity Events

NativeScript applications have the following Android specific activity events:

+ `activityCreated`: This event is raised when activity is created.
+ `activityDestroyed`: This event is raised when activity is destroyed.
+ `activityStarted`: This event is raised when activity is started.
+ `activityPaused`: This event is raised when activity is paused.
+ `activityResumed`: This event is raised when activity is resumed.
+ `activityStopped`: This event is raised when activity is stopped.
+ `saveActivityState`: This event is raised to retrieve per-instance state from an activity before being killed so that the state can be restored.
+ `activityResult`: This event is raised when an activity you launched exits, giving you the requestCode you started it with, the resultCode it returned, and any additional data from it.
+ `activityBackPressed`: This event is raised when the activity has detected the user's press of the back key.

### Example

{% nativescript %}
``` JavaScript
var application = require("application");

if (application.android) {
    application.android.on(application.AndroidApplication.activityCreatedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity + ", Bundle: " + args.bundle);
    });
    
    application.android.on(application.AndroidApplication.activityDestroyedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });
    
    application.android.on(application.AndroidApplication.activityStartedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });
    
    application.android.on(application.AndroidApplication.activityPausedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });
    
    application.android.on(application.AndroidApplication.activityResumedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });
    
    application.android.on(application.AndroidApplication.activityStoppedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });
    
    application.android.on(application.AndroidApplication.saveActivityStateEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity + ", Bundle: " + args.bundle);
    });
    
    application.android.on(application.AndroidApplication.activityResultEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity +
            ", requestCode: " + args.requestCode + ", resultCode: " + args.resultCode + ", Intent: " + args.intent);
    });
    
    application.android.on(application.AndroidApplication.activityBackPressedEvent, function (args) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
        // Set args.cancel = true to cancel back navigation and do something custom.
    });
}

application.start();
```
{% endnativescript %}
``` TypeScript
import { android, AndroidApplication, AndroidActivityBundleEventData } from "application";

// Android activity events
if (android) {
    android.on(AndroidApplication.activityCreatedEvent, function (args: AndroidActivityBundleEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity + ", Bundle: " + args.bundle);
    });

    android.on(AndroidApplication.activityDestroyedEvent, function (args: AndroidActivityEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });

    android.on(AndroidApplication.activityStartedEvent, function (args: AndroidActivityEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });

    android.on(AndroidApplication.activityPausedEvent, function (args: AndroidActivityEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });

    android.on(AndroidApplication.activityResumedEvent, function (args: AndroidActivityEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });

    android.on(AndroidApplication.activityStoppedEvent, function (args: AndroidActivityEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
    });

    android.on(AndroidApplication.saveActivityStateEvent, function (args: AndroidActivityBundleEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity + ", Bundle: " + args.bundle);
    });

    android.on(AndroidApplication.activityResultEvent, function (args: AndroidActivityResultEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity +
            ", requestCode: " + args.requestCode + ", resultCode: " + args.resultCode + ", Intent: " + args.intent);
    });

    android.on(AndroidApplication.activityBackPressedEvent, function (args: AndroidActivityBackPressedEventData) {
        console.log("Event: " + args.eventName + ", Activity: " + args.activity);
        // Set args.cancel = true to cancel back navigation and do something custom.
    });
}

application.start({ moduleName: "main-page" });
```

## iOS UIApplicationDelegate

Since NativeScript 1.3 you can specify custom UIApplicationDelegate for the iOS application:

### Example

{% nativescript %}
``` JavaScript
var application = require("application");
var MyDelegate = (function (_super) {
    __extends(MyDelegate, _super);
    function MyDelegate() {
        _super.apply(this, arguments);
    }
    MyDelegate.prototype.applicationDidFinishLaunchingWithOptions = function (application, launchOptions) {
        console.log("applicationWillFinishLaunchingWithOptions: " + launchOptions);
        return true;
    };
    MyDelegate.prototype.applicationDidBecomeActive = function (application) {
        console.log("applicationDidBecomeActive: " + application);
    };
    MyDelegate.ObjCProtocols = [UIApplicationDelegate];
    return MyDelegate;
})(UIResponder);
application.ios.delegate = MyDelegate;
application.start();
```
{% endnativescript %}
``` TypeScript
import { ios, start as applicationStart } from "application";
class MyDelegate extends UIResponder implements UIApplicationDelegate {
    public static ObjCProtocols = [UIApplicationDelegate];

    applicationDidFinishLaunchingWithOptions(application: UIApplication, launchOptions: NSDictionary): boolean {
        console.log("applicationWillFinishLaunchingWithOptions: " + launchOptions)

        return true;
    }

    applicationDidBecomeActive(application: UIApplication): void {
        console.log("applicationDidBecomeActive: " + application)
    }
}
ios.delegate = MyDelegate;
applicationStart();
```

## Persist and Restore Application Settings

To persist user-defined settings, you need to use the `application-settings` module. The `application-settings` module is a static singleton hash table that stores key-value pairs for the application. 

The getter methods have two parameters: a key and an optional default value to return if the specified key does not exist.
The setter methods have two required parameters: a key and value. 

### Example

{% nativescript %}
``` JavaScript
var applicationSettings = require("application-settings");
// Event handler for Page "loaded" event attached in main-page.xml.
function pageLoaded(args) {
    applicationSettings.setString("Name", "John Doe");
    console.log(applicationSettings.getString("Name")); // Prints "John Doe".
    applicationSettings.setBoolean("Married", false);
    console.log(applicationSettings.getBoolean("Married")); // Prints false.
    applicationSettings.setNumber("Age", 42);
    console.log(applicationSettings.getNumber("Age")); // Prints 42.
    console.log(applicationSettings.hasKey("Name")); // Prints true.
    applicationSettings.remove("Name"); // Removes the Name entry.
    console.log(applicationSettings.hasKey("Name")); // Prints false.
}
exports.pageLoaded = pageLoaded;
```
{% endnativescript %}
``` TypeScript
import { EventData } from "data/observable";
import * as applicationSettings from "application-settings";
// Event handler for Page "loaded" event attached in main-page.xml.
export function pageLoaded(args: EventData) {
    applicationSettings.setString("Name", "John Doe");
    console.log(applicationSettings.getString("Name"));// Prints "John Doe".
    applicationSettings.setBoolean("Married", false);
    console.log(applicationSettings.getBoolean("Married"));// Prints false.
    applicationSettings.setNumber("Age", 42);
    console.log(applicationSettings.getNumber("Age"));// Prints 42.
    console.log(applicationSettings.hasKey("Name"));// Prints true.
    applicationSettings.remove("Name");// Removes the Name entry.
    console.log(applicationSettings.hasKey("Name"));// Prints false.
}
```
