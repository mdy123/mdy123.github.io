import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Slider',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Slider'),
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
  double _v = 100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex (
            direction: Axis.vertical,

            children: <Widget>[

          Flexible(

            child: Slider(
              value: _v,
              onChanged: (v) {
                setState(() {
                  _v = v;
                });
              },
              min: 0,
              max: constraints.constrainWidth().round().toDouble(),
              label: '${_v.round()}',
              activeColor: Colors.amber,
              inactiveColor: Colors.blueAccent,
              divisions: constraints.constrainWidth().round(),
              onChangeEnd: (v) {
                //print('End $v');
              },
              onChangeStart: (v) {
                //print('Start $v');
              },
            ),
          ),
          Flexible(

            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(

                  height: 45,
                  width:  _v,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
