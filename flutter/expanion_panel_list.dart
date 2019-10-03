import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
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
  var _url = "https://jsonplaceholder.typicode.com/todos/";

  List<Map> _ls = <Map>[];
  bool _isExpanded = false;

  _genData(int x) {
    HttpClient().getUrl(Uri.parse(_url + x.toString())).then((v) {
      v.close().then((_rep) {
        _rep.toList().then((v) {
          setState(() {
            _ls.add(json.decode(utf8.decode(v[0])));
          });
        });
      });
    });
  }

  @override
  void initState() {
    for (var x = 0; x < 3; x++) _genData(x + 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ExpansionPanelList(
        expansionCallback: (i, b) {
          setState(() {
            _isExpanded = !b;
          });
        },
        children: <ExpansionPanel>[
          for (var x in _ls)
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _isExpanded,
              headerBuilder: (context, b) {
                return ListTile(
                    onTap: () {
                      setState(() {
                        _isExpanded = !b;
                      });
                    },
                    leading: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('ID '),
                          Text('${x['id']}'),
                          Text('UserId'),
                          Text('${x['userId']}'),
                        ],
                      ),
                    ));
              },
              body: ListTile(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Title'), Text('${x['title']}')],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
