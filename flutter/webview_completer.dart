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
  @override
  Widget build(BuildContext context) {
    Completer<WebViewController> _controller = Completer<WebViewController>();
    
    return Scaffold(
      floatingActionButton: FutureBuilder(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> snapshot) {
            return FloatingActionButton.extended(
                onPressed: () {
                  snapshot.data.currentUrl().then((v) {
                    snapshot.data.loadUrl(v == 'https://dartpad.dartlang.org/'
                        ? 'https://pub.dev/packages/webview_flutter#-installing-tab-'
                        : 'https://dartpad.dartlang.org/');
                  });
                },
                label: Text('P'));
          }),
      appBar: AppBar(
        title: Text('Radio Button'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return WebView(
            initialUrl:
                'https://pub.dev/packages/webview_flutter#-installing-tab-',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
