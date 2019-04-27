import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Routing Hero App',
    initialRoute: '/',
    routes: {
      '/': (context) => PageOne(),
    },
  ));
}

class PageOne extends StatelessWidget {
  final imgList = [
    'food',
    'fremont',
    'image',
    'vegas',
    'mmap',
    'pagoda',
    'hollywood'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Fexible Wrap'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: imgList.length,
        itemBuilder: (BuildContext context, int index) {
          print('./assets/' + imgList[index] + '.jpg');
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            //width:  MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('./assets/' + imgList[index] + '.jpg'),
            ),
          );
        },
      ),
    );
  }
}
