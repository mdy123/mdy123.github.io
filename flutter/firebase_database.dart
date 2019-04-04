import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async{
  final fs = Firestore();
  fs.settings(timestampsInSnapshotsEnabled: true);
  runApp(MaterialApp(
    title: 'FireBase',
    home: Scaffold(
      appBar: AppBar(title: Text('Pet Name Voting'),),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('name').snapshots(),
      builder: (context, snapshot){
        return ListView.builder(

          padding: EdgeInsets.only(top: 35.0),

          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(top: 5.0),
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border:Border.all(color: Colors.pink),
                  borderRadius: BorderRadius.circular(15.0)

              ),
              child: ListTile(

                title: Text(snapshot.data.documents[index]['name']),
                trailing: Text(snapshot.data.documents[index]['vote'].toString()),
                onTap: ()=>
                  snapshot.data.documents[index].reference.updateData({'vote': snapshot.data.documents[index]['vote']+1 }),
              ),
            );
          },
        );
      },
    );
  }
}
