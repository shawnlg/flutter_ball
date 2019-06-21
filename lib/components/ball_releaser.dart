import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/ball.dart';

class BallReleaser extends Component {

  // instance variables
  FlutterballGame game;
  int lives = 10;  // how many balls to release until this component quits
  double timeOfNextBall;  // when to add another ball

  // create the component, passing in the game object
  BallReleaser(this.game) : super() {
    timeOfNextBall = game.currentTime() + 1;
  }

  void render(Canvas c) => null;

  void update(double t) {
    if (game.currentTime() < timeOfNextBall) {
      return;  // not time to make a new ball yet
    }

    // make a new ball game component
    var ball = Ball(color: Colors.blue, size: 20, speed: 0.5, style: PaintingStyle.fill);

    // tell the game about this component
    game.add(ball);

    lives--;  // one less ball to add
    timeOfNextBall++;  // next ball one second from now

  }

  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}
