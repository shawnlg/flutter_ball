import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/ball.dart';

class BallReleaser extends Component {

  // instance variables
  FlutterballGame game;
  int lives = 100;  // how many balls to release until this component quits
  double timeOfNextBall;  // when to add another ball
  Random rnd;  // rnandom number generator

  // create the component, passing in the game object
  BallReleaser(this.game) : super() {
    timeOfNextBall = game.currentTime() + 1;
    rnd = Random();
  }

  void render(Canvas c) => null;

  void update(double t) {
    if (game.currentTime() < timeOfNextBall) {
      return;  // not time to make a new ball yet
    }

    // make a new ball game component with some random values
    double speedX = rnd.nextDouble()*1.8 + 0.2;  // x speed between 0.2 and 2
    double speedY = rnd.nextDouble()*1.8 + 0.2;  // y speed between 0.2 and 2
    double size = rnd.nextDouble()*16 + 5;  // size between 5 and 20
    PaintingStyle style = rnd.nextBool() ? PaintingStyle.stroke : PaintingStyle.fill;
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
    var ball = Ball(color: color, size: size, speedX: speedX, speedY: speedY, style: style);

    // tell the game about this component
    game.add(ball);

    lives--;  // one less ball to add

    // next ball comes between .5 seconds and 2 secons from now
    timeOfNextBall += rnd.nextDouble()*1.5 + 0.5;

  }

  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}

