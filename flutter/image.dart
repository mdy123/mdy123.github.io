import 'package:flutter/material.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
        ),
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List allContents = [
    './assets/food.jpg',
    './assets/fremont.jpg',
    './assets/image.jpg'
  ];
  String _imgP = './assets/food.jpg';
  void _updateP(String p) {
    setState(() {
      _imgP = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Image(
            image: AssetImage(_imgP),
          ),
        ),
        Expanded(
            flex: 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allContents.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _updateP(allContents[index]);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Image(image: AssetImage(allContents[index]))),
                );
              },
            )),
      ],
    );
  }
}
