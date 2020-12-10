import 'package:flutter/material.dart';
import 'package:mine_sweeper/config/size_config.dart';
import 'package:mine_sweeper/screens/mine_sweeper.dart';

class GameModeWidget extends StatelessWidget {
  GameModeWidget({
    @required this.text,
    @required this.color,
    @required this.level,
  });

  final String text;
  final Color color;
  final double level;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: SizeConfig.screenWidth * .6,
      height: SizeConfig.blockSizeHorizontal * 17,
      child: RaisedButton(
        elevation: 10,
        onPressed: () {
          Navigator.pushNamed(context, MineSweeperScreen.routeName,
              arguments: MineSweeperArguments(
                difficulty: level,
                color: color,
              ));
        },
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 7,
          ),
        ),
        colorBrightness: Brightness.dark,
        splashColor: Colors.white10,
        color: color,
      ),
    );
  }
}
