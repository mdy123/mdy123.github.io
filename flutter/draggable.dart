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
  final List<Color> _cList = [Colors.red, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    final gWidget = new GWidget(_cList, _globalKey);
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
                  for (var x = 0; x < 3; x++) gWidget.gDraggable(_cList[x], x),
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
  List<Color> _cListCopy;
  GWidget(this._cListCopy, this._globalKeyCopy);
  Widget gDraggable(Color c, int x) {
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
      c = _cListCopy[data];
      _globalKeyCopy.currentState.showSnackBar(SnackBar(
          content:
              Text('Color changed to ${_cListCopy[data].value.toString()}')));
      print(data);
    }, builder: (context, List<int> candidateData, rejectedData) {
      return Container(
        color: c,
        width: 150,
        height: 150,
      );
    });
  }
}
