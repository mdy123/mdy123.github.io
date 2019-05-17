import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MaterialApp(
    title: 'Test App',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyModel extends Model {
  List<List<Color>> _cll = [
    [Colors.red, Colors.cyan, Colors.red],
    [Colors.cyan, Colors.red, Colors.cyan],
    [Colors.red, Colors.cyan, Colors.red]
  ];
  List<List<Color>> get cll => _cll;
  void changColor(Color c, int x, int y) {
    print('$x - $y ');
    _cll[x][y] = c;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final List<Color> playerColor = [Colors.amber, Colors.green];
  int _playerNo = 0;

  Widget buildBlock(context, model) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var y = 0; y < 3; y++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var x = 0; x < 3; x++)
                GestureDetector(
                  onTap: () {
                    if (model.cll[y][x] == Colors.red ||
                        model.cll[y][x] == Colors.cyan) {
                      //model.cll[y][x] = playerColor[playerNo.isEven ? 0 : 1];
                      model.changColor(
                          playerColor[_playerNo.isEven ? 0 : 1], y, x);
                      _playerNo++;
                    }
                  },
                  child: Container(
                    key: Key(y.toString() + x.toString()),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: model.cll[y][x],
                    ),
                    child: Text('$y - $x'),
                  ),
                )
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scope Model'),
      ),
      body: ScopedModel<MyModel>(
        model: MyModel(),
        child: ScopedModelDescendant<MyModel>(
          builder: (context, child, model) {
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 5,
                  child: Container(
                    child: buildBlock(context, model),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
