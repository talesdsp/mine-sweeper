import 'package:flutter/foundation.dart';
import 'package:mine_sweeper/models/explosion_exception.dart';

class Field {
  Field({
    @required this.row,
    @required this.col,
  });

  final int row;
  final int col;
  final List<Field> neighborFields = [];

  bool _isOpen = false;
  bool _hasFlag = false;
  bool _hasBomb = false;
  bool _exploded = false;

  bool get isOpen {
    return _isOpen;
  }

  bool get hasFlag {
    return _hasFlag;
  }

  bool get hasBomb {
    return _hasBomb;
  }

  bool get exploded {
    return _exploded;
  }

  bool get resolved {
    bool bombIsMarked = hasBomb && hasFlag;
    bool openedSafeField = !hasBomb && isOpen;

    return bombIsMarked || openedSafeField;
  }

  bool get safeNeighborhood {
    return neighborFields.every((field) => !field.hasBomb);
  }

  int get countBombsInNeighborhood {
    return neighborFields.where((field) => field.hasBomb).length;
  }

  // reset all fields to re-start the game
  void reset() {
    _isOpen = false;
    _hasFlag = false;
    _hasBomb = false;
    _exploded = false;
  }

  // add closest fields to 'neighborhood'
  void addNeighbor(Field field) {
    final deltaRow = (row - field.row).abs();
    final deltaCol = (col - field.col).abs();

    if (deltaRow == 0 && deltaCol == 0) return;

    if (deltaRow <= 1 && deltaCol <= 1) {
      neighborFields.add(field);
    }
  }

  // open field
  void open() {
    if (isOpen) return;

    _isOpen = true;

    if (hasBomb) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighborFields.forEach((field) => field.open());
    }
  }

  // add (or remove) flag dinamically
  void toggleFlag() {
    _hasFlag = !_hasFlag;
  }

  // add bomb to this field
  Field addBomb() {
    _hasBomb = true;
    return this;
  }

  // show this field's bomb (if has any)
  void showBomb() {
    if (hasBomb) {
      _isOpen = true;
    }
  }
}
