import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class Ball extends Component {
  // instance variables
  double ballSize;  // radius of ball circle in pixels
  double speedScale;  // how many times screen width the speed will be
  double x = 0;  // the x location of the ball
  double y = 0;  // the y location of the
  double speedX=0;  // speed in the x direction
  double speedY=0;  // speed in the y direction
  double sizeX=0;  // size of the screen in the x direction
  double sizeY=0;  // size of the screen in the y direction
  int lives = 10;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle

  // create a ball
  Ball({Color color=Colors.white, double size=10, double speed=1, PaintingStyle style = PaintingStyle.stroke}) : super() {
    paint.color = color;
    paint.strokeWidth = 1;
    paint.style = style;
    ballSize = size;
    speedScale = speed;
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    sizeX = size.width;
    sizeY = size.height;

    // set the speed of the ball
    // travel in the x and y direction at the speed of speedScale screen widths per second
    speedX = sizeX*speedScale;
    speedY = sizeX*speedScale;
  }

  // draw this component whenever the game engine tells you to
  void render(Canvas c) {
    c.drawCircle(Offset(x,y), ballSize, paint);
  }

  // update this component whenever the game engine tells you to
  void update(double t) {
    // move the ball
    x += t*speedX;
    y += t*speedY;

    // change direction if ball crosses edge
    if (x < 0) {  // off the left edge
      speedX = -speedX;  // reverse direction
      x = 0;  // put it back at the left edge
      lives--;  // a bounce loses a life
    }
    if (x > sizeX) {
      speedX = -speedX;
      x = sizeX;
      lives--;
    }
    if (y < 0) {
      speedY = -speedY;
      y = 0;
      lives--;
    }
    if (y > sizeY) {
      speedY = -speedY;
      y = sizeY;
      lives--;
    }

  }


  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}
