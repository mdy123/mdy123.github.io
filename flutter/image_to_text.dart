import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MaterialApp(
    title: 'Image to Text',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File f;
  //String txt;
  final textEditingController = new TextEditingController();
  Future getImg(bool _choice) async {
    final _image = _choice
        ? await ImagePicker.pickImage(source: ImageSource.gallery)
        : await ImagePicker.pickImage(source: ImageSource.camera);
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_image);

    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    setState(() {
      f = _image;

      textEditingController.text = visionText.text;
    });
    print(visionText.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to Text'),
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
              flex: 6,
              child: Offstage(
                offstage: false,
                child: Center(
                  child: f == null
                      ? Text('Choose the image source.')
                      : Image(
                          image: FileImage(f),
                        ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      shape: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                      onPressed: () {
                        getImg(true);
                      },
                      child: Text(
                        'Gallary',
                        style: TextStyle(fontSize: 21),
                      )),
                  FlatButton(
                      shape: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                      onPressed: () {
                        getImg(false);
                      },
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 21),
                      )),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Offstage(
                offstage: false,
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        controller: textEditingController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: FlatButton(
                  onPressed: () async {
                    String url =
                        'https://www.google.com/search?q=${textEditingController.text}';
                    if (await canLaunch(url)) {
                      await launch(url).whenComplete(() {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Icon(
                    Icons.search,
                    size: 50,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
