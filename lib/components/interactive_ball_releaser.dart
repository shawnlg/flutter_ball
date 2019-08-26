import 'dart:ui';
import 'dart:math';
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
  double width;  // width of screen
  double height;  // height of screen
  int lives; // how many lives the ball launched should have
  double speedScale;  // how much we scale speed based on line length

  // create the component
  InteractiveBallReleaser(this.game, {this.lives:1, this.speedScale:1.0}) : super() {
    paint.color = Colors.white;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    game.cancelDrag();  // in case player was dragging already
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
      double speedX = (lineEnd.dx - lineStart.dx) / width;
      double speedY = (lineEnd.dy - lineStart.dy) / height;
      if (speedScale != 0) { // fixed speed
        // get the speed of 1 screen width per second
        double currentSpeed = sqrt(speedX*speedX + speedY*speedY);
        double toNominalSpeed = 1.0 / currentSpeed;
        print("speedX: $speedX, speedy: $speedY, currentSpeed: $currentSpeed, toNominalSpeed = $toNominalSpeed");
        speedX = speedX * toNominalSpeed * speedScale;
        speedY = speedY * toNominalSpeed * speedScale;
        print("new speedX: $speedX, new speedy: $speedY");
      }

      Ball newBall = Ball(game, x: lineStart.dx, y: lineStart.dy,
          speedX: speedX, speedY: speedY,
          lives: lives, sound: true);
      game.add(newBall);
    } else {
      // user is still dragging and we are still making a line
      // just update the endpoint of the line in case user has moved finger
      lineEnd = Offset(game.dragX, game.dragY);  // line ends where it starts - single point
    }
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    width = size.width;
    height = size.height;
  }

  bool destroy() => lives <= 0;

}
