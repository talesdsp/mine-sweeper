import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/field.dart';

void flagUnderminedField(Field field) {}

void openUnderminedField(Field field) {}

main() {
  test('Win game', () {
    Board board = Board(cols: 2, rows: 2, countBombs: 0);

    board.fields[0].addBomb().toggleFlag();
    board.fields[1].addBomb().toggleFlag();
    board.fields[2].open();
    board.fields[3].open();

    expect(board.resolved, isTrue);
  });

  test('reset game', () {
    Board board = Board(cols: 2, rows: 2, countBombs: 0);
    board.fields[0].addBomb();
    board.fields[1].toggleFlag();
    board.fields[2].open();

    expect(board.fields[0].hasBomb, isTrue);
    expect(board.fields[1].hasFlag, isTrue);
    expect(board.fields[2].isOpen, isTrue);

    board.restart();
    expect(board.fields[0].hasBomb, isFalse);
    expect(board.fields[1].hasFlag, isFalse);
    expect(board.fields[2].isOpen, isFalse);
  });
}
