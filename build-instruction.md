

### 克隆必须的资源库：

1. 克隆`nscript-cn/docs-cn`库，克隆完成后，将 `docs-cn` 目录名改为`docs`(目录结构..\NativeScript\docs)
1. 克隆`NativeScript/NativeScript`库(目录结构 ..\NativeScript\NativeScript)
1. 克隆`NativeScript/nativescript-sdk-examples-ng`库(目录结构 ..\NativeScript\nativescript-sdk-examples-ng)
1. 克隆`NativeScript/sidekick-docs`库(目录结构 ..\NativeScript\sidekick-docs)

### 克隆完后的文件结构：

文件结构应该如下:
```
               |_ NativeScript
               
                                |_ docs
                                
                                |_ NativeScript
                                
                                |_ nativescript-sdk-examples-ng
                                
                                |_ sidekick-docs
 
```
### 架设本地构建环境：

1. 安装VirtualBox和Vagrant

  下载和安装[VirtualBox](https://www.virtualbox.org/)

  下载和安装[Vagrant](https://www.vagrantup.com/)

1. 在终端安装(Windows的话，使用Git bash)，进入文档所在目录(docs)的`build`子目录:
```
$ cd build
and then
$ vagrant up
```

1. 以上步骤以后，虚拟机将被启动。链接到虚拟机开始构建：

```
$ vagrant ssh
$ cd /vagrant
$ ./build.sh
```

等待脚本运行完成后，在浏览器打开一下地址即可即时预览翻译结果:
```
http://localhost:8000/angular/start/introduction.html
```
