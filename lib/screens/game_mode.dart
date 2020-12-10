import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_sweeper/components/game_mode_widget.dart';
import 'package:mine_sweeper/config/size_config.dart';

class GameModeScreen extends StatelessWidget {
  static const routeName = '/game_mode';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Color(0xff333377),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 10,
                vertical: SizeConfig.safeBlockHorizontal * 20,
              ),
              child: Text(
                'Gotcha Bombs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 20,
                    ),
                  ],
                  color: Colors.greenAccent,
                  fontSize: SizeConfig.safeBlockHorizontal * 15,
                  fontFamily: "FredokaOne",
                ),
              ),
            ),
            GameModeWidget(
              text: 'Easy',
              color: Colors.green,
              level: 1.4,
            ),
            Padding(
              padding: EdgeInsets.all(
                SizeConfig.blockSizeVertical * 2.5,
              ),
              child: GameModeWidget(
                text: 'Medium',
                color: Colors.orange[800],
                level: 1.6,
              ),
            ),
            GameModeWidget(
              text: 'Hard',
              color: Colors.red[600],
              level: 1.8,
            ),
          ],
        ),
      ),
    );
  }
}
