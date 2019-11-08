import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Alert Dialog',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Alert Dialog AppBar'),
          ),
          body: MyApp1(),
        );
      },
    },
  ));
}

void _showDialog(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert Dialog'),
          content: Text('Alert Dialog Using ShowDialog'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok')),
            FlatButton(onPressed: () {}, child: Text('Cancel')),
          ],
        );
      });
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

int _index = 0;

class _MyApp1State extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
                child: Text('AlertD Using AlertDialog  '),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  _showDialog(context);
                },
                child: Text('AlertD Using ShowDialog'),
              ),
            ],
          ),
        ),
        AlertDialog(
          title: Text('Alert Dialog'),
          content: Text('Alert Dialog Using Stack'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                child: Text('Ok')),
            FlatButton(onPressed: () {}, child: Text('Cancel')),
          ],
        )
      ],
    );
  }
}
