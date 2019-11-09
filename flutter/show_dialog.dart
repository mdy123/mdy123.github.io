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
      'RouteToDialog': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Route to Dialog'),
          ),
          body: MyApp2(),
        );
      },
    },
  ));
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Route to Dialog'),
      content: Text('Using Route to Dialog'),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok')),
        FlatButton(onPressed: () {}, child: Text('Canel')),
      ],
    );
  }
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
String _title1 = 'AlertD Using AlertDialog';
String _title2 = 'AlertD Using ShowDialog';
String _title3 = 'AlertD Using Route';

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
              Container(
                width: MediaQuery.of(context).size.width / 2.15,
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Text('$_title1'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.15,
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text('$_title2'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.15,
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, 'RouteToDialog');
                  },
                  child: Text('$_title3'),
                ),
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
