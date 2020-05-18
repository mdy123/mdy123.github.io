import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:location/location.dart';
import 'dart:math' as math;

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
  final oraclePark = [37.7786, -122.3894];
  //37.7785833 , -122.3894117,
  List<List<String>> coorList = [];

  var geoLocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 8000);
  var positionStream;

  String twoDecimal(String x) {
    return x.substring(0, x.indexOf('.') + 4);
  }

  _geoLocatorStream() {
    positionStream = geoLocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      if (position == null) {
        print('Unknown');
      } else {
        if (coorList.length == 0)
          setState(() {
            coorList.add([
              position.latitude.toString(),
              position.longitude.toString(),
              DateTime.now().minute.toString(),
              DateTime.now().second.toString()
            ]);
          });

        if (coorList.length != 0 &&
            twoDecimal(position.latitude.toString()) !=
                twoDecimal(coorList.last[0]) &&
            twoDecimal(position.longitude.toString()) !=
                twoDecimal(coorList.last[1]))
          setState(() {
            coorList.add([
              position.latitude.toString(),
              position.longitude.toString(),
              DateTime.now().minute.toString(),
              DateTime.now().second.toString()
            ]);
          });
                Geolocator().distanceBetween(position.latitude, position.longitude, oraclePark[0], oraclePark[1]).then((v) {
          print('+++++++++++++++++++++++++++  $v   --------------------');
          if (v < 215) {
            setState(() {
              coorList.add(['Arrive Destination.....']);
            });
            positionStream?.cancel();
            showAlertDialog(context);
          }
        }
        );
//        Geolocator().distanceBetween(double.parse(coorList.last[0]), double.parse(coorList.last[1]), oraclePark[0], oraclePark[1]).then((v) {
//          print('+++++++++++++++++++++++++++  $v   --------------------');
//          if (v < 215)
//            print('Arrive Destination.....');
//        }
//        );
        print(
            '${position.latitude} , ${position.longitude}, ${DateTime.now().minute} : ${DateTime.now().second}');
      }
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Mileage"),
      content: TextField(
        controller: TextEditingController(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    _geoLocatorStream();
                  },
                  child: Text('Start Streaming'),
                  color: Theme.of(context).accentColor),
              FlatButton(
                onPressed: () {
                  positionStream?.cancel();
                  print(coorList);
                  showAlertDialog(context);
                },
                child: Text(' End Streaming '),
                color: Theme.of(context).accentColor,
              ),
              coorList.isEmpty? Text('') :
                  Flexible(
                    child: ListView(
                      children: coorList.map((v)=>
                        ListTile(title: Text('$v'),)
                      ).toList(),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
