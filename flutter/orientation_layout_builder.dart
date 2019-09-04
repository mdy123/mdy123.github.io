import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Orientation_Layout_Builder',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Orientation_Layout_Builder'),
          ),
          body: MyApp(),
        );
      },
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        isPortrait = orientation == Orientation.portrait ? true : false;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: <Widget>[
                for (var x = 0; x < (isPortrait ? 8 : 5); x++)
                  Container(
                    alignment: Alignment.center,
                    height:
                        constraints.constrainHeight() / (isPortrait ? 8 : 5),
                    color: isPortrait
                        ? Colors.green[(x + 1) * 100]
                        : Colors.blue[(x + 1) * 100],
                    child: Text(
                      x.toString(),
                      style: TextStyle(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        fontSize: 25,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
