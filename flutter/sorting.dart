List<List<dynamic>> _lRow = [
  ['go', 1970, 5],
  ['java', 1971, 8],
  ['javascript', 1960, 20],
  ['python', 1965, 3],
  ['c#', 1975, 2]
];
List<dynamic> _tempL;
bool _as = true;
int _indexP = 2;
void main() {
  for (var y = 0; y < (_lRow.length / 2).round() + 1; y++)
    for (var x = y + 1; x < _lRow.length; x++)
      if (_as
          ? _lRow[y][_indexP].runtimeType == int
              ? _lRow[y][_indexP] > _lRow[x][_indexP]
              : _lRow[y][_indexP].toLowerCase().codeUnitAt(0) >
                  _lRow[x][_indexP].toLowerCase().codeUnitAt(0)
          : _lRow[y][_indexP].runtimeType == String
              ? _lRow[y][_indexP] < _lRow[x][_indexP]
              : _lRow[y][_indexP].toLowerCase().codeUnitAt(0) <
                  _lRow[x][_indexP].toLowerCase().codeUnitAt(0)) {
        _tempL = _lRow[x];
        _lRow[x] = _lRow[y];
        _lRow[y] = _tempL;
      }

  print(_lRow);
}
