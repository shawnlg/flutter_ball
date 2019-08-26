import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/text.dart';
import 'package:flutter_ball/components/game_play.dart';

const double SPLASH_TIME  = 5.0;

void addBallsLeftMessage(FlutterballGame game, GamePlay gp) {
  print("addBallsLeftMessage");
  TextStyle messageStyle = TextStyle(fontSize: 12, color: Colors.white);
  TextSpan messageSpan = TextSpan(text: "balls: ${gp.ballsLeft}", style: messageStyle);
  gp.ballsLeftMessage = TextDraw(Rect.fromLTWH(5, gp.sizeY-30, 100, 20), messageSpan,
    boxColor: null, borderColor: null, textAlign: TextAlign.left,
  );
  game.add(gp.ballsLeftMessage);
}

void updateBallsLeftMessage(GamePlay gp) {
  gp.ballsLeftMessage.text = "balls: ${gp.ballsLeft}";
}

void addBouncesLeftMessage(FlutterballGame game, GamePlay gp) {
  print("addBouncesLeftMessage");
  TextStyle messageStyle = TextStyle(fontSize: 12, color: Colors.white);
  TextSpan messageSpan = TextSpan(text: "bounces: ", style: messageStyle);
  gp.bouncesLeftMessage = TextDraw(Rect.fromLTWH(gp.sizeX-150, gp.sizeY-30, 200, 20), messageSpan,
    boxColor: null, borderColor: null, textAlign: TextAlign.left,
  );
  game.add(gp.bouncesLeftMessage);
}

void updateBouncesLeftMessage(GamePlay gp, int bounces) {
  gp.bouncesLeftMessage.text = "bounces: $bounces";
}

void addLaunchMessage(FlutterballGame game, GamePlay gp) {
  TextStyle messageStyle = TextStyle(fontSize: 15, color: Colors.white);
  TextSpan messageSpan = TextSpan(text: "Level ${game.level} Launch...", style: messageStyle);
  gp.launchMessage = TextDraw(Rect.fromLTWH(0, gp.sizeY*0.4, gp.sizeX, 50), messageSpan,
    boxColor: null, borderColor: null,
  );
  game.add(gp.launchMessage);
}

// set up splash screen for completed level
void makeCompletedSplash(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  TextStyle messageStyle = TextStyle(fontSize: 20, color: Colors.blue);
  TextSpan messageSpan = TextSpan(text: "Good Job!\n\n\nYou Finished\nLevel ${game.level}", style: messageStyle);
  TextDraw message = TextDraw(Rect.fromLTWH(0, 0, gp.sizeX, gp.sizeY), messageSpan,
    boxColor: null, borderColor: null,
  );

  game.add(message);
  gp.splashOver = game.currentTime() + 3.0;
}

// set up splash screen for lost game
void makeLoseSplashScreen(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  TextStyle messageStyle = TextStyle(fontSize: 20, color: Colors.blue);
  TextSpan messageSpan = TextSpan(text: "You Lose!\n\n\nGame Over", style: messageStyle);
  TextDraw message = TextDraw(Rect.fromLTWH(0, 0, gp.sizeX, gp.sizeY), messageSpan,
    boxColor: null, borderColor: null,
  );
  game.add(message);
  gp.splashOver = game.currentTime() + SPLASH_TIME;
}
