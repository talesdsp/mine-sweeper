import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score {
  Score({
    @required this.difficulty,
    @required this.cols,
    @required this.rows,
    @required this.share,
  }) {
    _generateScore();
    _setScore();
  }

  int difficulty;
  int cols;
  int rows;
  SharedPreferences share;

  String _score;
  List<String> _scoreList = [];

  String get score {
    return _score;
  }

  List<String> get scoreList {
    return _scoreList;
  }

  Future<bool> deleteScore() async {
    bool isDeleted = await share.remove('score');
    if (isDeleted) {
      _scoreList.clear();
    }
    return isDeleted;
  }

  void _generateScore() {
    int fields = cols * rows;
    double scoreInt = fields * (difficulty / 10) * 10;
    _score = scoreInt.toString();
  }

  List<String> _getScoreList() {
    return share.getStringList('score') ?? [];
  }

  void _setScore() async {
    _scoreList = _getScoreList();
    _scoreList.add(_score);
    await share.setStringList('score', _scoreList);
  }
}
