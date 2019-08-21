import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Expandable Tile',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Indexed Stack'),
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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
            flex: 8,
            child: IndexedStack(
              index: _index,
              children: <Widget>[
                for (var x = 0; x < 28; x++)
                  Center(
                      child: Text(
                    x.toString(),
                    style: TextStyle(
                      fontSize: 75,
                    ),
                  )),
              ],
            )),
        Flexible(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (var x = 0; x < 9; x++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = x;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            color: Colors.blue[(x + 1) * 100],
                            width: 75,
                          ),
                          Container(
                            width: 75,
                            child: Center(
                              child: Text(
                                x.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ))
      ],
    );
  }
}
