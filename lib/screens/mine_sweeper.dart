import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/board_widget.dart';
import 'package:mine_sweeper/components/game_mode_widget.dart';
import 'package:mine_sweeper/components/result_widget.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/explosion_exception.dart';
import 'package:mine_sweeper/models/field.dart';
import 'package:mine_sweeper/screens/score.dart';

class MineSweeperScreen extends StatefulWidget {
  static const routeName = '/mine_sweeper';

  @override
  _MineSweeperScreenState createState() => _MineSweeperScreenState();
}

class _MineSweeperScreenState extends State<MineSweeperScreen> {
  bool _win;
  Board _board;

  void _reset() {
    setState(() {
      _win = null;
      _board.restart();
    });
  }

  void _seeResult() {
    Timer(
        Duration(
          seconds: 5,
        ), () {
      Navigator.pushNamed(
        context,
        ResultScreen.routeName,
        arguments: GameModeArguments(),
      );
    });
  }

  void _onOpen(Field field) {
    if (_win != null) return;
    setState(() {
      try {
        field.open();
        if (_board.resolved) {
          _win = true;
          _seeResult();
        }
      } on ExplosionException {
        _win = false;
        _board.showAllBombs();
      }
    });
  }

  void _onToggleFlag(Field field) {
    if (_win != null) return;
    setState(() {
      field.toggleFlag();
      if (_board.resolved) {
        _win = true;
        _seeResult();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GameModeArguments args = ModalRoute.of(context).settings.arguments;

    Board _getBoard(double width, double height) {
      if (_board == null) {
        int cols = 11;
        double fieldSize = width / cols;
        int rows = (height / fieldSize).floor();

        _board = Board(
          rows: rows,
          cols: cols,
          difficulty: args.difficulty,
        );
      }

      return _board;
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: ResultWidget(
        win: _win,
        onReset: _reset,
      ),
      body: Container(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return BoardWidget(
              board: _getBoard(constraints.maxWidth, constraints.maxHeight),
              onOpen: _onOpen,
              onToggleFlag: _onToggleFlag,
            );
          },
        ),
      ),
    );
  }
}
