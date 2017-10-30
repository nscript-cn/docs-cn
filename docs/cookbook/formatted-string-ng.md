---
title: Using formatted string
description: How to use the FormattedString class in an Angular App
position: 2
slug: formatted-string
previous_url: /formatted-string
environment: angular
---

# How to use the FormattedString class in text

# 使用FormattedString格式化文字

NativeScript has a special class called [FormattedString](http://docs.nativescript.org/api-reference/classes/_text_formatted_string_.formattedstring.html) to support various text transformations and decorations. The `FormattedString` class can be used with all text-related components like Label, TextView, TextField and even Button. Using `FormattedString` within an NativeScript-Angular app requires using a special syntax because of how Angular views get added to the native visual tree. Here’s what the correct syntax looks like:

NativeScript 有一个特殊的类 [FormattedString](http://docs.nativescript.org/api-reference/classes/_text_formatted_string_.formattedstring.html)，用来各种文字的转换和装饰，这个类可以用于各种文字相关的组件如 Label, TextView, TextField，Button。因为涉及到Angular View 被添加的原生组件树的方式，所以在NativeScript-Angular程序中需要一些特殊语法。下面的例子展示了正确的语法：

```HTML
<Label>
    <FormattedString>
        <Span text="some content" fontWeight="Bold"></Span>
    </FormattedString>
</Label>
```

This syntax differs from the FormattedString’s full syntax used in NativeScript Core, shown below, which does not work in Angular apps:

这种语法和 FormattedString在NativeScript Core中是不一样的，比如下面的例子在Angular程序中就不能正确的运行。

```HTML
<Label>
    <Label.formattedText>
        <FormattedString>
            <FormattedString.spans>
                <Span text="some " fontWeight="Bold"></Span>
                <Span text="content"></Span>
            </FormattedString.spans>
        </FormattedString>
    </Label.formattedText>
</Label>
```
