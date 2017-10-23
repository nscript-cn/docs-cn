

### 克隆必须的资源库：

1. 克隆`NativeScript/docs`库 (e.g. under ..\work\NativeScript\docs)，切换到`kkotorov/allow-local-builds`分支（我们需要将docs-cn库合并一下`NativeScript/Docs`的`kkotorov/allow-local-builds`分支，看看都有什么设置上的变化。合并后，即可替换成doc-cn 库。等有空了我合并一下，请暂时用官方这个做实验）
1. 克隆`NativeScript/NativeScript`库(e.g. under ..\work\NativeScript\NativeScript)
1. 克隆`NativeScript/nativescript-sdk-examples-ng`库(e.g. under ..\work\NativeScript\nativescript-sdk-examples-ng)
1. 克隆`NativeScript/sidekick-docs`库(e.g. under ..\work\NativeScript\sidekick-docs)

### 克隆完后的文件结构：

文件结构应该如下:
```
..\work

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

1. 在终端安装(Windows的话，使用Git bash)，进入文档所在目录的`build`子目录:
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
