import 'package:flutter/cupertino.dart';
///
///  share_page.dart
///  flutter_share
///
///  Created by CW on 12/22/20.
///  Copyright © 2020 wx. All rights reserved.
///

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

final ImagePicker _picker = ImagePicker();

final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);

class SharePage extends StatefulWidget {
  SharePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {

  PickedFile _imageFile;

  List data = [
    '文字分享',
    '图文分享',
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
  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {

    await _displayPickImageDialog(context,
            (double maxWidth, double maxHeight, int quality) async {
          try {
            final pickedFile = await _picker.getImage(
              source: source,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: quality,
            );
            setState(() {
              _imageFile = pickedFile;
            });
          } catch (e) {
            print(e.toString());
          }
        });
  }
  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                  InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                  InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                  InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
  ///Share plugin分享
  _share() {
    Share.share('http://img1.2345.com/duoteimg/qqTxImg/2012/04/09/13339485237265.jpg',subject: 'subject');
  }
  _shareFiles(){
    // Share.shareFiles([''],subject: 'subject',text: 'text');
  }
  _choosePhoto() async{
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        // imageQuality: quality,
      );
      // setState(() {
      //   _imageFile = pickedFile;
      // });
      Share.shareFiles([pickedFile.path],text: 'text',subject: 'subsject');
    } catch (e) {
      print(e.toString());
    }
  }
  _click(index) {
    if (index == 0) {
      _share();
    } else if (index == 1) {
      _choosePhoto();
    }
  }
}