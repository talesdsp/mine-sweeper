import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool win;
  final Function onReset;

  ResultWidget({
    @required this.win,
    @required this.onReset,
  });

  Color _getCor() {
    if (win == null) {
      return Colors.yellow;
    } else if (win) {
      return Colors.green[300];
    } else {
      return Colors.red[300];
    }
  }

  IconData _getIcon() {
    if (win == null) {
      return Icons.sentiment_satisfied;
    } else if (win) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('ola'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: _getCor(),
                  child: InkWell(
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        _getIcon(),
                        color: Colors.black,
                        size: 35,
                      ),
                      onPressed: () {
                        confirmRestartDialog(context, win);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void confirmRestartDialog(BuildContext context, bool win) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget restartButton = RaisedButton(
        child: Text("Restart"),
        onPressed: () {
          onReset();
          Navigator.of(context, rootNavigator: true).pop();
        });

    Text _getText() {
      if (win == null) {
        return Text("Are you sure?\n\nYour actual progress will be lost!");
      }
      return null;
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Restart game'),
      backgroundColor: Colors.blueAccent,
      content: _getText(),
      actions: [
        cancelButton,
        restartButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
