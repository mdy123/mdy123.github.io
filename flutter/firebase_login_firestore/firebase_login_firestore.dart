import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    title: 'Firebase Autentication & Firestore',
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firebase'),
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

var _colt;

bool _firstLoad = true;

bool _new = true;

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  //print("signed in " + user.displayName);
  return user;
}

List<Widget> genWidget(List<DocumentSnapshot> docs) {
  var _l = docs
      .map<Widget>((v) => GestureDetector(
            key: ValueKey(v.documentID),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 100,
                    child: ListTile(
                      title: Text(v['name']),
                    )),
                Expanded(
                    child: ListTile(
                  title: Text(v['email']),
                ))
              ],
            ),
          ))
      .toList();
  _l.add(Padding(
    padding: const EdgeInsets.only(top: 45),
    child: Center(
        child: Text(
      _new ? 'New user created in firestore. ' : 'Old User',
      style: TextStyle(fontSize: 25, color: Colors.red),
    )),
  ));
  return _l;
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _googleSignIn.isSignedIn().then((v) => _googleSignIn.signOut());

    _firstLoad = true;
    _colt = Firestore.instance.collection('f_store');

    super.initState();
  }

  @override
  void dispose() {
    _googleSignIn.signOut();

    super.dispose();
  }

  void checkAdd(String _mail, String _n) async {
    var docs = await _colt.where('email', isEqualTo: _mail).getDocuments();
    if (docs.documents.isEmpty) {
      docs = await _colt.getDocuments();
      var l = docs.documents
          .map((v) => int.parse(v.documentID.split('_')[1]))
          .cast<int>()
          .toList();

      _colt
          .document('user_${l.last + 1}')
          .setData({'email': _mail, 'name': _n});
      setState(() {
        _new = true;
      });
    } else {
      setState(() {
        _new = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _firstLoad
        ? Center(
            child: FlatButton(
                child: Image.asset('assets/google_signin.png'),
                onPressed: () async {
                  _handleSignIn().then((FirebaseUser user) {
                    checkAdd(user.email, user.displayName);
                    setState(() {
                      _firstLoad = false;
                    });

                    print(
                        'Success -  ${user.email}  ${user.uid}  ${user.phoneNumber}  ${user.displayName}');
                  }).catchError((e) => print('Fail  - $e'));
                }))
        : StreamBuilder(
            stream: _colt.snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) return LinearProgressIndicator();
              if (snap.data.documents.isEmpty) return Text('New User');
              return ListView(
                children: genWidget(snap.data.documents),
              );
            },
          );
  }
}
