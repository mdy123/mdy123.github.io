import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Testing...',
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
        title: Text('Testing'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, bCount) {
                    return Container(
                      height: 45,
                      color: Colors.red[(bCount + 1) * 100],
                    );
                  },
                  separatorBuilder: (context, sCount) {
                    return Divider(
                      height: 5,
                    );
                  },
                  itemCount: 5)),
          Expanded(
              flex: 1,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, bCount) {
                    return Container(
                      width: 65,
                      color: Colors.red[(bCount + 1) * 100],
                    );
                  },
                  separatorBuilder: (context, sCount) {
                    return Divider(
                      height: 15,
                    );
                  },
                  itemCount: 5)),
        ],
      ),
    );
  }
}
