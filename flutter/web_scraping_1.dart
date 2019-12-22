import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Web Scraping',
    initialRoute: '/',
    routes: {'/': (context) => MyApp()},
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HttpClient _client = HttpClient();
  
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Scarping'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            DropdownButton(
                iconEnabledColor: Colors.blue,
                value: selectedPage,
                items: List.generate(5, (idx) => idx + 1)
                    .map((v) =>
                        DropdownMenuItem(value: v, child: Text('Page : $v')))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selectedPage = v;
                  });
                }),
            FutureBuilder(
                future: _client
                    .getUrl(Uri.parse(
                        'http://quotes.toscrape.com/page/$selectedPage/'))
                    .then((v) => v.close())
                    .then((resp) => resp.toList())
                    .then((v) => parser
                        .parse(utf8.decode(v[0]))
                        .body
                        .querySelectorAll('.text')),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: ListTile.divideTiles(
                                  color: Colors.red,
                                  context: context,
                                  tiles: snapshot.data
                                      .map((v) => ListTile(
                                            title: Text(
                                              '${v.text}',
                                            ),
                                          ))
                                      .cast<Widget>()
                                      .toList())
                              .toList())
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 15,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
