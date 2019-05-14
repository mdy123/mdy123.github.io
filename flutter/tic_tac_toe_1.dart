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
  final List<Color> playerColor = [Colors.amber, Colors.green];
  int playerNo = 0;
  List<List<Color>> _cll = [];

  @override
  void initState() {
    _cll = [
      [Colors.red, Colors.cyan, Colors.red],
      [Colors.cyan, Colors.red, Colors.cyan],
      [Colors.red, Colors.cyan, Colors.red]
    ];
    super.initState();
  }

  Widget buildBlock() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var y = 0; y < 3; y++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var x = 0; x < 3; x++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_cll[y][x] == Colors.red ||
                          _cll[y][x] == Colors.cyan) {
                        _cll[y][x] = playerColor[playerNo % 2];
                        playerNo++;
                      }
                    });
                  },
                  child: Container(
                    key: Key(y.toString() + x.toString()),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: _cll[y][x],
                    ),
                    child: Text('$y - $x'),
                  ),
                )
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 5,
          child: Container(
            child: buildBlock(),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        )
      ],
    ));
  }
}
