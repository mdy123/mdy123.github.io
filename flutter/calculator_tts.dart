import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  List<List<String>> keys = [];
  String formulaString;
  //List<String> disResult ;
  List<String> disResult;
  FlutterTts flutterTts = new FlutterTts();

  @override
  void initState() {
    keys = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['0', '.', '%', '+']
    ];
    formulaString = '';
    disResult = [];
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
              child: genDisResult(),
            ),
            Flexible(
              flex: 1,
              child: genFormula(),
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

  Widget genDisResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        for (var x = 0; x < disResult.length; x++)
          GestureDetector(
            onTap: () {
              setState(() {
                formulaString =
                    disResult[x].substring(0, disResult[x].indexOf('='));
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    disResult[x],
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget genFormula() {
    return Container(
      alignment: Alignment(0, 0),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 2), bottom: BorderSide(width: 2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            formulaString,
            style: TextStyle(
              color: Colors.brown,
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget genKeys() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var y = 0; y < 4; y++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var x = 0; x < 4; x++)
                Expanded(
                    child: FlatButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(
                      side: BorderSide(
                    color: Colors.grey,
                    width: 3,
                  )),
                  onPressed: () {
                    setState(() {
                      formulaString += keys[y][x];
                    });
                  },
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var x in ['C', 'B', '='])
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 3, right: 8, top: 15, bottom: 15),
              child: FlatButton(
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  if (formulaString.isNotEmpty) {
                    switch (x) {
                      case 'C':
                        setState(() {
                          formulaString = '';
                        });
                        break;
                      case 'B':
                        setState(() {
                          formulaString = formulaString.substring(
                              0, formulaString.length - 1);
                        });
                        break;
                      case '=':
                        flutterTts.setVolume(1.0);
                        flutterTts.speak(formulaString +
                            x +
                            calculate(formulaString).toString());

                        setState(() {
                          disResult.add(formulaString +
                              x +
                              calculate(formulaString).toString());

                          formulaString = '';
                        });

                        break;
                    }
                  }
                },
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

  double calculate(String s) {
    Map<String, Function> mathL = {
      '/': (x, y) => x / y,
      '*': (x, y) => x * y,
      '-': (x, y) => x - y,
      '+': (x, y) => x + y,
      '%': (x, y) => x % y
    };
    String key;
    for (var x in mathL.keys) {
      if (s.contains(x)) key = x;
    }
    double first = double.parse(s.substring(0, s.indexOf(key)));
    double second = double.parse(s.substring(s.indexOf(key) + 1, s.length));

    return mathL[key](first, second);
  }
}
