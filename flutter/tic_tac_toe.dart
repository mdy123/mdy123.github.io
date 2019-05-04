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
  List<List<Color>> _colorList;
  //= List<List<Color>>.generate(3,(x)=> List<Color>.generate(3, (y)=> x % 2 == y % 2 ? Colors.black : Colors.green,));
  int _player;
  String _result;

  @override
  void initState() {
    _colorList = List<List<Color>>.generate(
        3,
        (x) => List<Color>.generate(
              3,
              //(y) => x % 2 == y % 2 ? Colors.black : Colors.green,
              (y) => Colors.cyan,
            ));
    _player = 0;
    _result =' ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width / 3;

    Color _colorChange(int x, int y) {
      Color _c;
      if (_colorList[x][y] == Colors.cyan) {
        _c = _player == 0 ? Colors.red : Colors.amber;
      }
      return _c;
    }

    List<Widget> _genContainer(int _s) {
      List<Widget> _cL = new List();
      for (int i = 0; i < 3; i++) {
        _cL.add(GestureDetector(
          onTap: () {
            print('Position  -  $_s,$i');
            if (_colorList[_s][i] == Colors.cyan) {
              setState(() {
                _colorList[_s][i] = _colorChange(_s, i);
                _player = _player == 0 ? 1 : 0;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: _colorList[_s][i],
                border: Border.all(
                  color: Colors.red,
                )),

            width: _w,
            height: _w,
            //color: (i + 1) % 2 == _s % 2 ? Colors.black : Colors.green,
          ),
        ));
      }
      return _cL;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 7,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    children: _genContainer(index),
                  );
                }),
          ),
          Flexible(
            flex: 1,
            child:  Text('Player ${_player + 1}',
              style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold,
              ),

            ),
          ),
          Flexible(
            flex: 1,
            child:  Text(_result,
              style: TextStyle(fontSize: 25,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),
        ],
      ),
    );
  }
}
