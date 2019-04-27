import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Wrap Widget',
    initialRoute: '/',
    routes: {
      '/': (context) => PageOne(),
    },
  ));
}

class PageOne extends StatelessWidget {
  final gList= new List<int>.generate(16, (item)=> item);


  Widget genContainer(BuildContext context) {
    return Wrap(

      direction: Axis.horizontal,
      children: gList.map((item){
        return Container(
          margin: EdgeInsets.all(5),
          //padding: EdgeInsets.all(5),
          color: Colors.amber,
          width: 100,
          height: 100,
          child: Text((item+1).toString(),
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        );
      }).toList(),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap Widget'),
      ),
      body: genContainer(context),
    );
  }
}
