import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class Ball extends Component {
  // instance variables
  double ballSize;  // radius of ball circle in pixels
  double speedScale;  // how many times screen width the speed will be
  double x = 0;  // the x location of the ball
  double y = 0;  // the y location of the
  double speedX;  // speed in the x direction
  double speedY;  // speed in the y direction
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  int lives;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle

  // create a ball
  Ball({color:Colors.white, size:10.0, speed:1.0, style:PaintingStyle.stroke, this.lives:10}) : super() {
    paint.color = color;
    paint.strokeWidth = 1;
    paint.style = style;
    ballSize = size;
    speedScale = speed;
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    width = size.width;
    height = size.height;

    // set the speed of the ball
    // travel in the x and y direction at the speed of speedScale screen widths per second
    speedX = width*speedScale;
    speedY = width*speedScale;
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
    if (x > width) {
      speedX = -speedX;
      x = width;
      lives--;
    }
    if (y < 0) {
      speedY = -speedY;
      y = 0;
      lives--;
    }
    if (y > height) {
      speedY = -speedY;
      y = height;
      lives--;
    }

  }


  // tell the game engine if this component should be destroyed
  // whenever it asks
/*  bool destroy() {
    if (lives > 0) {  // not dead yet
      return false;
    } else {  // dead
      return true;
    }
  }
*/
  bool destroy() => lives <= 0;

}
