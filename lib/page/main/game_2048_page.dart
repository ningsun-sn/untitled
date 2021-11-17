import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/color_utils.dart';

import 'game_2048_panel.dart';

class Game2048Page extends StatefulWidget {
  @override
  _Game2048PageState createState() => _Game2048PageState();
}

class _Game2048PageState extends State<Game2048Page> {

  /// 当前分数
  int currentScore = 0;
  /// 历史最高分
  int highestScore = 0;

  static const GAME_2048_HIGHEST_SCORE = "game_2048_highest_score";

  final Future<SharedPreferences> _spFuture = SharedPreferences.getInstance();

  /// 用于获取 Game2048PanelState 实例，以便可以调用restartGame方法
  GlobalKey _gamePanelKey = GlobalKey<Game2048PanelState>();

  @override
  void initState() {
    super.initState();
    readHighestScoreFromSp();
  }

  @override
  Widget build(BuildContext context) {

    Widget gamePanel = Game2048Panel(
      key: _gamePanelKey,
      onScoreChanged: (score) {
        setState(() {
          currentScore = score;
          if (currentScore > highestScore) {
            highestScore = currentScore;
            storeHighestScoreToSp();
          }
        });
      },);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 30),
        color: ColorUtils.bgColor1,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                children: [
                  Flexible(child: gameHeader()),
                  Flexible(flex: 2,child: gamePanel)
                ],
              );
            } else {
              return Row(
                children: [
                  Flexible(child: gameHeader()),
                  Flexible(flex: 2,child: gamePanel)
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget gameHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2048",
                  style: TextStyle(
                      color: ColorUtils.textColor1,
                      fontSize: 56,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Play 2048 Game Now",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorUtils.textColor1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Join numbers and get to the 2048 tile!",
                  style: TextStyle(color: ColorUtils.textColor1),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorUtils.bgColor2,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "SCORE",
                        style: TextStyle(
                          color: ColorUtils.textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Text(
                        currentScore.toString(),
                        style: TextStyle(
                            color: ColorUtils.textColor3,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorUtils.bgColor2,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "HIGHEST",
                        style: TextStyle(
                          color: ColorUtils.textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Text(
                        highestScore.toString(),
                        style: TextStyle(
                            color: ColorUtils.textColor3,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorUtils.bgColor3,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        (_gamePanelKey.currentState as Game2048PanelState).reStartGame();
                      },
                      child: const Text(
                        "NEW GAME",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void readHighestScoreFromSp() async {
    final SharedPreferences sp = await _spFuture;
    setState(() {
      highestScore = sp.getInt(GAME_2048_HIGHEST_SCORE) ?? 0;
    });
  }

  void storeHighestScoreToSp() async {
    final SharedPreferences sp = await _spFuture;
    await sp.setInt(GAME_2048_HIGHEST_SCORE, highestScore);
  }
}