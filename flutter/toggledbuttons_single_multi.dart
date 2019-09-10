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
  final List<bool> _selected = [false, true, false];
  bool _selectType = true;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggled Buttons'),
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  widget._selectType = !widget._selectType;
                });
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child:
                    Text(widget._selectType ? 'Single Select' : 'Multi Select',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
              ),
            ),
            Container(
              height: 85,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: ToggleButtons(
                color: Colors.deepOrange,
                borderColor: Theme.of(context).accentColor,
                fillColor: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                onPressed: (x) {
                  setState(() {
                    if (widget._selectType)
                      {
                       for(var y=0; y<widget._selected.length; y++)
                         widget._selected[y] = false;
                       widget._selected[x]= true;
                      } else {
                      widget._selected[x]= !widget._selected[x];
                    }


                  });
                },
                children: <Widget>[
                  Icon(Icons.title),
                  Icon(Icons.portrait),
                  Icon(Icons.access_alarm),
                ],
                isSelected: widget._selected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
