import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
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
  List<String> _cpu = ['Intel', 'AMD'];
  Map<String, List<String>> _intcpu = {
    '7 Generation': ['i3', 'i5', 'i7'],
    '8 Generation': ['i3', 'i5', 'i7']
  };
  Map<String, List<String>> _amdcpu = {
    '2 Generation': ['Ryzen 3', 'Ryzen 5', 'Ryzen 7'],
    '3 Generation': ['Ryzen 3', 'Ryzen 5', 'Ryzen 7']
  };
  Map<String, bool> _svCPU = new Map();
  Map<String, bool> _svIntel = new Map();
  Map<String, bool> _svAMD = new Map();

  @override
  void initState() {
    for (var x in _cpu) _svCPU.addAll({x: false});
    for (var x in _intcpu.keys) _svIntel.addAll({x: false});
    for (var x in _amdcpu.keys) _svAMD.addAll({x: false});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          for (var x in _cpu)
            CheckboxListTile(
              subtitle: _svCPU[x]
                  ? Column(
                      children: <Widget>[
                        for (var y
                            in (x == 'Intel' ? _intcpu.keys : _amdcpu.keys))
                          CheckboxListTile(
                            title: Text(y.toString()),
                            subtitle: (_intcpu.keys.contains(y) ? _svIntel[y]: _svAMD[y] )
                                ? Column(
                                    children: <Widget>[
                                      for (var z in (x == 'Intel' ? _intcpu[y] : _amdcpu[y]))
                                        CheckboxListTile(
                                            value: false,
                                            onChanged: (b){},
                                            title: Text(z),
                                            )
                                    ],
                                  )
                                : Text(''),
                            value: x == 'Intel' ? _svIntel[y] : _svAMD[y],
                            selected: x == 'Intel' ? _svIntel[y] : _svAMD[y],
                            onChanged: (b) {
                              setState(() {
                                x == 'Intel' ? _svIntel[y] = b : _svAMD[y] = b;
                              });
                            },
                          ),
                      ],
                    )
                  : Text(''),
              title: Text(x),
              dense: true,
              value: _svCPU[x],
              selected: _svCPU[x],
              onChanged: (b) {
                setState(() {
                  _svCPU[x] = b;
                });
              },
            ),
        ],
      )),
      appBar: AppBar(
        title: Text('BestBuy Laptop'),
      ),
      body: null,
    );
  }
}
