import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/ball.dart';

enum IntroState {
  WAITING,  // waiting for screen size info
  STARTING, // putting up the intro screen
  BALLS,   // showing random balls
  PLAY,// ready to play game
  HELP, // showing help screen
  DEAD, // destroy component
}

class GameIntro extends Component {
  // constants
  static const int NUMBER_OF_BALLS = 100;
  static const double BALL_SIZE = 5.0;
  static const PaintingStyle BALL_STYLE = PaintingStyle.fill;

  // instance variables
  final FlutterballGame game;
  IntroState state = IntroState.WAITING;
  double sizeX=0;  // size of the screen in the x direction
  double sizeY=0;  // size of the screen in the y direction
  Block gameTitle;  // game title text
  Block startButton;
  Block helpButton;
  Random rnd = Random();  // rnandom number generator

  // remove all ball and block components from the game
  void clearComponents() {

  }

  // make blocks to display title and buttons
  void makeBlocks() {
    gameTitle = Block(game, position: Rect.fromLTWH(sizeX*0.1, 10, sizeX*0.8, 200),
      displayText: "Flutter\nBall", color: null, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(gameTitle);

    startButton = Block(game, position: Rect.fromLTWH(sizeX*0.3, sizeY*0.5, sizeX*0.4, 100),
      displayText: "Start", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(startButton);

    helpButton = Block(game, position: Rect.fromLTWH(sizeX*0.3, sizeY*0.8, sizeX*0.4, 100),
      displayText: "Help", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.red),
      bounce: false, draggable: false,
    );
    game.add(helpButton);

  }

  // start the balls bouncing
  void startBalls() {
    for (int i=0; i<NUMBER_OF_BALLS; i++) {
      double x = rnd.nextDouble()*sizeX;
      double y = rnd.nextDouble()*sizeY;
      double speedX = rnd.nextDouble()*0.4 - 0.2;
      double speedY = rnd.nextDouble()*0.4 - 0.2;
      Color color;
      switch (rnd.nextInt(6)) {
        case 0:
          color = Colors.white;
          break;
        case 1:
          color = Colors.blue;
          break;
        case 2:
          color = Colors.green;
          break;
        case 3:
          color = Colors.deepOrange;
          break;
        case 4:
          color = Colors.pink;
          break;
        case 5:
          color = Colors.purple;
          break;
      }
      var ball = Ball(game, color: color, size: BALL_SIZE,
          speedX: speedX, speedY: speedY, style: BALL_STYLE,
          lives: 99, sound: false, x: x, y: y );
      game.add(ball);
    } // for all balls
  }

  void resize(Size size) {
    if (size.width <= 0) return;

    // save screen width and height
    clearComponents();
    sizeX = size.width;
    sizeY = size.height;
    state = IntroState.STARTING;
  }

    // constructor
  GameIntro(this.game, ) : super() {

  }

  void render(Canvas c) => null;

  void update(double t) {
    switch (state) {
      case IntroState.STARTING:
        startBalls();
        makeBlocks();
        state = IntroState.BALLS;
        break;
      case IntroState.STARTING:
      case IntroState.DEAD:
      case IntroState.HELP:
      case IntroState.PLAY:
      case IntroState.WAITING:
      case IntroState.BALLS:
        break;
    }
  }

  bool destroy() => state == IntroState.DEAD;

}