import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/field.dart';

main() {
  group('Field', () {
    test('Open field with explosion', () {
      final Field field = Field(row: 0, col: 0);

      field.addBomb();

      expect(field.open, throwsException);
    });

    test('Open field without explosion', () {
      Field field = Field(row: 0, col: 0);

      field.open();

      expect(field.isOpen, isTrue);
    });

    test('Add neighbor', () {
      Field bomb = Field(row: 0, col: 0);
      Field closeField1 = Field(row: 1, col: 0);
      Field closeField2 = Field(row: 1, col: 1);

      bomb.addNeighbor(closeField1);
      bomb.addNeighbor(closeField2);

      expect(bomb.neighborFields.length, equals(2));
    });

    test('Add NO neighbor', () {
      Field field = Field(row: 0, col: 0);
      Field sameField = field;
      Field distantField = Field(row: 1, col: 3);

      field.addNeighbor(sameField);
      field.addNeighbor(distantField);

      expect(field.neighborFields.isEmpty, isTrue);
    });

    test('There are bombs in neighborhood ', () {
      Field field = Field(row: 0, col: 0);
      Field closeField1 = Field(row: 1, col: 0);
      Field closeField2 = Field(row: 1, col: 1);
      Field closeField3 = Field(row: 0, col: 1);

      closeField1.addBomb();
      closeField2.addBomb();

      field.addNeighbor(closeField1);
      field.addNeighbor(closeField2);
      field.addNeighbor(closeField3);

      expect(field.safeNeighborhood, isFalse);
      expect(field.countBombsInNeighborhood, 2);
    });

    test('There are NO bombs in neighborhood ', () {
      Field field = Field(row: 0, col: 0);
      Field closeField1 = Field(row: 1, col: 0);
      Field closeField2 = Field(row: 1, col: 1);

      field.addNeighbor(closeField1);
      field.addNeighbor(closeField2);

      expect(field.safeNeighborhood, isTrue);
      expect(field.countBombsInNeighborhood, 0);
    });
  });
}
