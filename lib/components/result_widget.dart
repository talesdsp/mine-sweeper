import 'package:flutter/material.dart';
import 'package:mine_sweeper/config/size_config.dart';
import 'package:mine_sweeper/models/count_up_timer.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool win;
  final Function onReset;
  final CountUpTimer time;

  ResultWidget({
    @required this.win,
    @required this.onReset,
    @required this.time,
  });

  dynamic _getIf(a, b, c) {
    if (win == null) {
      return a;
    } else if (win) {
      return b;
    } else {
      return c;
    }
  }

  Color _getColor() {
    return _getIf(
      Colors.yellow,
      Colors.green[300],
      Colors.red[300],
    );
  }

  IconData _getIcon() {
    return _getIf(
      Icons.sentiment_satisfied,
      Icons.sentiment_very_satisfied,
      Icons.sentiment_very_dissatisfied,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      color: Colors.blue[900],
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5,
            bottom: SizeConfig.blockSizeHorizontal * 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('ola'),
              RaisedButton(
                elevation: 5,
                color: _getColor(),
                shape: CircleBorder(),
                splashColor: Colors.purple,
                onPressed: () {
                  showMiniMenu(context, win);
                },
                child: Icon(
                  _getIcon(),
                  color: Colors.black,
                  size: 35,
                ),
              ),
              Text(
                '${time.minute}:${time.second}',
                style: TextStyle(
                  fontFamily: 'Vt323',
                  color: Colors.white70,
                  fontSize: SizeConfig.safeBlockHorizontal * 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMiniMenu(BuildContext context, bool win) {
    /**
     * Buttons
     */

    Widget resumeButton = FlatButton(
      child: Text("Resume"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget restartButton = RaisedButton(
      child: Text("Restart"),
      onPressed: () {
        confirmationDialog(context);
      },
    );

    /**
     * Menu
     */

    Widget menu = Center(
      child: ButtonTheme(
        minWidth: 200,
        child: Container(
          color: Colors.grey[400],
          height: context.size.height,
          child: Column(
            children: <Widget>[resumeButton, restartButton],
          ),
        ),
      ),
    );

    /// Dialog
    showDialog(
      context: context,
      builder: (context) => menu,
    );
  }

  void confirmationDialog(BuildContext context) {
    Text _getText() {
      if (win == null)
        return Text("Are you sure?\nYour actual progress will be lost!");

      return null;
    }

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey[100],
      title: Text("Restart"),
      content: _getText(),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        FlatButton(
          color: Colors.blue,
          child: Text('Restart'),
          onPressed: () {
            onReset();
            Navigator.of(context, rootNavigator: true).pop();
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
