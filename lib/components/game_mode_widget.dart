import 'package:flutter/material.dart';
import 'package:mine_sweeper/screens/mine_sweeper.dart';

class GameModeArguments {
  final double difficulty;

  GameModeArguments({this.difficulty});
}

class GameModeWidget extends StatelessWidget {
  GameModeWidget({
    @required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    Color _getColor() {
      if (text == 'Hard') {
        return Colors.red;
      } else if (text == 'Medium') {
        return Colors.orangeAccent[700];
      }
      return Colors.green;
    }

    double _getLevel() {
      if (text == 'Hard') {
        return 1.8;
      } else if (text == 'Medium') {
        return 1.6;
      }
      return 1.4;
    }

    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, MineSweeperScreen.routeName,
            arguments: GameModeArguments(difficulty: _getLevel()));
      },
      child: Text(
        text,
      ),
      colorBrightness: Brightness.dark,
      splashColor: Colors.white10,
      color: _getColor(),
    );
  }
}
