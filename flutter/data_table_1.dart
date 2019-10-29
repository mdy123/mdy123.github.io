import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<List<dynamic>> _lRow = [
  ['go', 1970, 5],
  ['java', 1971, 8],
  ['javascript', 1960, 1],
  ['python', 1965, 3],
  ['basic', 1935, 15],
  ['vb', 1980, 13],
];

List<String> _lColumn = ['Language', 'Date', 'Rating'];

bool _sAscending;

int _sColumnIndex;

List<bool> _lSelectRow;
List<List<bool>> _cellEnable = [];

void sorting(bool _as, int _indexP) {
  List<dynamic> _tempL;
  for (var y = 0; y < (_lRow.length / 4).round() * 3; y++)
    for (var x = y + 1; x < _lRow.length; x++)
      if (_as
          ? _lRow[y][_indexP].runtimeType == int
              ? _lRow[y][_indexP] > _lRow[x][_indexP]
              : _lRow[y][_indexP].toLowerCase().codeUnitAt(0) >
                  _lRow[x][_indexP].toLowerCase().codeUnitAt(0)
          : _lRow[y][_indexP].runtimeType == int
              ? _lRow[y][_indexP] < _lRow[x][_indexP]
              : _lRow[y][_indexP].toLowerCase().codeUnitAt(0) <
                  _lRow[x][_indexP].toLowerCase().codeUnitAt(0)) {
        _tempL = _lRow[x];
        _lRow[x] = _lRow[y];
        _lRow[y] = _tempL;
      }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _sAscending = true;
    _sColumnIndex = 0;
    _lSelectRow = List.generate(_lRow.length, (i) => false);
    for (var x in _lRow) _cellEnable.add(List.generate(x.length, (i) => false));

    sorting(_sAscending, _sColumnIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_cellEnable);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Table'),
        ),
        body: DataTable(
          sortAscending: _sAscending,
          sortColumnIndex: _sColumnIndex,
          onSelectAll: (b) {
            print('----------- $b ++++++++++++++');
            setState(() {
              _lSelectRow.map((i) => b).toList();
            });
          },
          columns: [
            for (var x in _lColumn)
              DataColumn(
                  label: Text(x),
                  onSort: (i, b) {
                    setState(() {
                      _sAscending = b;
                      _sColumnIndex = i;
                      sorting(!_sAscending, _sColumnIndex);
                    });
                  }),
          ],
          rows: [
            for (var x in _lRow)
              DataRow(
                cells: [
                  for (var y in x)
                    DataCell(
                        TextFormField(
                          initialValue: '$y',
                          enabled: _cellEnable[_lRow.indexOf(x)][_lRow[_lRow.indexOf(x)].indexOf(y)],

                        ),
                        placeholder: true,
                        showEditIcon: true, onTap: () {
                      print('$x  ----  $y');
                      setState(() {
                        _cellEnable[_lRow.indexOf(x)][_lRow[_lRow.indexOf(x)].indexOf(y)]= !_cellEnable[_lRow.indexOf(x)][_lRow[_lRow.indexOf(x)].indexOf(y)];
                      });
                    }),
                ],
                onSelectChanged: (b) {
                  print('OnSelectedChanged    $b -- ${_lRow.indexOf(x)}');

                  setState(() {

                    _lSelectRow[_lRow.indexOf(x)] = b;
                  });
                },
                selected: _lSelectRow[_lRow.indexOf(x)],
              ),
          ],
        ),
      ),
    );
  }
}
