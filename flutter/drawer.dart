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
  final List<String> _items = ['CNN', 'BBC', 'YAHOO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      width: constraints.constrainWidth() / 3,
                      child: DrawerHeader(
                        decoration:
                            BoxDecoration(color: Theme.of(context).accentColor),
                        child: Text('Drawer'),
                      ),
                    ),
                    for (var x = 0; x < _items.length; x++)
                      SizedBox(
                        width: constraints.constrainWidth() / 3,
                        child: ListTile(
                          title: Text(_items[x]),
                          subtitle: Text('subtilte'),
                          //trailing: Text('trailing'),
                          leading: Icon(Icons.close),
                          onTap: () {
                            setState(() {
                              _items[x] != 'Tapped'
                                  ? _items[x] = 'Tapped'
                                  : _items[x] = _items[x];
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ),
                  ]);
            },
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              width: constraints.constrainWidth() / 2.5,
              height: constraints.constrainHeight() / 3,
              color: Colors.deepOrange,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var x in _items)
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(x),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
