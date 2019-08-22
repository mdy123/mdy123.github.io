import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Expandable Tile',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Radio Button'),
          ),
          body: MyApp(),
        );
      }
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _foodType = ['herbivore', 'carnivore', 'omnivore'];
  final _animal = {
    'snake': [0, 1, 2],
    'lion': [0, 1, 2],
    'bird': [0, 1, 2]
  };

  final _selected = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text(''),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      for (var x = 0; x < _foodType.length; x++)
                        Text(_foodType[x])
                    ],
                  ),
                ),
                for (var x = 0; x < _animal.length; x++)
                  ListTile(
                    leading: Text(_animal.keys.toList()[x]),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        for (var y = 0; y < 3; y++)
                          Radio(
                            value: _animal[_animal.keys.toList()[x]][y],
                            groupValue: _selected[x],
                            onChanged: (v) {
                              setState(() {
                                _selected[x] = v;
                              });
                            },
                          ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (var x = 0; x < _animal.length; x++)
                    Text(
                        '${_animal.keys.toList()[x]} is ${_foodType[_selected[x]]}')
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
