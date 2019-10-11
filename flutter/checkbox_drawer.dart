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
  var _cpu = {
    'Intel': {
      'cpuselect': {'select': false},
      '7 generation': {'select': false, 'i3': false, 'i5': false, 'i7': false},
      '8 generation': {'select': false, 'i3': false, 'i5': false, 'i7': false}
    },
    'amd': {
      'cpuselect': {'select': false},
      '2 generation': {
        'select': false,
        'ryzen 3': false,
        'ryzen 5': false,
        'ryzen 7': false
      },
      '3 generation': {
        'select': false,
        'ryzen 3': false,
        'ryzen 5': false,
        'ryzen 7': false
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    //print(_cpu['amd']['2 generation']['ryzen 3']);

    return Scaffold(
      appBar: AppBar(
        title: Text('CPU Select'),
      ),
      drawer: Drawer(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          for (var cpuType in _cpu.keys)
            CheckboxListTile(
              title: Text(cpuType.toUpperCase()),
              value: _cpu[cpuType]['cpuselect']['select'],
              onChanged: (b) {
                setState(() {
                  _cpu[cpuType]['cpuselect']['select'] = b;
                });
              },
              subtitle: _cpu[cpuType]['cpuselect']['select']
                  ? Column(
                      children: <Widget>[
                        for (var cpuSeries in _cpu[cpuType].keys)
                          if (cpuSeries != 'cpuselect')
                            CheckboxListTile(
                              title: Text(cpuSeries),
                              value: _cpu[cpuType][cpuSeries]['select'],
                              onChanged: (b) {
                                setState(() {
                                  _cpu[cpuType][cpuSeries]['select'] = b;
                                });
                              },
                              subtitle: _cpu[cpuType][cpuSeries]['select']
                                  ? Column(
                                      children: <Widget>[
                                        for (var cpuModel
                                            in _cpu[cpuType][cpuSeries].keys)
                                          if (cpuModel != 'select')
                                            CheckboxListTile(
                                                title: Text(cpuModel),
                                                value: _cpu[cpuType][cpuSeries]
                                                    [cpuModel],
                                                onChanged: (b) {
                                                  setState(() {
                                                    _cpu[cpuType][cpuSeries]
                                                        [cpuModel] = b;
                                                  });
                                                })
                                      ],
                                    )
                                  : Text(''),
                            )
                      ],
                    )
                  : Text(''),
            ),
        ],
      )),
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          'CPU',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
