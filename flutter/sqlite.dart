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
bool _show = false;

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
    //print('DB.....');
    //print(db.rawQuery('Select * from dogs').runtimeType);

    return MaterialApp(
      title: 'SqLite',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SqLite AppBar'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Name   :   '),
                    Container(
                      width: constraints.constrainWidth() / 3,
                      child: TextFormField(
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
                        controller: _textEController[1],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                      width: constraints.constrainWidth() / 3.5,
                      color: Colors.red,
                      child: FlatButton(
                          onPressed: () async {
                            print(
                                '${_textEController[0].value.toJSON()["text"]}');
                            print(
                                '${_textEController[1].value.toJSON()['text'].runtimeType}');
                            await db.rawQuery(
                                'insert into dogs (name, age) values ( "${_textEController[0].value.toJSON()['text']}", ${_textEController[1].value.toJSON()['text']})');

                            //'insert into dogs (name, age) values ("yyy", 85)');
                            setState(() {});
                          },
                          child: Text('Add New'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                      width: constraints.constrainWidth() / 3.5,
                      color: Colors.red,
                      child: FlatButton(
                          onPressed: () async {
                            await db.rawQuery('Delete from dogs');
                            setState(() {});
                          },
                          child: Text('Delete All'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                      width: constraints.constrainWidth() / 3.5,
                      color: Colors.red,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _show = !_show;
                            });
                          },
                          child: Text('Disable Scroll'))),
                ),
                _show
                    ? SingleChildScrollView(
                        controller: _sc,
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 350,
                          child: FutureBuilder(
                              //future: db.rawQuery('Select * from dogs'),
                              future: db.query('dogs'),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return ListTile(
                                    title: Text('Has Error'),
                                  );
                                } else {
                                  return ListView(
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
                    : Text('Nothing'),
              ],
            );
          },
        ),
      ),
    );
  }
}
