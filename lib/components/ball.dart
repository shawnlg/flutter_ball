import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class Ball extends Component {
  // instance variables
  double x = 0;  // the x location of the ball
  double y = 0;  // the y location of the
  double width;  // width of screen
  double height;  // height of screen
  double speedX;  // speed in the x direction
  double speedY;  // speed in the y direction
  double sizeX;  // size of the screen in the x direction
  double sizeY;  // size of the screen in the y direction
  int lives = 10;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle

  // create a ball
  Ball() : super() {
    print("new Ball");
    paint.color = Colors.green;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    print("ball.resize: size = $size");
    // save screen width and height
    width = size.width;
    height = size.height;

    // set the speed of the ball
    // travel in the x and y direction at the speed of 1/5 screen width per second
    speedX = width/5;
    speedY = width/5;
  }

  // draw this component whenever the game engine tells you to
  void render(Canvas c) {
    c.drawCircle(Offset(x,y), 10, paint);
  }

  // update this component whenever the game engine tells you to
  void update(double t) {
    // move the ball
    x += t*speedX;
    y += t*speedY;

    // change direction if ball crosses edge
    if (x < 0) {
      speedX = -speedX;
      x = 0;
      lives--;
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
  bool destroy() {
    if (lives > 0) {  // not dead yet
      return false;
    } else {  // dead
      return true;
    }
  }

}
