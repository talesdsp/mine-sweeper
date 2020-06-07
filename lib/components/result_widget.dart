import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool win;
  final Function onReset;

  bool _hover = false;

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
    if (_hover) {
      return Icons.sentiment_neutral;
    }
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
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
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
              onHover: (b) => {},
            ),
          ),
        ),
      ),
    );
  }

  confirmRestartDialog(BuildContext context, bool win) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget restartButton = RaisedButton(
        child: Text("Restart"),
        onPressed: () {
          Navigator.of(context).pop();
          onReset();
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
