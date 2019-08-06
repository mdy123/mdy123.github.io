import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Expandable Tile',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Expandable Tile'),
          ),
          body: MyApp(),
        );
      }
    },
  ));
}

Widget genWidget(MaterialColor c, String s) {
  return Stack(
    children: <Widget>[
      Container(
        color: c[100],
      ),
      Align(
          alignment: Alignment.center,
          child: Text(
            s,
            style: TextStyle(fontSize: 45),
          )),
    ],
  );
}

class Destination {
  const Destination(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.pink),
  Destination('Business', Icons.business, Colors.orange),
  Destination('School', Icons.school, Colors.amber),
  Destination('Flight', Icons.flight, Colors.red),
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: genWidget(allDestinations[_position].color,
                allDestinations[_position].title),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: BottomNavigationBar(
                    currentIndex: _position,
                    onTap: (v) {
                      setState(() {
                        _position = v;
                      });
                    },
                    items: [
                      for (var x in allDestinations)
                        BottomNavigationBarItem(
                          title: Text(x.title),
                          icon: Icon(x.icon),
                          backgroundColor: x.color,
                        )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
