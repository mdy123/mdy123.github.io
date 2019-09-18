import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'Expandable Tile',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return MyApp();
      }
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pvcontroller = new PageController();
  Completer<List<WebView>> _webv = Completer<List<WebView>>();

  @override
  void initState() {
    _webv.complete([
      for (var x = 0; x < 3; x++)
        WebView(
          initialUrl: 'https://jsonplaceholder.typicode.com/todos/${x + 1}',
          javascriptMode: JavascriptMode.unrestricted,

        )
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black26,
          onPressed: (){
            _pvcontroller.page == 2.0 ? Timer(Duration(milliseconds: 250), (){_pvcontroller.jumpToPage(0);}) :
            _pvcontroller.nextPage(duration: Duration(milliseconds: 250), curve: Curves.linear);

          }),

        appBar: AppBar(
          title: Text('Radio Button'),
        ),
        body: FutureBuilder(
          future: _webv.future,
          builder: (context, snapshots) {

            return PageView(
              controller: _pvcontroller,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for (var x in snapshots.data)
                  x,
              ],
            );
          },
        ),
    );
  }
}
