import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/game_mode_widget.dart';

class GameModeScreen extends StatelessWidget {
  static const routeName = '/game_mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GameModeWidget(
            text: 'Easy',
          ),
          GameModeWidget(
            text: 'Medium',
          ),
          GameModeWidget(
            text: 'Hard',
          ),
        ],
      ),
    );
  }
}
