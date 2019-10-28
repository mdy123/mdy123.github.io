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

    sorting(_sAscending, _sColumnIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Table'),
        ),
        body: DataTable(
          sortAscending: _sAscending,
          sortColumnIndex: _sColumnIndex,
          onSelectAll: (b) {
            print(b);
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
              DataRow(cells: [
                for (var y in x)
                  DataCell(
                    Text('$y'),
                  ),
              ]),
          ],
        ),
      ),
    );
  }
}
