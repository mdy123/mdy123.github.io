import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Test App',
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
  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width / 8;
    List<Widget> _genContainer(int _s) {
      List<Widget> _cL = new List();
      for (int i = 0; i < 8; i++) {
        _cL.add(GestureDetector(
          onTap: (){
            print('Position  -  $_s,$i');
          },
          child: Container(
            width: _w,
            height: _w,
            color: (i + 1) % 2 == _s % 2 ? Colors.black : Colors.green,
          ),
        ));
      }
      return _cL;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
        ),
        body: ListView.builder(
          //itemCount: (List<int>.generate(8, (f)=>f)).length,
          //itemCount: [0, 1, 2, 3, 4, 5, 6, 7].length,
          //itemCount: new List(8).length,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Row(
              children: _genContainer(index),
            );
          },
        ));
  }
}
