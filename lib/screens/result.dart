import 'package:flutter/material.dart';

class ResultArguments {
  ResultArguments({this.difficulty});

  final double difficulty;
}

class ResultScreen extends StatelessWidget {
  static const routeName = '/results';
  @override
  Widget build(BuildContext context) {
    final ResultArguments args = ModalRoute.of(context).settings.arguments;

    // Score score = Score(difficulty: difficulty, cols: cols, rows: rows)

    return Scaffold();
  }
}
