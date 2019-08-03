import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';

class Ball extends Component {
  // instance variables
  double ballSize;  // radius of ball circle in pixels
  double speedScaleX;  // how many times screen width the x speed will be
  double speedScaleY;  // how many times screen width the y speed will be
  double x = 0;  // the x location of the ball
  double y = 0;  // the y location of the
  double speedX;  // speed in the x direction
  double speedY;  // speed in the y direction
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  int lives;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle

  // create a ball
  Ball({this.x:0, this.y:0, color:Colors.white, size:10.0, speedX=1.0, speedY=1.0, style = PaintingStyle.stroke, this.lives:10}) : super() {
    paint.color = color;
    paint.strokeWidth = 1;
    paint.style = style;
    ballSize = size;
    speedScaleX = speedX;
    speedScaleY = speedY;
    print("Ball x=$x y=$y size=$size speedX=$speedX speedY=$speedY");
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    width = size.width;
    height = size.height;

    // set the speed of the ball
    // travel in the x and y direction at the speed of speedScale screen widths per second
    speedX = width*speedScaleX;
    speedY = height*speedScaleY;
  }

  // draw this component whenever the game engine tells you to
  void render(Canvas c) {
    c.drawCircle(Offset(x,y), ballSize, paint);
  }

  // update this component whenever the game engine tells you to
  void update(double t) {
    bool bounce=false;

    // move the ball
    x += t*speedX;
    y += t*speedY;

    // change direction if ball crosses edge
    if (x < 0) {  // off the left edge
      speedX = -speedX;  // reverse direction
      x = 0;  // put it back at the left edge
      lives--;  // a bounce loses a life
      bounce = true;
    }
    if (x > width) {
      speedX = -speedX;
      x = width;
      lives--;
      bounce = true;
    }
    if (y < 0) {
      speedY = -speedY;
      y = 0;
      lives--;
      bounce = true;
    }
    if (y > height) {
      speedY = -speedY;
      y = height;
      lives--;
      bounce = true;
    }

    if (bounce) {
      // play sound
      Flame.audio.play('bounce.wav');
    }

  }


  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}
