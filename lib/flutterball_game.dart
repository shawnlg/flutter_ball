import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/text.dart';
import 'package:flutter_ball/components/interactive_ball_releaser.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/ball.dart';
import 'package:flutter_ball/components/shape.dart';
import 'package:flutter_ball/components/test_component.dart';

class FlutterballGame extends BaseGame {
  // instance variables
  int level=1;  // level we are on

  // handle gestures
  bool isDragging = false;  // true when user is dragging across the screen
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // x coordinate uf oser's finger
  bool wasTapped = false;  // set to true when screen tapped
  double tapX;   // x coordinate uf oser's finger
  double tapY;   // x coordinate uf oser's finger

  // make a new game
  FlutterballGame() {
//    List<Offset>points = [Offset(0,0),Offset(100,0), Offset(100,100), Offset(0,100)];
//    Shape shape = Shape(this,points,x: 100.0 ,y: 100.0, r:0.0, rDelta: 30.0,);
//    add(shape);

    Tester tester = Tester();
    add(tester);
  }

  // remove all ball, text, and block components from the game
  void clearComponents() {
    components.forEach((c) {
      if (c is Block) {
        c.lives = 0;
      } else if (c is Ball) {
        c.lives = 0;
      } else if (c is TextDraw) {
        c.lives = 0;
      }
    });
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

  void cancelDrag() {
    isDragging = false;
  }

}