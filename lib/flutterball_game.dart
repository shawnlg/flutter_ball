import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/interactive_ball_releaser.dart';

class FlutterballGame extends BaseGame {
  // instance variables
  bool isDragging = false;  // true when user is dragging across the screen
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // x coordinate uf oser's finger

  // make a new game
  FlutterballGame() {
    // make a new ball releaser game component
    var interactiveBallReleaser = InteractiveBallReleaser(this);

    // tell the game about this component
    add(interactiveBallReleaser);
  }

  // gesture handlers
  void onDragStart(DragStartDetails d) {
    isDragging = true;
    dragX = d.globalPosition.dx;
    dragY = d.globalPosition.dy;
  }

  void onDragEnd(DragEndDetails d) {
    isDragging = false;
  }

  void onDragUpdate(DragUpdateDetails d) {
    dragX = d.globalPosition.dx;
    dragY = d.globalPosition.dy;
  }

}