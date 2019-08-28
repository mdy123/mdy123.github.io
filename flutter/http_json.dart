import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

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
  final HttpClient _client = new HttpClient();

  var _s = {'userId': 0, 'id': 0, 'title': '', 'completed': false};

  _genData(x) {
    var _req = _client
        .getUrl(Uri.parse("https://jsonplaceholder.typicode.com/todos/" + x));
    _req.then((v) {
      v.close().then((_rep) {
        _rep.toList().then((v) {
          setState(() {
            _s = json.decode(utf8.decode(v[0]));
          });
        });
      });
    });
  }

  @override
  void initState() {
    _genData('1');
    super.initState();
  }

  final _dropdownItems = List.generate(8, (index) => index + 1);
  String _selectedItem = '1';

  List<DropdownMenuItem<String>> _genDDMenuItem() {
    final List<DropdownMenuItem<String>> _itemsList = [];
    for (var x in _dropdownItems)
      _itemsList.add(DropdownMenuItem(
        value: x.toString(),
        child: Text(
          '$x Page JSON Data',
          style: TextStyle(fontSize: 20),
        ),
      ));
    return _itemsList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
            value: _selectedItem,
            items: _genDDMenuItem(),
            onChanged: (v) {
              setState(() {
                _selectedItem = v;
                _genData(v);
              });
            }),
        Container(
          height: 45,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                for (var x in _s.keys)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$x',
                        style: TextStyle(fontSize: 20),
                      ),
                      x != 'title'
                          ? Text(
                              '${_s[x]}',
                              style: TextStyle(fontSize: 20),
                            )
                          :
                      (_s[x]).toString().length > 30 ?
                      Text(
                        (_s[x]).toString().substring(0, 30),
                        style: TextStyle(fontSize: 20),
                      ):
                            Text(
                              (_s[x]).toString().substring(0),
                              style: TextStyle(fontSize: 20),
                            ),
                    ],
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
