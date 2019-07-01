import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'SingleChildScrollView',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 1,
            
// SingleChildScrollView => Axis.vertical => Column => height

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var x = 0; x < 15; x++)
                    Container(
                      height: 45,
                      color: x % 2 == 0 ? Colors.orange : Colors.blue,
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            
// SingleChildScrollView => Axis.horizontal  => Row => width

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var x = 0; x < 15; x++)
                    Container(
                      width: 45,
                      color: x % 2 == 0 ? Colors.green : Colors.brown,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
