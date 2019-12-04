import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: 'Default Asset Bundle',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Default Asset Bundle'),
          ),
          body: MyApp(),
        );
      },
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> _img;

  //final List<String> _keys= ['id', 'name', 'username', 'email', 'address', 'phone', 'website', 'company'];
//  Future<String> loadAsset() async {
//    return await rootBundle.loadString('images/config.json');
//  }

  @override
  Widget build(BuildContext context) {
    //DefaultAssetBundle.of(context).loadString('AssetManifest.json').then((v)=>print(jsonDecode(v)));
    //loadAsset().then((v)=>print(v));
    return Stack(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('AssetManifest.json'),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? () {
                              //print(Map.from(jsonDecode(snapshot.data)).keys.cast<String>().toList().where((v)=>v.startsWith('images/')).toList().runtimeType);
                              _img = Map.from(jsonDecode(snapshot.data))
                                  .keys
                                  .toList()
                                  .where((v) => v.startsWith('images/'))
                                  .cast<String>()
                                  .toList();

                              return Column(
                                children: <Widget>[
                                  for (var x in _img)
                                    Image.asset(
                                      './$x',
                                      height: constraints.constrainHeight() /
                                          _img.length,
                                      fit: BoxFit.fitHeight,
                                    )
                                ],
                              );
                            }()
                          : CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        // https://jsonplaceholder.typicode.com/users
        FutureBuilder(
            future: http
                .get('https://jsonplaceholder.typicode.com/users')
                .then((v) {
              return v.body;
            }),
            builder: (context, snapshot) {
              print(json.decode(snapshot.data).length.toString());
              return snapshot.hasData
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: Container(
                          width: (MediaQuery.of(context).size.width / 8) * 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (var x=0; x<json.decode(snapshot.data).length; x++)
                                (x==5)
                                    ?
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        color: Colors.grey,
                                        child:
                                        ListTile(
                                          title: Text('${json.decode(snapshot.data)[x]["name"]}'),
                                          subtitle: Text('${json.decode(snapshot.data)[x]["username"]}'),
                                        ),
                                      ),
                                    ],
                                  )

                                    :
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.grey,
                                  child:
                                  ListTile(
                                    title: Text('${json.decode(snapshot.data)[x]["name"]}'),
                                    subtitle: Text('${json.decode(snapshot.data)[x]["username"]}'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator();
            })
      ],
    );
  }
}
