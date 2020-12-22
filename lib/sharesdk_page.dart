///
///  sharesdk_page.dart
///  flutter_share
///
///  Created by CW on 12/22/20.
///  Copyright © 2020 wx. All rights reserved.
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class ShareSDKPage extends StatefulWidget {
  ShareSDKPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ShareSDKPageState createState() => _ShareSDKPageState();
}

class _ShareSDKPageState extends State<ShareSDKPage> {
  List data = [
    'MobTech授权',
    '获取MobTech授权内容',
    'Facebook分享',
    'Twitter分享',
    'Instagram分享',
    'Line分享',
    'ShareSDK九宫格分享',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                CupertinoButton(
                  onPressed: () {
                    _click(index);
                  },
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  pressedOpacity: 0.5,
                  disabledColor: Colors.blue,
                  color: Colors.blueAccent,
                  child: new Container(
                    child: new Text(data[index]),
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Text(''),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  @override
  void initState() {
    //line平台不需要初始化
    // TODO: implement initState
    super.initState();

    ShareSDKRegister register = ShareSDKRegister();

    register.setupInstagram('705322153471159',
        'ce800655d1e13d563be4e5bb3e6586d4', 'https://www.mob.com/');
    register.setupFacebook(
        '379928436401822', 'd42f376a76098f440edb78ecb1165ff9', 'Savvy');
    register.setupTwitter("viOnkeLpHBKs6KXV7MPpeGyzE",
        "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
    register.setupQQ('1111324330', 'xwRL0KMrwVrcegMd');

    SharesdkPlugin.regist(register);
  }

  /// @param 隐私协议返回数据的格式
  /// POLICY_TYPE_URL = 1
  /// POLICY_TYPE_TXT = 2
  _getPrivacyPolicyUrl() {
    SharesdkPlugin.getPrivacyPolicy("1", "en-CN", (Map data, Map error) {
      String policyData, errorStr;
      if (data["data"] != null) {
        policyData = data["data"];
        print("==============>policyData " + policyData);
      }

      if (error != null) {
        errorStr = error["error"];
        print("==============>errorStr " + errorStr);
      }

      if (policyData != null) {
        print("隐私协议" + policyData);
      } else if (errorStr != null) {
        print("隐私协议" + errorStr);
      } else {
        print("获取隐私协议失败");
      }
    });
  }

  /// 0 ===> 不同意隐私政策
  /// 1 ===> 同意
  _submitPrivacyGrantResult() {
    SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {
      if (success == true) {
        print("隐私协议授权提交结果成功");
      } else {
        print("隐私协议授权提交结果失败");
      }
    });
  }

  ///Facebook
  ///FacebookSDK会尝试向“https://graph.facebook.com/v6.0”发送数据
  ///因为在国内无法连接graph.facebook.com这个地址，所以它的SDK会频繁重试，发起网络连接，自然耗电就上去了
  _facebookShare() {
    SSDKMap params = SSDKMap()
      ..setFacebook(
        "title",
        [""],
        "http:baidu.com",
        'urlTitle',
        'urlName',
        "http://www.baidu.com",
        'hasTag',
        'quote',
        SSDKFacebookShareType(value: 1),
        SSDKContentTypes.webpage,
      );

    SharesdkPlugin.share(ShareSDKPlatforms.facebook, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          print('state:' + state.toString());
          print('err:' + error.rawData.toString());
          print('context:' + contentEntity.toString());
        });
  }

  ///Twitter
  _twitterShare() {
    SSDKMap params = SSDKMap()
      ..setTwitter('titles', [""], 'video', 0.0, 0.0, SSDKContentTypes.webpage);
    SharesdkPlugin.share(ShareSDKPlatforms.twitter, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          print('state:' + state.toString());
          print('err:' + error.rawData.toString());
          print('context:' + contentEntity.toString());
        });
  }

  ///Instagram
  _instagramShare() {
    SSDKMap params = SSDKMap()
      ..setGeneral(
        "title",
        null,
        ["http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg"],
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        "http://www.baidu.com",
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        null,
        null,
        null,
        "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
        SSDKContentTypes.image,
      );
    SharesdkPlugin.share(ShareSDKPlatforms.instagram, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          print('state:' + state.toString());
          print('err:' + error.rawData.toString());
          print('context:' + contentEntity.toString());
        });
  }

  ///Line
  _lineShare() {
    SSDKMap params = SSDKMap()
      ..setGeneral(
        "title",
        null,
        ["http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg"],
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        "http://www.baidu.com",
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        null,
        null,
        null,
        "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
        SSDKContentTypes.image,
      );
    SharesdkPlugin.share(ShareSDKPlatforms.line, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          print('state:' + state.toString());
          print('err:' + error.rawData.toString());
          print('context:' + contentEntity.toString());
        });
  }

  ///ShareSDK九宫格分享
  _menuShare() {
    SSDKMap params = SSDKMap()
      ..setGeneral(
        "title",
        "text",
        ["http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg"],
        "http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg",
        "http://www.baidu.com",
        null,
        "http://www.mob.com",
        null,
        null,
        null,
        SSDKContentTypes.auto,
      );

    List<ShareSDKPlatform> platforms = [
      ShareSDKPlatform(name: "qq", id: 24),
      ShareSDKPlatform(name: "facebook", id: 10),
      ShareSDKPlatform(name: "twitter", id: 11),
      ShareSDKPlatform(name: "instagram", id: 15),
      ShareSDKPlatform(name: "line", id: 42)
    ];
    SharesdkPlugin.showMenu(platforms, params, (SSDKResponseState state,
        ShareSDKPlatform platform,
        Map userData,
        Map contentEntity,
        SSDKError error) {
      print('state:' + state.toString());
      print('err：' + error.rawData.toString());
    });
  }
  _click(index) {
    if (index == 0) {
      _submitPrivacyGrantResult();
    } else if (index == 1) {
      _getPrivacyPolicyUrl();
    } else if (index == 2) {
      _facebookShare();
    } else if (index == 3) {
      _twitterShare();
    } else if (index == 4) {
      _instagramShare();
    } else if (index == 5) {
      _lineShare();
    } else if (index == 6) {
      _menuShare();
    }
  }
}