import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final String _fcnAddress = 'https://fcm.googleapis.com/fcm/send';
  final String _header = '"Content-Type:application/json"';
  final String _serverKey =
      "Authorization: key=AAAAx9eHzBY:APA91bFdb0cLCjUH4BrXl3BMmq1qEZBSIXf_WmpNvy3jYHAmtH0pifPmuyuOHnCguMWt2x1eNj9OtvIQtXYZJkQ0OfDvAuwlqrNj1g_eL--gU6z_DPnF_gmTR4sbejpwWLEMVQKElysq";

  //static String _deviceKey = "cq-1WzGNCHo:APA91bE-iEytWF1dKybuJescbJnhmdPYmv73sfAkmp8WhVWgDW0xBhEcJNCcQHm5ErASFZS-9fk2YGFl40MghmWgS7LkYJCNBfnIrxroro_ydoUFuUyG4FVXX96jpki63kiIXxWGGfYi";
  //String _data = '{"notification": {"body": "this is a body", "title": "title............"}, "priority": "high", "data": {"clickaction": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}, "to": $_deviceKey}';
//  String _data =
//      '{"notification": {"body": "this is a body", "title": "title............"}, "priority": "high", "data": {"clickaction": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}, "to":';
  //{"notification": {"body": "this is a body", "title": "title............"}

    String _data =
      ', "priority": "high", "data": {"clickaction": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}, "to":';

  //String _curl = '';
  Map<String,dynamic> _message = {};
  String _token;
  var txtFieldController = List.generate(2, (i) => TextEditingController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) {
      _token = token;



    });
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message ----- $message');
      //setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
      setState(() {
        _message =
            message;
        showAlertDialog(context);
      });

    }, onResume: (Map<String, dynamic> message) async {
      print('on resume ----- $message');
      //setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
      setState(() {
        _message =
            message;

      });
      showAlertDialog(context);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch ----- $message');
      //setState(() => _message = message["notification"]["title"] + message["notification"]["body"]);
      setState(() {
        _message = message;

      });
      showAlertDialog(context);
    });
  }

  @override
  void dispose() {
    txtFieldController.forEach((v)=>v.dispose());
    super.dispose();
  }
  @override
  void initState() {
    _register();
    getMessage();
    super.initState();

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
      title: Text(_message['notification']['body']),
      content: Text(_message['notification']['title']),
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
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:35),
              child: TextField(

                controller: txtFieldController[0],
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'Notification Title'
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:35),
              child: TextField(
                controller: txtFieldController[1],
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'Notification Body'
                ),
              ),
            ),

            FlatButton(
              onPressed: (){
                var _notificationData = '{"notification": {"body": "${txtFieldController[0].text}", "title": "${txtFieldController[1].text}"}';

                print('curl $_fcnAddress -H $_header -X POST -d \'$_notificationData $_data "$_token" }\'  -H "$_serverKey"');

              },
              color: Theme.of(context).accentColor,
              child: Text('Generate CURL statement'),
            )
          ],
        ),
      ),
    );
  }
}


////////////////////////////////////
////////////////////////////////////
////////////////////////////////////

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
