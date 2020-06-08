import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/field.dart';

main() {
  group('Placing bombs manually', () {
    Board board;
    setUp(() {
      board = Board(cols: 2, rows: 2, difficulty: 0);
    });

    tearDown(() {
      board = null;
    });

    test('Win game', () {
      board.fields[0].addBomb().toggleFlag();
      board.fields[1].addBomb().toggleFlag();
      board.fields[2].open();
      board.fields[3].open();

      expect(board.resolved, isTrue);
    });

    test('Reset game', () {
      board.fields[0].addBomb();
      board.fields[1].toggleFlag();
      board.fields[2].open();

      expect(board.fields[0].hasBomb, isTrue);
      expect(board.fields[1].hasFlag, isTrue);
      expect(board.fields[2].isOpen, isTrue);

      board.restart();

      expect(board.resolved, isFalse);
      expect(board.fields[0].hasBomb, isFalse);
      expect(board.fields[1].hasFlag, isFalse);
      expect(board.fields[2].isOpen, isFalse);
    });
  });

  group('Bombs place by app', () {
    Board board;
    setUpAll(() {
      board = Board(cols: 10, rows: 10, difficulty: 1);
    });

    test('Has 10 bombs', () {
      List<Field> bombsList =
          board.fields.where((field) => field.hasBomb).toList();

      expect(bombsList.length, equals(10));
    });

    test('Opened all bombs', () {
      board.showAllBombs();
      int bombsOpened =
          board.fields.where((field) => field.hasBomb && field.isOpen).length;

      expect(bombsOpened, equals(10));
    });
  });
}
