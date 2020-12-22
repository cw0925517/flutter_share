## App接入第三方平台分享功能

[Facebook](https://developers.facebook.com/)

Appkey：379928436401822  AppSecret：d42f376a76098f440edb78ecb1165ff9

[Twitter](https://apps.twitter.com/) 

最好邮箱注册，可以接收审核信息。提交开发者申请后需要Twitter 审核确认才能进行下一步。

[Instagram ](http://bbs.mob.com/forum.php?mod=viewthread&tid=26412&page=1&extra=#pid68014)

Appkey：705322153471159   AppSecret： ce800655d1e13d563be4e5bb3e6586d4

[Line](http://bbs.mob.com/thread-23861-1-1.html)

Appkey：1655421842 AppSecret：ee2365a65e44be4803f375f9b0f851a3

[第三方平台注册](https://www.mob.com/wiki/detailed/?wiki=ios_third_party_register_process&id=14)

### (1) Flutter 接入ShareSDK

##### 账号：

Mob:  AppKey:31c91e2f9cf69   AppSecret:3c49255310b3fbda4c533cbe8bdca5a0

##### 一、在pubspec.yaml文件加入依赖

```
dependencies:
	sharesdk_plugin: ^1.2.8
```

然后执行 flutter packages get

在dart文件，引入头文件

```
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
```

##### 二、MobTech隐私服务流程接入

1、将MobTech隐私协议的URL嵌入app自身隐私协议描述中(推荐使用)

**推荐添加隐私策略文本**：为了实现分享和授权功能，我们使用了MobTech的ShareSDK产品，此产品的隐私策略条款，可以参考：http://www.mob.com/about/policy

2、将mobFoundation.framework更新到3.2.24及之后的版本（可以在项目根目录找到这个mob库，看里面的plist文件，里面有版本号），

iOS 端：需要在项目的info.plist文件里添加MOBNetLater参数配置，参数值配置为2

示例：

```
<key>MOBNetLater</key>
	<integer>2</integer>
```

[App Store Connect 后台配置](https://www.mob.com/wiki/detailed/?wiki=Mob_YSXY_QT_IOS___7&id=undefined/)

3、回传用户授权结果

当终端用户对隐私协议弹框做出选择后，无论同意还是拒绝，都应及时将授权结果回传给SDK。

dart文件调用示例：

```
	/// 0 ===> 不同意隐私政策
  /// 1 ===> 同意
  _submitPrivacyGrantResult() {
    SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {
      if(success == true) {
        print("隐私协议授权提交结果成功");
      } else {
        print("隐私协议授权提交结果失败");
      }
    });
  }
```

注：iOS调用返回false时，查看info.plist是否设置

```
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```

##### 三、IDFA

检查IDFA

1、打开终端cd到要检查的文件的根目录

2、执行下列语句：grep -r advertisingIdentifier . （别少了最后那个点号）

经检测，./PlatformSDK/FacebookSDK/FBSDKCoreKit.framework/FBSDKCoreKit 含有IDFA。

##### 提交 Appstore审核时关于IDFA的选项

（1）在 App 内投放广告

（2）将此 App 安装归因于先前投放的特定广告

（3）将此 App 中发生的操作归因于先前投放的特定广告

（4）iOS 中的“限制广告跟踪”设置

总结：

（1）如果你的应用里只是集成了广告，不追踪广告带来的激活行为，那么选择1和4；

（2）如果您的应用没有广告，而又获取了 IDFA。建议选择2和4，这种做法苹果官方没有明确说明，但目前为止还没有收		 到开发者选择2和4被拒的反馈。

#####  四、自定义需要导入的分享平台

1、AS中编辑位于External Libraries->Flutter Plugins->sharesdk_plugin-1.2.8->ios->sharesdk_plugin.podspec文件，具体支持的平台可以参阅``` pod search mob_sharesdk ```,或者参考官网

示例：

```
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sharesdk_plugin'
  s.version          = '1.1.2'
  s.summary          = 'Flutter plugin for ShareSDK.'
  s.description      = <<-DESC
  ShareSDK is the most comprehensive Social SDK in the world,which share easily with 40+ platforms.
                       DESC
  s.homepage         = 'http://www.mob.com/mobService/sharesdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mob' => 'mobproduct@mob.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'mob_sharesdk'
  s.dependency 'mob_sharesdk/ShareSDKExtension'
  s.dependency 'mob_sharesdk/ShareSDKUI'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/QQ'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChat'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Facebook'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Twitter'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Instagram'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Line'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/Douyin'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/Oasis'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/SnapChat'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/WatermelonVideo'
  #s.dependency 'mob_sharesdk/ShareSDKPlatforms/KuaiShou'
  #分享闭环
  #s.dependency 'mob_sharesdk/ShareSDKRestoreScene'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end
```

2、配置初始化AppKey和AppSecret

iOS端：在项目的info.plist中增加**MOBAppKey** 和 **MOBAppSecret** 两个字段

示例：

```
<key>MOBAppKey</key>
	<string>31c91e2f9cf69</string>
	<key>MOBAppSecret</key>
	<string>3c49255310b3fbda4c533cbe8bdca5a0</string>
```

3、配置对应平台的URL Scheme和白名单

URL Scheme:

Facebook：fb＋在facebook注册得到的ApiKey

Twitter：twitterkit- +在twitter注册得到的ConsumerKey

Instagram：

Line：line3rdp+Bundle id（可以直接固定line3rdp.$(PRODUCT_BUNDLE_IDENTIFIER)这样配置，后面的会自动显示项目的bundle id）

[URL Scheme全平台配置说明](http://www.mob.com/wiki/detailed?wiki=ShareSDK_ios_urlscheme_two&id=14)

白名单：

Facebook：

fbauth2
fbauth
fbapi20130214
fbapi
fbshareextension
fbapi20160328
fbapi20150629

Twitter：twitterauth

Instagram：instagram

Line：

lineauth2
line
lineauth
line3rdp.$(PRODUCT_BUNDLE_IDENTIFIER)

[白名单全平台配置说明](http://www.mob.com/wiki/detailed?wiki=ShareSDK_ios_whitelist_first&id=14)

##### 五、调用代码

dart文件初始化调用(咨询客服获知Line平台不需要初始化)

```
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    ShareSDKRegister register = ShareSDKRegister();
    register.setupInstagram('clientId', 'clientSecret', 'redirectUrl');
    register.setupFacebook(
        "1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
    register.setupTwitter("viOnkeLpHBKs6KXV7MPpeGyzE",
        "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
    SharesdkPlugin.regist(register);
  }
```

dart文件调用九宫格分享

```
///分享
  _share(){
    SSDKMap params = SSDKMap()
      ..setGeneral(
        "title",
        "text",
        [""],
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        null,
        "http://www.baidu.com",
        "http://www.mob.com",
        null,
        null,
        null,
        SSDKContentTypes.webpage,
      );
    List<ShareSDKPlatform> platforms = [
      ShareSDKPlatform(name: "facebook", id: 10),
      ShareSDKPlatform(name: "twitter", id: 11),
      ShareSDKPlatform(name: "instagram", id: 15),
      ShareSDKPlatform(name: "line", id: 42)
    ];
    SharesdkPlugin.showMenu(platforms, params, (SSDKResponseState state, ShareSDKPlatform platform,
        Map userData, Map contentEntity, SSDKError error) {
      print(state.toString());
      print(error.rawData.toString());
    });
  }
```

### (2) Flutter 接入Share plugin 

一、在pubspec.yaml文件加入依赖

```
dependencies:
	share: ^0.6.5+4
```

然后执行 flutter packages get

在dart文件，引入头文件

```
import 'package:share/share.dart';
```

dart文件调用

```
Share.share('check out my website https://example.com');
```

调用的分别是iOS 和 Android 原生分享。







