import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Form TextFormField'),
          ),
          body: MyApp(),
        );
      }
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RegExp expEmail = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final RegExp expPhone = new RegExp(r"^[2-9]\d{2} \d{3} \d{4}$");
  final List<String> _names = ['Full Name', 'Email     ', 'Phone    '];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  for (var x in _names)
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(x),
                          Container(
                            child: TextFormField(
                              validator: (v) {
                                String returnValue;
                                switch (x.trim()) {
                                  case 'Full Name':
                                    {
                                      v.isEmpty
                                          ? returnValue =
                                              'Please enter some text'
                                          : returnValue = null;
                                    }
                                    break;
                                  case 'Email':
                                    {
                                      if (v.isEmpty) {
                                        returnValue = 'Please enter some text';
                                      } else if (!expEmail.hasMatch(v)) {
                                        returnValue =
                                            'Wrong Email Format. xxx@gmail.com';
                                      } else {
                                        returnValue = null;
                                      }
                                    }
                                    break;
                                  case 'Phone':
                                    {
                                      if (v.isEmpty) {
                                        returnValue = 'Please enter some text';
                                      } else if (!expPhone.hasMatch(v)) {
                                        returnValue =
                                            'Wrong Phone Format. xxx xxx xxxx';
                                      } else {
                                        returnValue = null;
                                      }
                                    }
                                    break;
                                }
                                return returnValue;
                              },
                            ),
                            width: constraints.constrainWidth() / 1.5,
                          ),
                        ],
                      ),
                    ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        print('Complete......');
                        FocusScope.of(context).requestFocus(new FocusNode());

                    },
                    child: Text('Submit'),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
