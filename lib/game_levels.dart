import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/game_play.dart';
import 'package:flutter_ball/components/text.dart';

// set up splash screen for level
void makeLevelSplashScreen(FlutterballGame game, GamePlay gp) {
  const List<String> LEVEL_TEXT = [
    "Practice aiming your ball. Hit the block by launching the ball at it.",
    "Practice aiming your ball using the red aim block. Hit the block 3 times.",
    "Break all of the blocks.",
    "Break all of the blocks. Watch out for the bottom!",
    "Break all of the blocks. They don't break so easily",
    "Break the square.",
    "Break the square. Can you do it without falling off the screen?",
    "Let's speed things up.",
    "Let the ball do the work.",
    "Time to face the challenge.",
  ];

  game.clearComponents();

  TextStyle style = TextStyle(fontSize: 20, color: Colors.blue,);
  TextSpan span = TextSpan(text: "Level ${game.level}\n", style: style);
  TextDraw textBox = TextDraw(Rect.fromLTWH(0, 0, gp.width, gp.height), span,
    boxColor: null, borderColor: null,
  );
  game.add(textBox);

  style = TextStyle(fontSize: 12, color: Colors.blue,);
  span = TextSpan(text: LEVEL_TEXT[game.level - 1], style: style);
  textBox = TextDraw(Rect.fromLTWH(0, 50, gp.width, 50), span,
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

// add a block using pixels
void addBlockExact(FlutterballGame game, GamePlay gp, double x, double y, double width,
    {Color color : Colors.blue, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x, y, width, width);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    draggableBlock: false, lives: lives,
  );
  game.add(block);
}

void addAimBlock(FlutterballGame game, GamePlay gp, double x, double y, double width, double height,
    {Color color : Colors.red, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x*gp.width, y*gp.height, width*gp.width, height*gp.height);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    draggableBlock: true, lives: lives,
  );
  game.add(block);
}


