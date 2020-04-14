import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';

//void main() => runApp(MaterialApp(
//  title: 'Insulin Calulator',
//  routes: {
//    '/': (context) => CupertinoPageScaffold(
//      child: MyApp(),
//      navigationBar: CupertinoNavigationBar(
//        border: Border.all(),
//        backgroundColor: Colors.blue,
//        middle: Text('Insulin Calculator'),
//      ),
//    )
//  },
//  initialRoute: '/',
//));

void main() => runApp(MaterialApp(
      title: 'Insulin Calulator',
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(
                title: Text('Insulin Dose Calculator', style: TextStyle(
                  fontSize: 18
                ),),
                centerTitle: true,
              ),
              body: MyApp(),
            )
      },
      initialRoute: '/',
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const double _columnPadding = 20.0;
  final _formKey = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  final _textEditingController = [
    TextEditingController(),
    TextEditingController()
  ];

  final Map<String, List<double>> fieldNames = {
    'Target B.G': List.generate(13, (i) => 80.0 + i * 10.0),
    'Sensitivity Factor': List.generate(19, (i) => 10.0 + i * 5.0),
    'Insulin-Carb Ratio': List.generate(40, (i) => 0.5 + i * 0.5),
  };

  Map<String, double> dropdownValue = {
    'Target B.G': 150.0,
    'Sensitivity Factor': 50.0,
    'Insulin-Carb Ratio': 10.0,
    'Carb (Grams)': 0,
    'Current B.G': 0,
  };

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.forEach((x) {
      x.dispose();
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  bool isNumeric(String str) {
    try {
      double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  double douseCal() {
    if (dropdownValue['Carb (Grams)'] == 0 || dropdownValue['Current B.G'] == 0)
      //if (dropdownValue['Current B.G'] == 0)
      return 0.0;
    else
      return ((dropdownValue['Current B.G'] - dropdownValue['Target B.G']) /
              dropdownValue['Sensitivity Factor']) +
          dropdownValue['Carb (Grams)'] / dropdownValue['Insulin-Carb Ratio'];
  }

  Widget genCarbCurrentBG(String x, int i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _columnPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              '$x',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: _textEditingController[i],
              keyboardType: TextInputType.number,
              onChanged: (v) {
                setState(() {
                  dropdownValue[x] =
                      _formKey[i].currentState.validate() ? double.parse(v) : 0;
                });
              },
              validator: (v) {
                if ((v.isEmpty) || !isNumeric(v) || double.parse(v) == 0) {
                  setState(() {
                    //i==0? dropdownValue[indexToKey]=0: dropdownValue[indexToKey]=0;
                    dropdownValue[x] = 0;
                  });

                  return '*';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _picker(String _title, List<double> _values) {
    return CupertinoPicker(
      //scrollController: _sc,
      backgroundColor: Colors.black87,
      itemExtent: 35,
      magnification: 1.5,
      children: _values
          .map<Widget>((v) => Text(
                '$v',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
          .toList(),
      onSelectedItemChanged: (v) {
        setState(() {
          dropdownValue[_title] = fieldNames[_title][v];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          padding: const EdgeInsets.only(top: 35, left: 50, right: 50),
          child: Column(
            children: <Widget>[
              for (var key in fieldNames.keys)
                Padding(
                  padding: const EdgeInsets.only(bottom: _columnPadding + 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$key',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${dropdownValue[key]}',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_drop_down),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  child: _picker(key, fieldNames[key]),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              Form(
                key: _formKey[0],
                child: genCarbCurrentBG('Carb (Grams)', 0),
              ),
              Form(
                key: _formKey[1],
                child: genCarbCurrentBG('Current B.G', 1),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(13),
                color: Colors.blue,
                alignment: Alignment.center,
                child: douseCal() != 0.0
                    ? Text(
                        '${douseCal().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${'No Result'}',
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
              )
            ],
          ));
    });
  }
}
