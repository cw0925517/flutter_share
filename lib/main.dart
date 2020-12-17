import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed:(){ _share(); },
          )
        ],
      ),
      body:Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton(
              onPressed: () { _getPrivacyPolicyUrl(); },
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              pressedOpacity: 0.5,
              disabledColor: Colors.blue,
              color: Colors.blueAccent,
              child: new Container(
                child: new Text('获取MobTech授权'),
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: Text(''),
            ),
            CupertinoButton(
              onPressed: () { _submitPrivacyGrantResult(); },
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              pressedOpacity: 0.5,
              disabledColor: Colors.blue,
              color: Colors.blueAccent,
              child: new Container(
                child: new Text('MobTech授权'),
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: Text(''),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

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
    register.setupLinkedIn("46kic3zr7s4n", "RWw6WRl9YJOcdWsj", "http://baidu.com");
    SharesdkPlugin.regist(register);

  }
  /// @param 隐私协议返回数据的格式
  /// POLICY_TYPE_URL = 1
  /// POLICY_TYPE_TXT = 2
  _getPrivacyPolicyUrl() {
    SharesdkPlugin.getPrivacyPolicy("1","en-CN", (Map data, Map error) {
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
        print("隐私协议"+policyData);
      } else if (errorStr != null) {
        print("隐私协议"+errorStr);
      } else {
        print("获取隐私协议失败");
      }
    });
  }
  /// 0 ===> 不同意隐私政策
  /// 1 ===> 同意
  _submitPrivacyGrantResult() {
    SharesdkPlugin.uploadPrivacyPermissionStatus(0, (bool success) {
      if(success == true) {
        print("隐私协议授权提交结果成功");
      } else {
        print("隐私协议授权提交结果失败");
      }
    });
  }
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

}
