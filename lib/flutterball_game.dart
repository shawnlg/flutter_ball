import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/ball_releaser.dart';

class FlutterballGame extends BaseGame {

  // make a new game
  FlutterballGame() {
    // make a new ball releaser game component
    var ballReleaser = BallReleaser(this);

    // tell the game about this component
    add(ballReleaser);
  }

}