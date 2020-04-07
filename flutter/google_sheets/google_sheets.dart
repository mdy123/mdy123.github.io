
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        dividerTheme: DividerThemeData(
      color: Colors.red,
      endIndent: 15,
      indent: 25,
      space: 35,
      thickness: 5,
    )),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _url;
  Future<String> _result;
  final _formKey = GlobalKey<FormState>();
  final listTextController = List.generate(3, (i) => TextEditingController());
  final List<String> listFieldName = ['Name', 'Age', 'Email'];
  final List<Function> listFunction = [
    (String v) {
      if (v.isEmpty) return 'Enter Name';
      return null;
    },
    (String v) {
      if (v.isEmpty) return 'Enter Age';
      try {
        int.parse(v);
      } catch (FormatException) {
        return 'Enter number <125';
      }
      return null;
    },
    (String v) {
      if (v.isEmpty) return 'Enter Email';
      if (RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(v)) return null;
      return 'Wrong email format';
    }
  ];

  Future<String> _get(String p) async {
    var resBodyString = (await http.get((_url + p).trim())).body.toString();
    return resBodyString;
  }

  @override
  void initState() {
    _url =
        'https://script.google.com/macros/s/AKfycbwpatBFAmeTT9t70zgxxCmAd15nkAFj998OMnL3t7pheNbZ5Mw1/exec';
    _result = _get('');
    super.initState();
  }

  @override
  void dispose() {
    listTextController.forEach((v) {
      v.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          initialData: 'xxx,xxx,xxx',
          future: _result,
          builder: (context, snapshot) {
            var _l = snapshot.data.toString().split(',');
            var _l1 = [];
            for (var x = 0; x < _l.length; x = x + 3)
              _l1.add(_l.sublist(x, x + 3));

            return snapshot.hasData
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (d){
                                  setState(() {
                                    print('++++++++++  ${i+2}');
                                    _result = _get(
                                        '?addremove=${i+2}');
                                  });
                                },
                                direction: DismissDirection.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: _l1[i]
                                      .map<Widget>(
                                        (v) => Text('$v'),
                                      )
                                      .toList(),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: _l1.length),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              for (var x = 0; x < listFieldName.length; x++)
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('${listFieldName[x]}'),
                                      flex: 25,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: listFunction[x],
                                        controller: listTextController[x],
                                      ),
                                      flex: 75,
                                    ),
                                  ],
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: RaisedButton(
                                  child: Text('Add New Data'),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _result = _get(
                                            '?name=${listTextController[0].text}&age=${listTextController[1].text}&email=${listTextController[2].text}&addremove=add');
                                      });
                                    }

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : LinearProgressIndicator();
          }),
    );
  }
}
