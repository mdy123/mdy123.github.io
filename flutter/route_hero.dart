import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Routing Hero App',
    initialRoute: '/',
    routes: {
      '/': (context) => PageOne(),
      '/pagetwo': (context) => PageTwo(),
    },
  ));
}

Widget genTitle(String s) {
  return AppBar(
    title: Text(s),
  );
}

Widget genContainer(double w, double h, Color c) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: c,
    ),
  );
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genTitle('PageOne'),
      body: Hero(
        tag: 'heroTag',
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/pagetwo');
          },
          child: genContainer(100, 100, Colors.red),
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genTitle('PageTwo'),
      body: Hero(
        tag: 'heroTag',
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageThree(),
              ),
            );
          },
          child: genContainer(200, 100, Colors.cyanAccent),
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genTitle('PageThree'),
      body: Hero(
        tag: 'heroTag',
        child: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
            child: genContainer(300, 100, Colors.amber)),
      ),
    );
  }
}
