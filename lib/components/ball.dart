import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';

class Ball extends Component {

  // instance variables
  final FlutterballGame game;
  double ballSize;  // radius of ball circle in pixels
  double speedScaleX;  // how many times screen width the x speed will be
  double speedScaleY;  // how many times screen width the y speed will be
  double x;  // the x location of the ball
  double y;  // the y location of the ball
  double speedX=0;  // speed in the x direction
  double speedY=0;  // speed in the y direction
  double sizeX=0;  // size of the screen in the x direction
  double sizeY=0;  // size of the screen in the y direction
  int lives = 10;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle
  final bool sound; // if bounce sound

  // create a ball
  Ball(this.game, {this.x=0, this.y=0, this.sound=true, this.lives=100, Color color=Colors.white, double size=10, double speedX=1, double speedY=1, PaintingStyle style = PaintingStyle.stroke}) : super() {
    paint.color = color;
    paint.strokeWidth = 1;
    paint.style = style;
    ballSize = size;
    speedScaleX = speedX;
    speedScaleY = speedY;
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    // save screen width and height
    sizeX = size.width;
    sizeY = size.height;

    // set the speed of the ball
    // travel in the x and y direction at the speed of speedScale screen widths/heights per second
    speedX = sizeX*speedScaleX;
    speedY = sizeY*speedScaleY;
  }

  // draw this component whenever the game engine tells you to
  void render(Canvas c) {
    c.drawCircle(Offset(x,y), ballSize, paint);
  }

  // update this component whenever the game engine tells you to
  void update(double t) {
    // don't update until size is set
    if (sizeX < 1 || sizeY < 1) return;

    // move the ball
    x += t*speedX;
    y += t*speedY;

    if (screenBounce() || blockBounce(t)) {
      // play sound
      if (sound) Flame.audio.play('bounce.wav');
      lives--;  // lost a life after a bounce
    }

  }

  // check if we bounced off the edge of the screen
  bool screenBounce() {
    if (x < 0) {  // off the vertical edge
      speedX = -speedX;  // reverse x direction
      x = 0;  // move back into screen
      return true;
    } else if (x > sizeX) {
      speedX = -speedX;  // reverse x direction
      x = sizeX;  // move back into screen
      return true;
    } else if (y < 0) {
      speedY = -speedY;  // reverse y direction
      y = 0;  // move back into screen
      return true;
    } else if (y > sizeY) {
      speedY = -speedY;  // reverse y direction
      y = sizeY;  // move back into screen
      return true;
    } else {
      return false;
    }
  }

  // check if we bounced off a block
  bool blockBounce(double t) {
    bool bounced = false;  // set to true if we bounced off any block

    // go through the game components
    game.components.forEach((component) {
      if (component is Block) {
        Block block = component;  // reference this component as a block

        if (block.bounce && block.position.contains(Offset(x,y))) {
          // ball is inside this block, so we bounced
          bounced = true;
          block.lives--;

          // see if we are closes to an x side of the block (left, right) or a y side (top, buttom)
          double closestX = min(x - block.position.topLeft.dx, block.position.topRight.dx - x);
          double closestY = min(y - block.position.topLeft.dy, block.position.bottomLeft.dy - y);
          if (closestX < closestY) {
            // we are closest to the left/right of the block, so we hit a vertical edge
            speedX = -speedX;  // reverse x direction
          } else {
            // we are closest to the top/bottom of the block, so we hit a horizontal edge
            speedY = -speedY;  // reverse y direction
          }

          // move ball until it is outside of block again
          while (block.position.contains(Offset(x,y))) {
            // move the ball
            x += t*speedX;
            y += t*speedY;
          } // while ball inside block
        } // if ball inside block
      } // if this component is a block
    });

    return bounced;
  }

  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}
