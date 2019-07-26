import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    title: 'SingleChildScrollView',
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
  final _textFieldController = new TextEditingController();

  final _googleUri = 'https://www.google.com/maps/search/';
  String _searchString = 'indian+food/';
  String _location = '@37.5250163,-121.9429733,13z/';
  final _dataPre = ['!4m2!2m1', '!4m4!2m3!5m1', '!4m5!2m4!5m2'];
  final _dataLast = '!6e5';
  List<Color> _$Color = [Colors.grey, Colors.grey, Colors.grey, Colors.grey];
  List<Color> _starColor = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];
  List<String> _starCount = [
    '  2\nstars',
    ' 2.5\nstars',
    '  3\nstars',
    ' 3.5\nstars',
    '  4\nstars',
    ' 4.5\nstars'
  ];
  final _starCode = ['!4e1', '!4e7', '!4e2', '!4e8', '!4e3', '!4e9'];
  final _$Code = ['!1e0', '!1e1', '!1e2', '!1e3'];

  @override
  Widget build(BuildContext context) {
    void _clearAssign(int index) {
      _starColor.asMap().forEach((i, v) {
        if (v == Colors.brown) {
          setState(() {
            _starColor[i] = Colors.grey;
          });
        }
        if (i == _starColor.length - 1) {
          setState(() {
            _starColor[index] = Colors.brown;
          });
        }
      });
    }

    List<int> _searchCount(List<Color> l) {
      List<int> _temp = [];
      l.asMap().forEach((i, v) {
        if (v == Colors.brown) {
          _temp.add(i);
        }
      });
      return _temp;
    }

    String _gen$CodeStarCode(List<int> indexL, List<String> l) {
      String _temp = '';
      indexL.forEach((v) {
        _temp += l[v];
      });
      return _temp;
    }

    Widget _$Widget(int s) {
      final _length = (s == 0 ? _$Color.length : _starColor.length);

      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var x = 0; x < _length; x++)
              GestureDetector(
                onTap: () {
                  if (s == 0
                      ? _$Color[x] == Colors.grey
                      : _starColor[x] == Colors.grey) {
                    setState(() {
                      if (s == 0) _$Color[x] = Colors.brown;
                    });
                    if (s != 0) {
                      _clearAssign(x);
                    }
                  } else
                    setState(() {
                      s == 0
                          ? _$Color[x] = Colors.grey
                          : _starColor[x] = Colors.grey;
                    });
                },
                child: Container(
                  color: s == 0 ? _$Color[x] : _starColor[x],
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / _length,
                  child: s == 0
                      ? Text(
                          '\$' * (x + 1),
                          style: TextStyle(fontSize: 18),
                        )
                      : Text(
                          _starCount[x],
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: TextFormField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 45),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 35,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                  _$Widget(0),
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                  _$Widget(1),
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                ]),
          ),
          Flexible(
              flex: 1,
              child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  //color: Colors.red,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      _searchString = _textFieldController.text
                              .trim()
                              .toLowerCase()
                              .replaceAll(' ', '+') +
                          '/';

                      Position _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                      print(_position);
                      var _searchCountStarColor = _searchCount(_starColor);
                      var _searchCount$Color = _searchCount(_$Color);

                      var _dataPreString = _dataPre[
                          (_searchCountStarColor.length +
                                      _searchCount$Color.length) >
                                  1
                              ? 2
                              : (_searchCountStarColor.length +
                                  _searchCount$Color.length)];



                      var _starCodeString = '';
                      if (_searchCountStarColor.length > 0) {

                        _starCodeString =
                            _gen$CodeStarCode(_searchCountStarColor, _starCode);
                      }
                      var _$CodeString = '';
                      if (_searchCount$Color.length > 0) {

                        _$CodeString =
                            _gen$CodeStarCode(_searchCount$Color, _$Code);
                      }


                      _location ='@${_position.latitude},${_position.longitude},13z/';
                      final url =
                          '$_googleUri$_searchString${_location}data=$_dataPreString${_$CodeString}$_starCodeString$_dataLast';
                      print(url);
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    iconSize: MediaQuery.of(context).size.height / 8,
                  ))),
        ],
      ),
    );
  }
}
