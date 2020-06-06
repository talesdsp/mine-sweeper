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
}
