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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Scarping'),
      ),
      body: FutureBuilder(
          future: _client
              .getUrl(Uri.parse('http://quotes.toscrape.com/page/5/'))
              .then((v) => v.close())
              .then((resp) => resp.toList())
              .then((v) => parser
                  .parse(utf8.decode(v[0]))
                  .body
                  .querySelectorAll('.text')),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: snapshot.data
                        .map((v) => ListTile(
                              title: Text('${v.text}'),
                            ))
                        .cast<Widget>()
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
    );
  }
}
