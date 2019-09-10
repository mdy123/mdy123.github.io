import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Slider',
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
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.ac_unit),
          title: Text('Wrap'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: Wrap(
          direction: Axis.horizontal,
          spacing: 85,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_alarm,
              size: 45,
            ),
            Icon(
              Icons.access_time,
              size: 45,
            ),
            Icon(
              Icons.title,
              size: 45,
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                for (var x = 0; x < _count; x++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (x > 0 && x == _count - 1) ? _count-- : _count++;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: (x % 5)== 0 ? 2.5 : 5,
                          right: (x % 5)== 4 ? 2.5 : 0,
                          top: 5),
                      width:  (constraints.constrainWidth() / 5)-5,
                      height: (constraints.constrainHeight() / 5)-5,
                      color: Colors.deepOrange,
                    ),
                  )
              ],
            ),
          );
        }));
  }
}
