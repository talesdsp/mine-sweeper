import 'package:campo/models/explosion_exception.dart';
import 'package:flutter/foundation.dart';

class Field {
  Field({
    @required this.row,
    @required this.col,
  });

  final int row;
  final int col;
  final List<Field> neighborFields = [];

  static bool _isOpen = false;
  static bool _hasFlag = false;
  static bool _hasBomb = false;
  static bool _exploded = false;

  bool get isOpen => _isOpen;
  bool get hasFlag => _hasFlag;
  bool get hasBomb => _hasBomb;
  bool get exploded => _exploded;

  bool get done {
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
  void addBomb() {
    _hasBomb = true;
  }

  // show this field's bomb (if has any)
  void showBomb() {
    if (hasBomb) {
      _isOpen = true;
    }
  }
}