// set up game for a particular level
void makeLevel(FlutterballGame game, GamePlay gp) {
  game.clearComponents();
  gp.speedScale = 0.0; // default
  switch (game.level) {
    case 1: // one block to hit with launcher, no aiming block
      addBlock(game, gp, 0.4, 0.0, 0.1, lives: 1);
      gp.ballsLeft = 5;
      gp.ballBounces = 1;
      gp.ignoreTop = false;
      gp.ignoreBottom = false;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 2: // one block to hit using aiming block
      addBlock(game, gp, 0.4, 0.0, 0.1, lives: 3);
      addAimBlock(game, gp, 0.4, 0.5, 0.2, 0.05, lives: 10);
      gp.ballsLeft = 1;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = false;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 3: // one row of blocks and an aiming block
      addBlock(game,gp, 0.0, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.1, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.2, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.3, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.4, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.5, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.6, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.7, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.8, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.9, 0.0, 0.1, lives: 1);
      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05);
      gp.ballsLeft = 3;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = false;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 4: // one row of blocks but ignore bottom
      addBlock(game,gp, 0.0, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.1, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.2, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.3, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.4, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.5, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.6, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.7, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.8, 0.0, 0.1, lives: 1);
      addBlock(game,gp, 0.9, 0.0, 0.1, lives: 1);
      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05);
      gp.ballsLeft = 5;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = true;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 5: // 1 row of blocks - 3 lives each
      addBlock(game,gp, 0.0, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.1, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.2, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.3, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.4, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.5, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.6, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.7, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.8, 0.0, 0.1, lives: 3);
      addBlock(game,gp, 0.9, 0.0, 0.1, lives: 3);
      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05, lives: 40);
      gp.ballsLeft = 3;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = false;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 6: // square of blocks
      double width = 0.1 * gp.width;
      double col1 = 0.35*gp.width;
      double col2 = 0.45*gp.width;
      double col3 = 0.55*gp.width;
      double row1 = 30.0;
      double row2 = row1 + width;
      double row3 = row1 + 2*width;

      addBlockExact(game,gp, col1, row1, width, lives: 1);
      addBlockExact(game,gp, col2, row1, width, lives: 1);
      addBlockExact(game,gp, col3, row1, width, lives: 1);
      addBlockExact(game,gp, col1, row2, width, lives: 1);
      addBlockExact(game,gp, col2, row2, width, lives: 1);
      addBlockExact(game,gp, col3, row2, width, lives: 1);
      addBlockExact(game,gp, col1, row3, width, lives: 1);
      addBlockExact(game,gp, col2, row3, width, lives: 1);
      addBlockExact(game,gp, col3, row3, width, lives: 1);

      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05);
      gp.ballsLeft = 3;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = false;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 7: // square no sides
      double width = 0.1 * gp.width;
      double col1 = 0.35*gp.width;
      double col2 = 0.45*gp.width;
      double col3 = 0.55*gp.width;
      double row1 = 30.0;
      double row2 = row1 + width;
      double row3 = row1 + 2*width;

      addBlockExact(game,gp, col1, row1, width, lives: 1);
      addBlockExact(game,gp, col2, row1, width, lives: 1);
      addBlockExact(game,gp, col3, row1, width, lives: 1);
      addBlockExact(game,gp, col1, row2, width, lives: 1);
      addBlockExact(game,gp, col2, row2, width, lives: 1);
      addBlockExact(game,gp, col3, row2, width, lives: 1);
      addBlockExact(game,gp, col1, row3, width, lives: 1);
      addBlockExact(game,gp, col2, row3, width, lives: 1);
      addBlockExact(game,gp, col3, row3, width, lives: 1);

      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05, lives: 50);
      gp.ballsLeft = 5;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = true;
      gp.ignoreLeft = true;
      gp.ignoreRight = true;
      break;
    case 8: // speed it up
      double width = 0.1 * gp.width;
      double col1 = 0.35*gp.width;
      double col2 = 0.45*gp.width;
      double col3 = 0.55*gp.width;
      double row1 = 30.0;
      double row2 = row1 + width;
      double row3 = row1 + 2*width;

      addBlockExact(game,gp, col1, row1, width, lives: 3);
      addBlockExact(game,gp, col2, row1, width, lives: 3);
      addBlockExact(game,gp, col3, row1, width, lives: 3);
      addBlockExact(game,gp, col1, row2, width, lives: 3);
      addBlockExact(game,gp, col2, row2, width, lives: 3);
      addBlockExact(game,gp, col3, row2, width, lives: 3);
      addBlockExact(game,gp, col1, row3, width, lives: 3);
      addBlockExact(game,gp, col2, row3, width, lives: 3);
      addBlockExact(game,gp, col3, row3, width, lives: 3);

      addAimBlock(game,gp, 0.4, 0.5, 0.2, 0.05, lives: 50);
      gp.ballsLeft = 5;
      gp.ballBounces = 25;
      gp.ignoreTop = false;
      gp.ignoreBottom = true;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      gp.speedScale = 0.6;
      break;
    case 9: // several rows
      addBlock(game,gp, 0.2, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.3, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.4, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.5, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.6, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.7, 0.1, 0.1, lives: 5);
      addBlock(game,gp, 0.2, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.3, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.4, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.5, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.6, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.7, 0.3, 0.1, lives: 5);
      addBlock(game,gp, 0.2, 0.5, 0.1, lives: 5);
      addBlock(game,gp, 0.3, 0.5, 0.1, lives: 5);
      addBlock(game,gp, 0.4, 0.5, 0.1, lives: 5);
      addBlock(game,gp, 0.5, 0.5, 0.1, lives: 5);
      addBlock(game,gp, 0.6, 0.5, 0.1, lives: 5);
      addBlock(game,gp, 0.7, 0.5, 0.1, lives: 5);
      addAimBlock(game,gp, 0.4, 0.9, 0.2, 0.05, lives: 100);
      gp.ballsLeft = 3;
      gp.ballBounces = 100;
      gp.ignoreTop = false;
      gp.ignoreBottom = true;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
    case 10: // face
      double width = 0.1 * gp.width;
      double leftEyeCol1 = 0.15*gp.width;
      double leftEyeCol2 = 0.25*gp.width;
      double rightEyeCol1 = 0.6*gp.width;
      double rightEyeCol2 = 0.7*gp.width;

      double eyesRow1 = width;
      double eyesRow2 = eyesRow1 + width;

      addBlockExact(game,gp, leftEyeCol1, eyesRow1, width, lives: 5);
      addBlockExact(game,gp, leftEyeCol1, eyesRow2, width, lives: 5);
      addBlockExact(game,gp, leftEyeCol2, eyesRow1, width, lives: 5);
      addBlockExact(game,gp, leftEyeCol2, eyesRow2, width, lives: 5);
      addBlockExact(game,gp, rightEyeCol1, eyesRow1, width, lives: 5);
      addBlockExact(game,gp, rightEyeCol1, eyesRow2, width, lives: 5);
      addBlockExact(game,gp, rightEyeCol2, eyesRow1, width, lives: 5);
      addBlockExact(game,gp, rightEyeCol2, eyesRow2, width, lives: 5);

      double noseCenterCol = 0.45*gp.width;
      double noseLeftCol = noseCenterCol - 0.5*width;
      double noseRightCol = noseCenterCol + 0.5*width;
      double noseRow1 = width*6;
      double noseRow2 = noseRow1 + width;

      addBlockExact(game,gp, noseCenterCol, noseRow1, width, lives: 4);
      addBlockExact(game,gp, noseLeftCol, noseRow2, width, lives: 4);
      addBlockExact(game,gp, noseRightCol, noseRow2, width, lives: 4);

      addBlock(game,gp, 0.0, 0.5, 0.1, lives: 3);
      addBlock(game,gp, 0.1, 0.55, 0.1, lives: 3);
      addBlock(game,gp, 0.2, 0.55, 0.1, lives: 3);
      addBlock(game,gp, 0.3, 0.6, 0.1, lives: 3);
      addBlock(game,gp, 0.4, 0.6, 0.1, lives: 3);
      addBlock(game,gp, 0.5, 0.6, 0.1, lives: 3);
      addBlock(game,gp, 0.6, 0.6, 0.1, lives: 3);
      addBlock(game,gp, 0.7, 0.55, 0.1, lives: 3);
      addBlock(game,gp, 0.8, 0.55, 0.1, lives: 3);
      addBlock(game,gp, 0.9, 0.5, 0.1, lives: 3);

      addAimBlock(game,gp, 0.4, 0.8, 0.2, 0.05, lives: 100);
      gp.ballsLeft = 5;
      gp.ballBounces = 50;
      gp.ignoreTop = false;
      gp.ignoreBottom = true;
      gp.ignoreLeft = false;
      gp.ignoreRight = false;
      break;
      break;
    default:
  }

}
