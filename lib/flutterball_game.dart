import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/ball.dart';

class FlutterballGame extends BaseGame {

  // make a new game
  FlutterballGame() {
    // make a new ball game component
    var ball = Ball(color: Colors.blue, size: 20.0, speed: 0.5, style: PaintingStyle.fill, lives:3);

    // tell the game about this component
    add(ball);
  }

}