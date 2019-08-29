import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';

enum DragState {
  NOT_DRAGGING,  // user not dragging anything
  DRAGGING_ME,   // user dragging this block
  DRAGGING_OTHER,// user dragging something else
}

class Shape extends Component {
  // class variables apply to all blocks
  static bool canDrag = false;  // set to true when we want blocks to be dragged

  // instance variables
  final FlutterballGame game;
  int lives;  // how many hits until the block dies
  Paint paint = Paint();  // paint the rectangle
  Paint border = Paint();  // paint the border

  // show text inside block
  TextPainter tp = TextPainter(
    textDirection: TextDirection.ltr,
    textScaleFactor: 1.5,
  );

  // create a shape
  Shape(this.game, {this.lives=10, Color color=Colors.white, Color borderColor=Colors.white,
        double borderThickness=1,
    }) : super() {
    if (color == null) {
      paint = null;
    } else {
      paint.color = color;
      paint.style = PaintingStyle.fill;
    }
    if (borderColor == null) {
      border = null;
    } else {
      border.color = borderColor;
      border.style = PaintingStyle.stroke;
      border.strokeWidth = borderThickness;
    }

  }

  void resize(Size size) {
  }

  void render(Canvas c) {
  }

  void update(double t) {
  }


  bool destroy() => lives <= 0;

}