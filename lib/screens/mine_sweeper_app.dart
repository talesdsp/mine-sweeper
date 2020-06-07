import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/board_widget.dart';
import 'package:mine_sweeper/components/result_widget.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/explosion_exception.dart';
import 'package:mine_sweeper/models/field.dart';

class MineSweeperApp extends StatefulWidget {
  @override
  _MineSweeperAppState createState() => _MineSweeperAppState();
}

class _MineSweeperAppState extends State<MineSweeperApp> {
  bool _win;
  Board _board;

  void _reset() {
    setState(() {
      _win = null;
      _board.restart();
    });
  }

  void _onOpen(Field field) {
    if (_win != null) return;
    setState(() {
      try {
        field.open();
        if (_board.resolved) {
          _win = true;
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
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int cols = 11;
      double fieldSize = width / cols;
      int rows = (height / fieldSize).floor();

      _board = Board(
        rows: rows,
        cols: cols,
        countBombs: 30,
      );
    }

    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        buttonTheme: ButtonThemeData(
          disabledColor: Colors.red[50],
          splashColor: Colors.purple,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: ResultWidget(win: _win, onReset: _reset),
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
      ),
    );
  }
}
