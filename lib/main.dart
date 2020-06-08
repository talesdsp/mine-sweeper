import 'package:flutter/material.dart';
import 'package:mine_sweeper/screens/game_mode.dart';
import 'package:mine_sweeper/screens/mine_sweeper.dart';
import 'package:mine_sweeper/screens/score.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: GameModeScreen.routeName,
      routes: {
        GameModeScreen.routeName: (context) => GameModeScreen(),
        MineSweeperScreen.routeName: (context) => MineSweeperScreen(),
        ResultScreen.routeName: (context) => ResultScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.blue,
        buttonTheme: ButtonThemeData(
          disabledColor: Colors.red[50],
        ),
      ),
    ),
  );
  // runApp(MineSweeperApp());
}
