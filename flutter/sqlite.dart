import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Database db;
ScrollController _sc = new ScrollController();
List<TextEditingController> _textEController = [
  new TextEditingController(),
  new TextEditingController()
];
bool _show = true;
List<String> _lText = ['Add New', 'Delete All'];
final _formKey = GlobalKey<FormState>();
final RegExp _regExpName = RegExp('[a-zA-Z]');
final RegExp _regExpAge = RegExp(r'\d');

class _MyAppState extends State<MyApp> {
  void _initDB() async {
    db = await openDatabase('doggie_database.db');

//    await db.execute(
//      "CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
//    );
  }

  @override
  void initState() {
    _initDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SqLite',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SqLite AppBar'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Name   :   '),
                      Container(
                        width: constraints.constrainWidth() / 3,
                        child: TextFormField(
                          onTap: () {
                            print('On Tap============= Name');
                            if (_show) {
                              setState(() {
                                _show = false;
                              });
                            }
                          },
                          validator: (v) {
                            return (v.isEmpty)
                                ? 'Please enter some text'
                                : _regExpName.hasMatch(v)
                                    ? null
                                    : 'Please enter Charactor Only';
                          },
                          controller: _textEController[0],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Age     :   '),
                      Container(
                        width: constraints.constrainWidth() / 3,
                        child: TextFormField(
                          onTap: () {
                            print('On Tap============= Age');
                            if (_show) {
                              setState(() {
                                _show = false;
                              });
                            }
                          },
                          validator: (v) {
                            return (v.isEmpty)
                                ? 'Please enter some number'
                                : _regExpAge.hasMatch(v)
                                    ? null
                                    : 'Please enter number only';
                          },
                          controller: _textEController[1],
                        ),
                      ),
                    ],
                  ),
                  for (var x = 0; x < _lText.length; x++)
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Container(
                        width: constraints.constrainWidth() / 3.5,
                        color: Colors.red,
                        child: FlatButton(
                          onPressed: () {
                            switch (x) {
                              case 0:
                                {
                                  (_formKey.currentState.validate())
                                      ? () async {
                                          print(
                                              '${_formKey.currentState}  +++ ${_formKey.currentContext}');

                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());

                                          await db.rawQuery(
                                              'insert into dogs (name, age) values ( "${_textEController[0].value.toJSON()['text']}", ${_textEController[1].value.toJSON()['text']})');

                                          if (_show) {
                                            setState(() {
                                              _show = true;
                                            });
                                          }
                                        }()
                                      : Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Wrong Data'),
                                          ),
                                        );
                                }
                                break;
                              case 1:
                                {
                                  () async {
                                    await db.rawQuery('Delete from dogs');
                                    //setState(() {});
                                    if (_show) {
                                      setState(() {
                                        _show = true;
                                      });
                                    }
                                  }();
                                }
                                break;
                            }
                          },
                          child: Text(_lText[x]),
                        ),
                      ),
                    ),
                  (_show)
                      ? SingleChildScrollView(
                          controller: _sc,
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: 350,
                            child: FutureBuilder(
                                //future: db.rawQuery('Select * from dogs'),
                                future: Future.delayed(
                                    Duration(milliseconds: 250), () {
                                  return db.query('dogs');
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return ListView(
                                      scrollDirection: Axis.vertical,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('No Data'),
                                        )
                                      ],
                                    );
                                  } else {
                                    return ListView(
                                      scrollDirection: Axis.vertical,
                                      children: <Widget>[
                                        for (var x in snapshot.data)
                                          ListTile(
                                            leading: Text('${x['id']}'),
                                            title: Text('${x['name']}'),
                                            subtitle: Text('${x['age']}'),
                                          ),
                                      ],
                                    );
                                  }
                                }),
                          ),
                        )
                      : Text('no show'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
