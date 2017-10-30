---
title: Tab View
description: NativeScript for Angular Documentation - Using Tab View
position: 5
slug: tabview
previous_url: /tabview
environment: angular
---

# Tab View
# 标签页（tab view）
Using a `TabView` inside an Angular app requires some special attention about how to provide title, iconSource and content (view) of the TabItem. In a pure NativeScript application, `TabView` has an items property which could be set via XML to an array of TabViewItems (basically, an array of objects with `title` and `view` properties). However, NativeScript-Angular does not support nested properties in its HTML template, so adding `TabViewItem` to TabView is a little bit different. NativeScript-Angular provides a custom Angular directive that simplifies the way native `TabView` should be used. The following example shows how to add a `TabView` to your page (with some clarifications later):

在Angular app中使用 `TabView`,设置TabItem的title，iconSource和content（view）时要特别注意。开发纯NativeScript程序时，`TabView`有一个items属性，这个属性可以通过转换XML成包含TabViewItems（基本上就是一系列包含`title` 和 `view`属性的对象组成的数组）的数组设置，但是在Angular app中给TabView设置`TabViewItem`却稍有不同，这是因为NativeScript-Angular的模版引擎不支持嵌套属性造成的。NativeScript-Angular提供了自定义的`TabView`指令(directive),简化了调用原生`TabView`的方式，下面的例子展示了在页面中使用`TabView`的方法(后面有相关的解释说明)。
```XML
// tab-view-test.html
<TabView>
    <StackLayout *tabItem="{title: 'Profile', iconSource: '~/icon.png'}" >
        <ListView [items]="items">
            <template let-item="item">
                <Label [text]="item.itemDesc"></Label>
            </template>
        </ListView>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Stats'}">
        <Label text="Second tab item"></Label>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Settings'}">
        <Label text="Third tab item"></Label>
    </StackLayout>
</TabView>
```
```TypeScript
import { Component } from "@angular/core";

export class DataItem {
    constructor(public itemDesc: string) {}
}

@Component({
	selector: "tab-view-test",
	templateUrl: "tab-view-test.html"
})
export class TabViewTest {
    public items: Array<DataItem>;

    constructor() {
        this.items = new Array<DataItem>();
        for (let i = 0; i < 5; i++) {
            this.items.push(new DataItem("item " + i));
        }
    }
}
```

* tabItem:  The TabView directive uses a JSON object to transfer properties to the native object. Actually, `TabViewItem` is a pretty simple object with just `title`, `iconSource` and `view` properties. Since `title` and `iconSource` are usually represented as text, TabView directive uses a small JSON object (`{title: 'Profile', iconSource: '~/icon.png'}`) to define these properties easily in HTML. View, however, is not so simple, therefore as TabViewItem. View TabView directive uses the tag where `tabItem` attribute is set.
<Comment: The text in the previous sentence, TabViewItem. View TabView is incorrect, but any changes I make to it may change the meaning. The commas I added are correct, so please keep those.>

* tabItem: TabView指令用JSON对象把属性传到原生对象，其实`TabViewItem`就是由`title`, `iconSource` 和 `view`属性组成的对象，因为 `title` 和 `iconSource`常常是字符串，所以在HTML模版里用JSON对象（`{title: 'Profile', iconSource: '~/icon.png'}`）定义它们，但是 TabViewItem的view，即`view`就比较复杂了，TabView指令把`tabItem`属性所在的标签作为TabView的View。(注：上例中是StackLayout)

This is a typical usage of the TabView directive; however, if further customization is required, there are a few options available.

上面是TabView的基本用法，TabView还提供了几项自定义的参数，可以用于有自定义的需求场景。

### Customizing Tab View

### 自定义 Tab View

The most common customization of TabView is customizing the background color of the selected tab item to use something other than the first tab item for start up. <Comment: Please review my changes to the previous sentence to verify I did not create a technical error.> The following example shows how to achieve that with a few modifications to the previous example.

最常用的需求就是在页面初始化后，自定义选中项的背景颜色。 下面的例子稍微更改上个实现了这个目的。

```XML
// tab-view-test.html
<TabView selectedIndex="1" selectedColor="#FF0000">
    <StackLayout *tabItem="{title: 'Profile', iconSource: '~/icon.png'}" >
        <ListView [items]="items">
            <template let-item="item">
                <Label [text]="item.itemDesc"></Label>
            </template>
        </ListView>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Stats'}">
        <Label text="Second tab item"></Label>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Settings'}">
        <Label text="Third tab item"></Label>
    </StackLayout>
</TabView>
```

The result is a TabView that selects the second tab at start up and uses the color red for the selected tab.

上例中页面初始化后默认选中了第二项，并把选中项背景色设为红色。

### Binding (Two-way) TabView selectedIndex

### 绑定TabView的selectedIndex （双向绑定）

You can use the NativeScript-Angular TabView `selectedIndex` property in two-way binding scenarios. Using this kind of binding is relatively simple. Just use the standard `ngModel` syntax to a data model property (for the sake of example, the TabViewTest class is used as binding context) and set the data model property `tabSelectedIndex` to the desired value. <Comment: Please review my changes to the previous sentence to verify I did not create a technical error. I think there is a word missing in the phrase, "syntax to a data model property".>

可以在双向绑定场景中使用TabView“selectedIndex”属性。实现方法相对比较简单，只要利用标准的`ngModel`指令绑定一个模型属性即可（在下例中，把TabViewTest类当作绑定的上下文），例子中把数据模型属性“tabSelectedIndex”设置为所需的值

```XML
// tab-view-test.html
<TabView [(ngModel)]="tabSelectedIndex" selectedColor="#FF0000">
    <StackLayout *tabItem="{title: 'Profile', iconSource: '~/icon.png'}" >
        <ListView [items]="items">
            <template let-item="item">
            	<Label [text]="item.itemDesc"></Label>
            </template>
        </ListView>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Stats'}">
    	<Label text="Second tab item"></Label>
    </StackLayout>
    <StackLayout *tabItem="{title: 'Settings'}">
    	<Label text="Third tab item"></Label>
    </StackLayout>
</TabView>
```
```TypeScript
import { Component } from "@angular/core";

export class DataItem {
    constructor(public itemDesc: string) {}
}

@Component({
	selector: "tab-view-test",
	templateUrl: "tab-view-test.html"
})
export class TabViewTest {
    public items: Array<DataItem>;
    public tabSelectedIndex: number;

    constructor() {
    	this.tabSelectedIndex = 1;
        this.items = new Array<DataItem>();
        for (let i = 0; i < 5; i++) {
            this.items.push(new DataItem("item " + i));
        }
    }
}
```
