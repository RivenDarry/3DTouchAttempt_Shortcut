# 3DTouch开发实践の动态设置快捷访问Shortcuts的运用方案（Objective-C实现）
### 绪论
从iOS9开始，我们可以在主屏幕上用力的按一下APP图标，伴随着轻微的反馈，有的图标会弹出1至4个标签，点击这些标签，就可以直接在进入应用前选择你想快速访问的某一个页面，这就是ShortcutAction，本文统称它为「快捷访问」。
![快捷访问操作](http://upload-images.jianshu.io/upload_images/1481399-58430e4c215a7820.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###动态标签的价值
通过代码动态地设置标签的标题、子标题、图标，甚至是传值都极为方便，这也就意味着，程序内部可以和外部主屏的快捷访问进行某种互动。
这样一想我们其实可以实现很多新玩法，比如说签到功能，有一部分应用会有签到功能，每天都可以签一次，积分增加，同时如果连续几天签到还会有额外的积分加成。那么快捷访问就可以这么玩了：
1. 在用户今天还未签到时，显示「今日签到」；
2. 用户签到成功后，用代码动态的调整，让快捷标签显示为「已签到」；
3. 我们甚至可以再追加一个子标题，上面显示当前的积分；

![签到后的标签，以及动态添加的新标签](http://upload-images.jianshu.io/upload_images/1481399-dd42da0333acee35.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 有很多想象的空间
刚才说的只是其中的一个idea，当然可能性还有很多，比如开发者提供几个可选的快捷操作，让用户自己来定制要展示哪几个标签；再比如某些存放私密文件的APP，用户只能通过快捷访问进入，而应用内没有任何方法可以进入，只能选择是否显示这一可定制的标签，而这一个标签又和其他可供选择的标签一样，看不出有什么不同，从而达到保护隐私的目的。应该还有很多好玩的创意，正在阅读本篇文章的诸位如果有什么更新奇有趣的想法，不妨在下面留言，一起分享一下。

###动态标签的实现
说了这么多，那么究竟如何实现快捷访问呢？相关的好文章有很多，推荐一下这两篇文章[世界观]和[方法论]。这两篇文章已经讲得足够详备，因此本文主要是提炼一下骨架，既然是面向对象编程，那我们就来认识一下快捷访问Shortcut中的***对象们***吧。

快捷访问是一个在应用级别的操作，类似于图标右上角的红色提醒数字badgeNumber，因此，我们同样可以在程序对象***UIApplication***中，找到shortcut属性。
<pre><code> [UIApplication sharedApplication].shortcutItems</code></pre>
上面所写的shortcutItems是一个数组，里面存放着动态标签的最基本单元——标签项***UIApplicationShortcutItem***，它的相关属性如下。

<pre><code>@property (nonatomic, copy, readonly) NSString *type;</code>
<code>@property (nonatomic, copy, readonly) NSString *localizedTitle;</code>
<code>@property (nullable, nonatomic, copy, readonly) NSString *localizedSubtitle;</code>
<code>@property (nullable, nonatomic, copy, readonly) UIApplicationShortcutIcon *icon;</code>
<code>@property (nullable, nonatomic, copy, readonly) NSDictionary<NSString *, id <NSSecureCoding>> *userInfo;</code></pre>


- type：相当于标示符，用它来识别是哪一个标签；
- localizedTitle：标签标题；
- localizedSubtitle：标签的子标题；
- userInfo：信息字典，可用于传值；
- ***UIApplicationShortcutIcon***：标签的图标，系统提供了丰富的图标（约28种），包含在UIApplicationShortcutIconType枚举类型中，这个demo可以选择并展示所有的28种图标；当然除了系统的icon以外，也可以使用自定义的图片。

###静态标签
怎么说呢，如果你需要动态的可互动的标签，就不要使用静态标签，虽然他设置起来很简单，但是我们无法通过代码对静态标签进行任何的改变，因为我们根本无法在application单例的shortcuts数组中获取到静态的标签项，例如下面的代码如果运行在只有静态标签的程序中中只会显示数组元素为0.
<code><pre>
  NSArray *old =[UIApplication sharedApplication].shortcutItems;</code>
  <code>NSLog(@"%ld", (long)old.count);
</pre></code>

###Objective-C的实现小样
虽然前面提到的两篇文章已经写出了很多OC代码片段，但是由于苹果官方提供的demo只有swift版的，所以我本人才写了一个简单的OC版的demo，里面既运用到了动态标签，也是使用了静态标签的设置方法，以供参考。
