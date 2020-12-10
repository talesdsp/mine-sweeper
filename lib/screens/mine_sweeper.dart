import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/board_widget.dart';
import 'package:mine_sweeper/components/result_widget.dart';
import 'package:mine_sweeper/config/size_config.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/count_up_timer.dart';
import 'package:mine_sweeper/models/explosion_exception.dart';
import 'package:mine_sweeper/models/field.dart';
import 'package:mine_sweeper/screens/game_mode.dart';

class MineSweeperArguments {
  MineSweeperArguments({this.difficulty, this.color});

  final double difficulty;
  final Color color;
}

class MineSweeperScreen extends StatefulWidget {
  static const routeName = '/mine_sweeper';

  @override
  _MineSweeperScreenState createState() => _MineSweeperScreenState();
}

class _MineSweeperScreenState extends State<MineSweeperScreen> {
  bool _win;
  Board _board;
  CountUpTimer _time;

  void initState() {
    super.initState();

    _time = CountUpTimer();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_win != null) return timer.cancel();

      setState(() {
        _time.increment();
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final MineSweeperArguments args = ModalRoute.of(context).settings.arguments;

    SizeConfig().init(context);

    Board _getBoard(double width, double height) {
      if (_board == null) {
        int cols = 9;
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
      backgroundColor: Colors.lightBlue[100],
      appBar: ResultWidget(
        win: _win,
        onReset: _reset,
        time: _time,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        elevation: 10,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    GameModeScreen.routeName,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 10),
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
