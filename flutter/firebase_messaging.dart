import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  final String _fcnAddress = 'https://fcm.googleapis.com/fcm/send';
  final  String _header = '"Content-Type:application/json"';
  final  String _serverKey = "Authorization: key=AAAAx9eHzBY:APA91bFdb0cLCjUH4BrX_WmpNvy3jYHuyuOHnCguMWt2x1eNj9OtvIQtXYZJkQ0OfDvAuwlqrNj1g_eL--gU6z_DPnF_gmTR4sbejpwWLEMVQKElysq";
  
  //String _data = '{"notification": {"body": "this is a body", "title": "title............"}, "priority": "high", "data": {"clickaction": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}, "to": $_deviceKey}';
  String _data = '{"notification": {"body": "this is a body", "title": "title............"}, "priority": "high", "data": {"clickaction": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}, "to":';

  String _curl = '';
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) {

      _curl = 'curl $_fcnAddress -H $_header -X POST -d \'$_data "$token" }\'  -H "$_serverKey"';

        print(_curl);
    });
  }



  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
    });
  }

  @override
  void initState() {
    _register();
    super.initState();
    getMessage();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Message: $_message"),
                OutlineButton(
                  child: Text("Register My Device"),
                  onPressed: () {
                    _register();
                  },
                ),
                // Text("Message: $message")
              ]),
        ),
      ),
    );
  }
}
