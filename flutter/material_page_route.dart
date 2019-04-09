import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App One'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('One'),
        onPressed: () {
          var r = MaterialPageRoute(
            builder: (BuildContext context) {
              return MyApp2();
            },
          );
          Navigator.of(context).push(r);
        },
      ),
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Two'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Two'),
        onPressed: () {
          var r = MaterialPageRoute(
            builder: (BuildContext context) {
              return MyApp1();
            },
          );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
