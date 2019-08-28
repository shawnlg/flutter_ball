import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/game_play.dart';
import 'package:flutter_ball/components/text.dart';

// set up splash screen for level
void makeLevelSplashScreen(FlutterballGame game, GamePlay gp) {
  game.clearComponents();

  TextStyle style = TextStyle(fontSize: 20, color: Colors.blue,);
  TextSpan span = TextSpan(text: "Level ${game.level}\n", style: style);
  TextDraw textBox = TextDraw(Rect.fromLTWH(0, 0, gp.width, gp.height), span,
    boxColor: null, borderColor: null,
  );
  game.add(textBox);
}

// add a block using fraction of screen sizes instead of pixels
void addBlock(FlutterballGame game, GamePlay gp, double x, double y, double width,
    {Color color : Colors.blue, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x*gp.width, y*gp.height, width*gp.width, width*gp.width);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    draggableBlock: false, lives: lives,
  );
  game.add(block);
}

// set up game for a particular level
void makeLevel(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  addBlock(game, gp, 0.4, 0.0, 0.1, lives: 1);
  gp.ballsLeft = 5;
  gp.ballBounces = 5;
}
