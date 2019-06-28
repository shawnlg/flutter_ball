import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/ball_releaser.dart';
import 'package:flutter_ball/components/interactive_ball_releaser.dart';
import 'package:flutter_ball/components/drum.dart';

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
    // make a new drum game component
    var drum = Drum(this,50,50,100,'drum/frame drum.jpg','drum/frame drum.wav');

    // tell the game about this component
    add(drum);
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