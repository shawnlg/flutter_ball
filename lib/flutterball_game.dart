import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/ball.dart';

class FlutterballGame extends BaseGame {
  // instance variables
  bool isDragging = false;  // true when user is dragging across the screen
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // x coordinate uf oser's finger
  bool wasTapped = false;  // set to true when screen tapped
  double tapX;   // x coordinate uf oser's finger
  double tapY;   // x coordinate uf oser's finger

  // make a new game
  FlutterballGame() {
    // make new block game components
    var block = Block(this, position: Rect.fromLTWH(100, 200, 100, 50), draggableBlock: true);
    var block2 = Block(this, position: Rect.fromLTWH(200, 400, 50, 50), draggableBlock: false);

    // tell the game about this blocks
    add(block);
    add(block2);
    Block.canDrag = true;  // ok to drag blocks

    // add a ball
    Ball ball = Ball(this, speedX: 0.2, speedY: 0.3, lives: 50);
    add(ball);
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

  void onTapDown(TapDownDetails d) {
    tapX = d.globalPosition.dx;
    tapY = d.globalPosition.dy;
    wasTapped = true;
  }

}