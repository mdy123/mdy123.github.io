import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => MyApp()},
      title: 'Drawing',
    ));

final List<Offset> lOffset = [];

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var p = new Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 8;
    //canvas.drawLine(so, Offset(eo.dx, eo.dy - 24.0), p);
    //Rect r = const Offset(0, 0) & const Size(100, 50);
    //RRect rr = RRect.fromLTRBR(1, 5, 100, 250, Radius.elliptical(10, 80) );
    //canvas.drawRect(rect, paint)
    //canvas.drawCircle(Offset(200,350), 25, p);
    //canvas.drawRRect(rr, p);
    //canvas.drawLine(Offset(0,0), Offset(100,300), p);
    //canvas.drawImageRect(image, src, dst, paint)
    //canvas.drawRect(r, p);
    //canvas.drawArc(r, 85, 1, true, p);
    //canvas.drawParagraph(ParagraphBuilder(), offset)
    //canvas.drawPath(path, p);
    canvas.drawPoints(PointMode.points, lOffset, p);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawing')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            setState(() {
              lOffset.clear();
            });
          },
          child: Text('Clear')),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 50,
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (d) {
          setState(() {
            lOffset.add(Offset(d.globalPosition.dx, d.globalPosition.dy - 80));
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: MyPaint(),
          ),
        ),
      ),
    );
  }
}
