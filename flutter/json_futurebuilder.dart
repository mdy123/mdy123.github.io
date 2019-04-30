import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Wrap Widget',
    initialRoute: '/',
    routes: {
      '/': (context) => PageOne(),
    },
  ));
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('json FutureBuilder'),
      ),
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/us_states.json'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<String> _l = [];
          jsonDecode(snapshot.data).forEach((k, v) => _l.add(v));
          return ListView.builder(
            itemCount: _l.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(index.toString() + '  -  ' + _l[index]),
              );
            },
          );
        },
      ),
    );
  }
}
