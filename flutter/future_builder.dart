import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test...',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Testing.......'),
        ),
        body: MyAppMain(),
      ),
    );
  }
}

class MyAppMain extends StatefulWidget {
  @override
  _MyAppMainState createState() => _MyAppMainState();
}

class _MyAppMainState extends State<MyAppMain> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: Future(_cal),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            //return Text('Result: ${snapshot.data}');
            return displayList(context, snapshot.data);
        }
        return null; // unreachable
      },
    );
    return futureBuilder;
  }

  Future<List<String>> _cal() async {
    var l = List<String>();
    l.add('ABC');
    l.add('DEF');
    l.add('HIJ');
    return l;
  }

  Widget displayList(BuildContext context, data) {
    List<String> d = data;
    return ListView.builder(
      itemCount: d.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment(0.5, 0.5),
          child: Center(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(d[index]),
                ),
                Divider(
                  color: Colors.black,
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
