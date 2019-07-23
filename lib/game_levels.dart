import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/game_play.dart';


// set up splash screen for level
void makeLevelSplashScreen(FlutterballGame game, GamePlay gp) {
  const List<String> LEVEL_TEXT = [
    "Practice aiming your ball.\nHit the block by launching the ball at it.",
    "Practice aiming your ball using the red aim block.\nHit the block 3 times.",
    "Break all of the blocks.",
    "Break all of the blocks.\nWatch out for the bottom!",
    "Break all of the blocks.\nThey don't break so easily",
    "Break the square.",
    "Break the square.\nCan you do it without falling off the screen?",
    "Let's speed things up.",
    "Let the ball do the work.",
    "Time to face the challenge.",
  ];
  game.clearComponents();
  Block levelTitle = Block(
    game, position: Rect.fromLTWH(0, 0, gp.sizeX, gp.sizeY),
    displayText: "Level ${game.level}\n",
    color: null,
    borderColor: null,
    textStyle: TextStyle(fontSize: 20, color: Colors.blue,),
    bounce: false,
    draggable: false,
  );
  game.add(levelTitle);

  Block levelMessage = Block(
    game, position: Rect.fromLTWH(0, 50, gp.sizeX, 50),
    displayText: LEVEL_TEXT[game.level - 1],
    color: null,
    borderColor: null,
    textAlign: TextAlign.left,
    textStyle: TextStyle(fontSize: 12, color: Colors.blue,),
    bounce: false,
    draggable: false,
  );
  game.add(levelMessage);
}

void addBlock(FlutterballGame game, GamePlay gp, double x, double y, double width,
    {Color color : Colors.blue, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x*gp.sizeX, y*gp.sizeY, width*gp.sizeX, width*gp.sizeX);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    bounce: true, draggable: false, lives: lives,
  );
  game.add(block);
}

void addBlockExact(FlutterballGame game, GamePlay gp, double x, double y, double width,
    {Color color : Colors.blue, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x, y, width, width);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    bounce: true, draggable: false, lives: lives,
  );
  game.add(block);
}

void addAimBlock(FlutterballGame game, GamePlay gp, double x, double y, double width, double height,
    {Color color : Colors.red, int lives : 10, }) {
  Rect position = Rect.fromLTWH(x*gp.sizeX, y*gp.sizeY, width*gp.sizeX, height*gp.sizeY);
  Block block = Block(game, position: position,
    color: color, borderColor: Colors.black,
    bounce: true, draggable: true, lives: lives,
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
      double width = 0.1 * gp.sizeX;
      double col1 = 0.35*gp.sizeX;
      double col2 = 0.45*gp.sizeX;
      double col3 = 0.55*gp.sizeX;
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
      double width = 0.1 * gp.sizeX;
      double col1 = 0.35*gp.sizeX;
      double col2 = 0.45*gp.sizeX;
      double col3 = 0.55*gp.sizeX;
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
      double width = 0.1 * gp.sizeX;
      double col1 = 0.35*gp.sizeX;
      double col2 = 0.45*gp.sizeX;
      double col3 = 0.55*gp.sizeX;
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
      double width = 0.1 * gp.sizeX;
      double leftEyeCol1 = 0.15*gp.sizeX;
      double leftEyeCol2 = 0.25*gp.sizeX;
      double rightEyeCol1 = 0.6*gp.sizeX;
      double rightEyeCol2 = 0.7*gp.sizeX;

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

      double noseCenterCol = 0.45*gp.sizeX;
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
