import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/game_play.dart';

const double SPLASH_TIME  = 5.0;

void addBallsLeftMessage(FlutterballGame game, GamePlay gp) {
  gp.ballsLeftMessage = Block(game, position: Rect.fromLTWH(0, gp.sizeY-40, 100, 20),
    displayText: "balls: ${gp.ballsLeft}", color: null, borderColor: null,
    textStyle: TextStyle(fontSize: 15, color: Colors.white),
    bounce: false, draggable: false,
  );
  game.add(gp.ballsLeftMessage);
}

void addBouncesLeftMessage(FlutterballGame game, GamePlay gp) {
  gp.bouncesLeftMessage = Block(game, position: Rect.fromLTWH(gp.sizeX-150, gp.sizeY-40, 100, 20),
    displayText: "bounces: ", color: null, borderColor: null,
    textStyle: TextStyle(fontSize: 15, color: Colors.white),
    bounce: false, draggable: false,
  );
  game.add(gp.bouncesLeftMessage);
}


void addLaunchMessage(FlutterballGame game, GamePlay gp) {
  gp.launchMessage = Block(game, position: Rect.fromLTWH(0, gp.sizeY*0.4, gp.sizeX, 50),
    displayText: "Level ${game.level} Launch...", color: null, borderColor: null,
    textStyle: TextStyle(fontSize: 15, color: Colors.white),
    bounce: false, draggable: false,
  );
  game.add(gp.launchMessage);
}

// set up splash screen for completed level
void makeCompletedSplash(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  Block message = Block(game, position: Rect.fromLTWH(0, 0, gp.sizeX, gp.sizeY),
    displayText: "Good Job!\n\n\nYou Finished\nLevel ${game.level}",
    color: null, borderColor: null,
    textStyle: TextStyle(fontSize: 20, color: Colors.blue, ),
    bounce: false, draggable: false,
  );
  game.add(message);
  gp.splashOver = game.currentTime() + 3.0;
}

// set up splash screen for lost game
void makeLoseSplashScreen(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  Block message = Block(game, position: Rect.fromLTWH(0, 0, gp.sizeX, gp.sizeY),
    displayText: "You Lose!\n\n\nGame Over",
    color: null, borderColor: null,
    textStyle: TextStyle(fontSize: 20, color: Colors.blue, ),
    bounce: false, draggable: false,
  );
  game.add(message);
  gp.splashOver = game.currentTime() + SPLASH_TIME;
}
