import 'package:flutter/cupertino.dart';
///
///  flutter_social_content_share_page.dart
///  flutter_share
///
///  Created by CW on 12/22/20.
///  Copyright © 2020 wx. All rights reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';

class ShareSocialPage extends StatefulWidget {
  ShareSocialPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ShareSocialPageState createState() => _ShareSocialPageState();
}

class _ShareSocialPageState extends State<ShareSocialPage> {

  List data = [
    'Facebook分享',
    // 'Twitter分享',
    // 'Instagram分享'
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
  _facebookShare() async{
    String result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://www.apple.com",
        quote: "captions");
    print(result);
  }
  _instagramShare() async{
    String result = await FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl,
        imageUrl:
        "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
    print(result);
  }

  _click(index){
    if(index == 0){
      _facebookShare();
    }else if(index == 1){
      _instagramShare();
    }
  }
}