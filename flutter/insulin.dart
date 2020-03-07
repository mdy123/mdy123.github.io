import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      title: 'Insulin Dose',
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(
                title: Text('Insulin Dose Calculation'),
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
  final _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final _textEditingController = [
    TextEditingController(),
    TextEditingController()
  ];

  final Map<String, List<double>> fieldNames = {
    'Target B.G': List.generate(13, (i) => 80.0 + i * 10.0),
    'Sensitivity Factor': List.generate(19, (i) => 10.0 + i * 5.0),
    'Insulin-Carb Ratio': List.generate(40, (i) => 0.5 + i * 0.5),
    //'Carb (Grams)': List.generate(20, (i) => 10.0 + i * 10.0),
    //'Current B.G': List.generate(13, (i) => 80.0 + i * 10.0),
  };

  Map<String, double> dropdownValue = {
    'Target B.G': 150.0,
    'Sensitivity Factor': 50.0,
    'Insulin-Carb Ratio': 10.0,
    'Carb (Grams)': 0,
    'Current B.G': 0,
  };
  //String indexToKey = 'Carb (Grams)';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text('$x'),
          flex: 4,
        ),
        Flexible(
          flex: 1,
          child: TextFormField(
            controller: _textEditingController[i],
            keyboardType: TextInputType.number,
            onChanged: (v) {
              print(_formKey[i]);

              setState(() {
                dropdownValue[x] =
                    _formKey[i].currentState.validate() ? double.parse(v) : 0;
              });
              print('$x -  ${dropdownValue[x]}');
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
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.only(top: 15, left: 50, right: 50),
          child: Column(children: [
            for (var key in fieldNames.keys)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$key'),
                  DropdownButton(
                      value: dropdownValue[key],
                      items: fieldNames[key].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue[key] = newValue;
                        });
                      }),
                ],
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
              color: Colors.red,
              alignment: Alignment.center,
              child: douseCal() != 0.0
                  ? Text(
                      '${douseCal().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    )
                  : Text(
                      '${'No Result'}',
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
            )
          ]),
        );
      },
    );
  }
}
