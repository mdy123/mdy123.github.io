/*
Add to  Android Manifest
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

Add to gradle.properties
android.useAndroidX=true
android.enableJetifier=true
*/


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    title: 'Geo Distance',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  double d;
  String destAddress;

  @override
  void dispose() {
    // TODO: implement dispose
    textController.map((x) => x.dispose());
    super.dispose();
  }

  @override
  void initState() {
    d = 0.0;
    destAddress = '';
    super.initState();
  }

  Widget textFieldWdg(int i) {
    return TextField(
      autofocus: false,
      controller: textController[i],
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  void distanceCal(String x) {
    List<double> currentP = [];
    List<double> placeM = [];

    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currentPos) {
      currentP.add(currentPos.latitude);
      currentP.add(currentPos.longitude);
    }).whenComplete(() {
      Geolocator().placemarkFromAddress(x).then((placeMarkList) {
        placeM.add(placeMarkList[0].position.latitude);
        placeM.add(placeMarkList[0].position.longitude);
      }).whenComplete(() {
        Geolocator()
            .distanceBetween(currentP[0], currentP[1], placeM[0], placeM[1])
            .then((v) {
          setState(() {
            d = v;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Geo Distance'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Address : ',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: textFieldWdg(0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'City : ',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: textFieldWdg(1),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Zip : ',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: textFieldWdg(2),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: textFieldWdg(3),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Current position to \n $destAddress \n',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${d.toStringAsFixed(2)} Meters',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.stars),
                iconSize: 65,
                onPressed: () {
                  setState(() {
                    destAddress =
                        '${textController[0].text}, ${textController[1].text}, ${textController[2].text} ${textController[3].text}';
                  });

                  distanceCal(destAddress);

                  textController.forEach((x) => x.clear());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
