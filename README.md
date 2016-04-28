# TestkeyBord

this is a test demo
.a 合并命令  lipo -create release.a path debug.a path -output merge.a path
通过lipo –info libMJRefresh.a可以查看 .a 的类型（模拟器还是真机）
如果静态库中用到了图片资源，一般都放到一个bundle文件中，bundle名字一般跟 .a 或 .framework 名字一致

　　bundle的创建：新建一个文件夹，修改扩展名为 .bundle 即可，右击bundle文件，显示包内容，就可以往bundle文件中放东西
　建议：自己制作的静态库中要用到的图片资源，不建议直接以png的后缀名方式拖到项目中使用，而是推荐使用放到bundle文件中。这样可以避免静态库的图片名和使用静态库的项目中存在的图片产生冲突。

1）新建一个文件夹，把需要打包的资源图片放在里面
2）修改扩展名为 .bundle，敲回车，点击添加。

如果静态库中包含了Category，有时候在使用静态库的工程中会报“方法找不到”的错误（unrecognized selector sent to instance）

解决方案：在使用静态库的工程中配置Other Linker Flags为-ObjC
