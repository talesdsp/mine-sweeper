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
}
