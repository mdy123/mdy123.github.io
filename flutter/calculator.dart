import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculator',
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
  final List<List<String>> keys = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['0', '.', '%', '+']
  ];
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.orange,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
            Flexible(
                flex: 5,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: genKeys(),
                    ),
                    Flexible(
                      flex: 1,
                      child: genCancelBackEqual(),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget genKeys() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        for (var y = 0; y < 4; y++)
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              for (var x = 0; x < 4; x++)
                Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(
                          side: BorderSide(
                        color: Colors.grey,
                        width: 3,
                      )),
                      onPressed: null,
                      child: Text(
                        keys[y][x],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.brown,
                        ),
                      ),
                    )),
            ],
          ),
      ],
    );
  }

  Widget genCancelBackEqual() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        for (var x in ['C', 'B', '='])
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: FlatButton(
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: null,
                child: Text(
                  x,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.brown,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
