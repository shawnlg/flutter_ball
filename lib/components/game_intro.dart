import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/text.dart';
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
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  TextDraw gameTitle;  // game title text
  TextDraw startButton;
  TextDraw helpButton;
  Random rnd = Random();  // rnandom number generator

  // constructor
  GameIntro(this.game, ) : super() {
  }

  // make blocks to display title and buttons
  void makeBlocks() {
    TextStyle titleStyle = TextStyle(fontSize: 40, color: Colors.blue);
    TextSpan titleSpan = TextSpan(text: "Flutter\nBall", style: titleStyle);
    gameTitle = TextDraw(Rect.fromLTWH(width*0.1, 10.0, width*0.8, 200.0), titleSpan,
      boxColor: null, borderColor: null,
    );
    game.add(gameTitle);

    TextStyle startStyle = TextStyle(fontSize: 25, color: Colors.blue);
    TextSpan startSpan = TextSpan(text: "Start", style: startStyle);
    startButton = TextDraw(Rect.fromLTWH(width*0.3, height*0.6, width*0.4, 80), startSpan,
      boxColor: Colors.blueGrey, borderColor: null, topMargin: 10.0,
    );
    game.add(startButton);

    TextStyle helpStyle = TextStyle(fontSize: 25, color: Colors.red);
    TextSpan helpSpan = TextSpan(text: "Help", style: helpStyle);
    helpButton = TextDraw(Rect.fromLTWH(width*0.3, height*0.8, width*0.4, 80), helpSpan,
      boxColor: Colors.blueGrey, borderColor: null, topMargin: 10.0,
    );
    game.add(helpButton);
  }

  // start the balls bouncing
  void startBalls() {
    for (int i=0; i<NUMBER_OF_BALLS; i++) {
      double x = rnd.nextDouble()*width;
      double y = rnd.nextDouble()*height;
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
    width = size.width;
    height = size.height;
    state = IntroState.STARTING;
  }

  void render(Canvas c) => null;

  void update(double t) {
    switch (state) {
      case IntroState.STARTING:
        startBalls();
        makeBlocks();
        state = IntroState.BALLS;
        break;
      default:
    }
  }

  bool destroy() => state == IntroState.DEAD;

}