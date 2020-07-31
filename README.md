# music_flutter

模仿网易云播放器（目前只做了简单列表和播放页）

![demo1](./readme-images/demo1.png)

![demo2](./readme-images/demo2.png)

### 结构

#### main.dart

程序主入口，创建MaterialApp，使用 Store provider，使用了provider

#### home.dart  首页

目前就两个按钮，跳转到列表和收藏

#### list.dart 列表页

创建实例属性 player，这是个单例，在 widget 里介绍

在 initState 里 SchedulerBinding.instance.addPostFrameCallback 监听 player status 变化，因为在 build 的时候 setState 会报错，所以需要在渲染后监听。在 deactivate 取消监听。

在 initState 里调接口，获取歌曲列表

列表页右上角的action放一个正在播放的歌曲按钮，点击可以跳转播放页。

列表，正在播放的歌曲前面放一个播放icon，后面放一个收藏按钮，这里收藏使用全局的 Store

点击歌曲跳转到播放页。

获取接口返回值的时候，需要将普通json对象转换成强类型的对象数组，这不像js那么随意

#### favorList.dart  收藏页

与 list 基本相同，只展示 store 里收藏的歌曲

#### detail.dart 播放页

在 initState 里 SchedulerBinding.instance.addPostFrameCallback 监听 player 各种事件，deactivate 里移除

页面最底层是一个专辑背景图，上面是高斯模糊，然后是唱头和唱片旋转动画，在唱片上面盖一个点击手势

唱片下面是歌词widget，当歌曲发生变化时重新加载歌词创建新的对象

在下面是按钮，时间和Slider，监听 player 设置 Slider的值，和监听Slider设置player的duration

#### widget/lyricPannel.dart
 
 歌词 widget，监听 player 的 position，控制展示的歌词数组的索引。调整播放进度的时候重新设置 index

#### widget/player.dart

播放器组件，使用了 audioplayers

采用了单例模式，无论怎么 new 拿到的都是同一个实例，保证了全局唯一的播放实例

定义了 播放完成、报错、状态切换、获取到时长、进度改变、歌曲改变 等时间类型

监听方法就是往属性数组里push回调函数，触发的时候把数组里回调都执行一遍

#### utils/lyric.dart

把加载到的歌词字符串根据时间转换成数组

#### store/common.dart

全局store，更新调用 notifyListeners() 触发UI更新

将数据混存至本地，使用了 shared_preferences

#### model/audio.dart

定义了 audio model

注意 dart 不是 js，tojs，fromjs 需要自己写

#### model/lyric.dart

歌词 model

#### animate/disc.dart、pointer.dart、audioIcon.dart

唱片、唱头、列表页右上角正在播放歌曲icon的动画

[动画文档参考](https://book.flutterchina.club/chapter9/)

#### 其他

##### 父组件调用子组件方法
- 定义一个 GlobalKey 传给子组件作为key，key.currentState.function();
- 将子组件p作为实例属性，p里定义函数fn，pState 里给 widget.fn 赋值，父组件里就可以直接 p.fn();











