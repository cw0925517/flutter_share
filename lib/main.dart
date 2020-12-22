import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'share_page.dart';
import 'flutter_social_content_share_page.dart';
import 'sharesdk_page.dart';

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

  List data = [
    'sharesdk_plugin分享',
    'share分享',
    'flutter_social_content_share分享'
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

  _click(index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShareSDKPage(title: 'sharesdk_plugin分享',)));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SharePage(title: 'share分享',)));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShareSocialPage(title: 'flutter_share_me分享',)));
    }
  }
}
