import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Wrap Widget',
    initialRoute: '/',
    routes: {
      '/': (context) => PageOne(),
    },
  ));
}

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final _colorList = [
    Colors.blue[100],
    Colors.blue[300],
    Colors.blue[500],
    Colors.blue[700],
    Colors.blue[900],
    Colors.blue[200],
  ];

  @override
  Widget build(BuildContext context) {
    print(_colorList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorderable Dismiss'),
      ),
      body: ReorderableListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 35, bottom: 45, left: 5, right: 5),
          children: <Widget>[
            for (var x = 0; x < _colorList.length; x++)
              Dismissible(
                background: Container(
                  height: 45,
                  color: Colors.red,
                  child: Icon(Icons.cancel),
                ),
                key: ValueKey(x),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    _colorList.removeAt(x);
                  });

                  print(_colorList.length);
                },
                child: Container(
                  key: ValueKey(x),
                  height: 45,
                  color: _colorList[x],
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            final _temp = _colorList[oldIndex];
            setState(() {
              _colorList[oldIndex] = _colorList[newIndex];
              _colorList[newIndex] = _temp;
            });
          }),
    );
  }
}
