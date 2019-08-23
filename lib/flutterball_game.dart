import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/ball_releaser.dart';
import 'package:flutter_ball/components/interactive_ball_releaser.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/ball.dart';
import 'package:flutter_ball/components/game_intro.dart';

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
    GameIntro intro = GameIntro(this);
    add(intro);
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