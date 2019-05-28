import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Dragable',
      initialRoute: '/',
      routes: {'/': (context) => MyApp1()},
    ),
  );
}

class MyApp1 extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  final Map<String, Color> _mList = {
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green
  };
  @override
  Widget build(BuildContext context) {
    final gWidget = new GWidget(_mList, _globalKey);
    Color _dTargetColor = Colors.deepPurpleAccent;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Draggable'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, -1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var x in _mList.keys) gWidget.gDraggable(_mList[x], x),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: gWidget.gDragTarget(_dTargetColor),
            )
          ],
        ),
      ),
    );
  }
}

class GWidget {
  final double _size = 85;
  GlobalKey<ScaffoldState> _globalKeyCopy;

  Map<String, Color> _mListCopy;
  GWidget(this._mListCopy, this._globalKeyCopy);
  Widget gDraggable(Color c, String x) {
    return Draggable(
        data: x,
        childWhenDragging: gContainer(Colors.transparent),
        feedback: gContainer(c),
        child: gContainer(c));
  }

  Widget gContainer(Color c) {
    return Container(
      color: c,
      height: _size,
      width: _size,
    );
  }

  Widget gDragTarget(Color c) {
    return DragTarget(onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      c = _mListCopy[data];
      _globalKeyCopy.currentState
          .showSnackBar(SnackBar(content: Text('Color changed to $data')));
      print(data);
    }, builder: (context, List<String> candidateData, rejectedData) {
      return Container(
        color: c,
        width: 150,
        height: 150,
      );
    });
  }
}
