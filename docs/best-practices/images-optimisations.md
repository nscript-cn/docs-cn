---
title: Image Optimization Android
description: Performance techniques when using images in NativeScript
position: 65
slug: images-performance
---

# Android Image Optimization

# Android图片优化

One of the most common scenarios for modern mobile applications is to work with multiple images often in high definition formats.
It is crucial for each mobile developer to handle memory related issues and optimize the application so it could handle large data (e.g. API call which will load hundreds of photos). 

当前移动应用经常遇到的场景之一是处理大量的高分辨率图片。因此对于开发者来说，恰当地处理大量数据（比如请求某个API后将会加载数百张图片）所引起的内存使用及应用优化是至关重要的。

In this article, we will take a look at how Image module works in NativeScript and 
cover the techniques that will improve Android application performance.

本文解释了NativeScript的图片模块是工作原理的，并且介绍了图片模块在提高Android应用性能的技巧。

## Handling large images and avoiding Out Of Memory exception

## 处理大型图片，避免内存溢出

In some cases when working with multiple large images on devices with low memory, an `Out Of Memory` exception can occur. To prevent that scenario, in NativeScript 2.5.x and above using the `src` property in Android will internally load the Bitmap in Java. Bitmap memory stays in Java world and reclaims once the Bitmap is no longer in use (e.g. there is no need for the Javascript object to be collected).This way Bitmap memory management is not an issue.

在某些内存比较小的设备上处理大量大型图片数据时，容易出现内存溢出(`Out of Memory`)的异常现象。为了应对这种现象，NativeScript在2.5.x及后续版本中，图片设置`src`属性后将会把该图片以Bitmap的内存形式在Java中进行加载。Bitmap内存是Java中的一种内存管理方式，并且会在不使用的时候自动回收(`GC`)，因此Javascript不需要去主动回收该内存。如此看来，Bitmap的内存管理不是什么大问题。

In contrast, when using `ImageSource` or Base64 encoded string, the Bitmap is transferred to Javascript, so it will be released when Javascript object reclaims. Javascript garbage collection happens less frequently than Java garbage collection which might lead to Out Of Memory.

相对的，当设置了`ImageSource`或者以`Base64`编码的字符串来加载图片，将会把原先以Bitmap内存形式变成Javascript的内存管理。这部分内存只有当Javascript的垃圾回收机制工作时才会回收。鉴于Javascript的垃圾回收机制频率比Java的的明显要低，所以更容易导致内存溢出。

> **Tip**: Use `src` property of your `Image` to set your images to avoid Out Of Memory related issues.

> **提示**：设置`Image`的`src`属性来避免内存溢出的情况发生。

As an additional feature for Android, NativeScript supports `decodeWidth` and `decodeHeight`. These properties will downsample your image so that it will take less memory. With [loadMode](http://docs.nativescript.org/api-reference/modules/_ui_image_.html#loadmode) set to `async`, the image will load asynchronously meaning the UI won't block by the decoding and preloading operations. The developers can use `loadMode` on both iOS and Android.

Android设备还有另外一项优势，NativeScript支持`decodeWidth`和`decodeHeight`。这两个属性能够降低图片的采样率，因此图片将会占用更少的内存。设置属性[loadMode](http://docs.nativescript.org/api-reference/modules/_ui_image_.html#loadmode)的值为`async`，图片将会以异步的方式加载，UI不会阻碍图片解码和加载的过程。iOS和Android设备上均支持`loadMode`属性。

> **Tip**: When working with large images, use `decodeWidth` and `decodeHeight` to downsample the image. Use `loadMode="async"` to prevent blocking of the UI while the image is loading.

> **提示**：图片尺寸很大时，可以使用`decodeWidth`和`decodeHeight`来降低图片的采样率。设置 `loadMode="async"`来防止图片加载渲时受到UI的阻碍。

```XML
<StackLayout>
    <Image src="{{ someExtremelyLargeImage }}" decodeWidth="400" decodeHeight="400" loadMode="async" />
    <Label text="With loadMode set to async the UI won't be blocked" textWrap="true" />
</StackLayout>
```

> **Important**: When the `src` value starts with `http` it will be loaded asynchronously no matter what value is set to `loadMode`.

> **重点**：当`src`的值是以`http`开头的字符串，图片将会以异步的方式加载，此时`loadMode`的属性设置失效。

The `Image` module will use internal memory and disk cache, so when loaded the module stores the images in the memory cache, and when they are not needed anymore, the `Image` module saves the images in the disk cache. This way the next time the application needs the same image NativeScript will load it from memory or the disk cache. Setting property `useCache` to `false` could be used to bypass image cache and load the image as it is on the first request to the specified URL.

`Image`模块同时支持内存缓存和硬盘缓存。当图片加载时，模块把图片存到内存缓存中去，当图片不在使用时，模块就把这些图片存到硬盘缓存中。当下一次同样的图片被使用时，NativeScript将会从内存缓存或硬盘缓存中加载。`useCache`值设为`false`时，将不会缓存图片，而会直接向相应的URL去请求并加载该图片1。 

> **Important**: The properties `decodeWidth`, `decodeHeight` and `useCache` will work only for Android. Setting them for our iOS images will not change the application behavour in any way.

> **重点**：`decodeWidth`，`decodeHeight`和`useCache`这三个属性仅对Android有效。在iOS设置后，将不会对应用性能产生影响。

**API Reference for** [Image Module](http://docs.nativescript.org/api-reference/modules/_ui_image_.html)

**图片模块的**[API文档](http://docs.nativescript.org/api-reference/modules/_ui_image_.html) 

**NativeScript Core Examples** [Cookbook](http://docs.nativescript.org/cookbook/ui/image)

**NativeScript Core示例应用** [Cookbook](http://docs.nativescript.org/cookbook/ui/image) 

**NativeScript Angular Examples** [Code Samples](http://docs.nativescript.org/angular/code-samples/ui/image.html) 

**NatvieScript结合Angluar的示例应用** [Code Samples](http://docs.nativescript.org/angular/code-samples/ui/image.html)
