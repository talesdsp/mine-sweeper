import 'dart:math';

import 'package:flutter/foundation.dart';

import 'field.dart';

class Board {
  Board({
    @required this.rows,
    @required this.cols,
    @required this.countBombs,
  }) {
    _createFields();
    _createNeighborhood();
    _sortBombs();
  }

  final int rows;
  final int cols;
  final int countBombs;
  final List<Field> _fields = [];

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return fields.every((field) => field.resolved);
  }

  void restart() {
    _fields.forEach((field) => field.reset());
    _sortBombs();
  }

  void showAllBombs() {
    _fields.forEach((field) => field.showBomb());
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        _fields.add(Field(col: c, row: r));
      }
    }
  }

  void _createNeighborhood() {
    for (var field in _fields) {
      for (var otherField in _fields) {
        field.addNeighbor(otherField);
      }
    }
  }

  void _sortBombs() {
    int sorted = 0;

    if (countBombs > rows * cols) return;

    while (sorted < countBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].hasBomb) {
        _fields[i].addBomb();
        sorted++;
      }
    }
  }
}
