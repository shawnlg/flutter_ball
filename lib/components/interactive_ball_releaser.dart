import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/components/ball.dart';

class InteractiveBallReleaser extends Component {
  // instance variables
  FlutterballGame game;
  bool makingLine = false;  // if we are in the middle of drawing a line during a drag
  Offset lineStart;
  Offset lineEnd;
  Paint paint = Paint();  // paint the line
  double sizeX;  // width of screen
  double sizeY;  // height of screen

  // create the component
  InteractiveBallReleaser(this.game) : super() {
    paint.color = Colors.white;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
  }

  void render(Canvas c) {
    if (makingLine) {
      c.drawLine(lineStart, lineEnd, paint);
    }
  }

  void update(double t) {
    if (!game.isDragging && !makingLine) {
      // user is not dragging and we are not making a line, so nothing to do
    } else if (game.isDragging && !makingLine) {
      // user is dragging, but we haven't yet started making a line
      lineStart = Offset(game.dragX, game.dragY);  // line starts where finger is
      lineEnd = Offset(game.dragX, game.dragY);  // line ends where it starts - single point
      makingLine = true;  // start rendering the line
    } else if (!game.isDragging && makingLine) {
      // user no longer dragging but we are still making the line
      makingLine = false;  // stop making the line
      // launch ball
      double speedX = (lineEnd.dx - lineStart.dx) / sizeX;
      double speedY = (lineEnd.dy - lineStart.dy) / sizeY;
      Ball ball = Ball(game, x:lineStart.dx, y:lineStart.dy, speedX: speedX, speedY: speedY);
      game.add(ball);
    } else {
      // user is still dragging and we are still making a line
      // just update the endpoint of the line in case user has moved finger
      lineEnd = Offset(game.dragX, game.dragY);  // line ends where it starts - single point
    }
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    sizeX = size.width;
    sizeY = size.height;
  }


}
