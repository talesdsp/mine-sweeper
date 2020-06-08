import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/score.dart';
import 'package:shared_preferences/shared_preferences.dart';

Score score;

main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({
      'flutter.score': ['123.9']
    });

    score = Score(
      difficulty: 2,
      cols: 10,
      rows: 10,
      share: await SharedPreferences.getInstance(),
    );
  });

  test('Generate score', () async {
    expect(score.score, equals('200.0'));
  });

  test('Get stored data', () async {
    expect(score.scoreList, equals(['123.9', '200.0']));
  });

  test('Delete stored data', () async {
    bool isDeleted = await score.deleteScore();
    expect(isDeleted, isTrue);
    expect(score.scoreList, equals([]));
  });
}
