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
  double y;  // the y location of the
  double speedX;  // speed in the x direction
  double speedY;  // speed in the y direction
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  int lives;  // how many bounces until the ball dies
  Paint paint = Paint();  // paint the ball circle

  // create a ball
  Ball(this.game, {this.x:0, this.y:0, color:Colors.white, size:10.0, speedX=1.0, speedY=1.0, style = PaintingStyle.stroke, this.lives:10}) : super() {
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
    // don't update until size is set
    if (width < 1 || height < 1) return;

    // move the ball
    x += t*speedX;
    y += t*speedY;

    if (screenBounce() || blockBounce(t)) {
      // play sound
      Flame.audio.play('bounce.wav');
      lives--;  // lost a life after a bounce
    } // if we did a bounce
  }

  // check if we bounced off the edge of the screen
  bool screenBounce() {
    if (x < 0) {  // off the vertical edge
      speedX = -speedX;  // reverse x direction
      x = 0;  // move back into screen
      return true;
    } else if (x > width) {
      speedX = -speedX;  // reverse x direction
      x = width;  // move back into screen
      return true;
    } else if (y < 0) {
      speedY = -speedY;  // reverse y direction
      y = 0;  // move back into screen
      return true;
    } else if (y > height) {
      speedY = -speedY;  // reverse y direction
      y = height;  // move back into screen
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

        if (block.position.contains(Offset(x,y))) {
          // ball is inside this block, so we bounced
          bounced = true;
          block.lives--;

          // bounce off of block
          if (block.draggableBlock == false) {
            normalBounce(block);
          } else {  // a draggable block is one you use to aim with
            aimBounce(block);
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

  // bounce off of a normal block.  Just the direction changes
  void normalBounce(Block block) {
    // see if we are closes to an x side of the block (left, right) or a y side (top, buttom)
    double closestX = min(x - block.position.left, block.position.right - x);
    double closestY = min(y - block.position.top, block.position.bottom - y);
    if (closestX < closestY) {
      // we are closest to the left/right of the block, so we hit a vertical edge
      speedX = -speedX;  // reverse x direction
    } else {
      // we are closest to the top/bottom of the block, so we hit a horizontal edge
      speedY = -speedY;  // reverse y direction
    }
  }

  // bounce off of an aiming block.  You adjust the direction by where the ball
  // hits the block
  void aimBounce(Block block) {
    // see if we are closes to an x side of the block (left, right) or a y side (top, buttom)
    double closestX = min(x - block.position.left, block.position.right - x);
    double closestY = min(y - block.position.top, block.position.bottom - y);
    double totalSpeed = speedX.abs() + speedY.abs();  // we divide up the speed by how the block is hit

    if (closestX < closestY) {
      // we are closest to the left/right of the block, so we hit a vertical edge
      if (x - block.position.topLeft.dx < block.position.topRight.dx - x) {
        // we hit the left side of the block

        // make an aim number where the ball hit the left side of
        // the block.  -1 means top left, 0 is middle left, 1 is bottom left.
        // This number determines how much of the speed goes in the y direction.
        double middle = (block.position.top + block.position.bottom) / 2;
        double aim = (y - middle)/block.position.height*2;
        speedY = totalSpeed * aim;  // ball can go up or down depending on aim
        speedX = -(totalSpeed - speedY.abs()); // ball goes to the left
      } else {
        // we hit the right side of the block

        // make an aim number where the ball hit the right side of
        // the block.  -1 means top right, 0 is middle right, 1 is bottom right.
        // This number determines how much of the speed goes in the y direction.
        double middle = (block.position.top + block.position.bottom) / 2;
        double aim = (y - middle)/block.position.height*2;
        speedY = totalSpeed * aim;  // ball can go up or down depending on aim
        speedX = totalSpeed - speedY.abs(); // ball goes to the right
      }
    } else {
      // we are closest to the top/bottom of the block, so we hit a horizontal edge
      if (y - block.position.topLeft.dy < block.position.bottomLeft.dy - y) {
        // we hit the top of the block

        // make an aim number where the ball hit the top side of
        // the block.  -1 means top left, 0 is top middle, 1 is top right.
        // This number determines how much of the speed goes in the x direction.
        double middle = (block.position.left + block.position.right) / 2;
        double aim = (x - middle)/block.position.width*2;
        speedX = totalSpeed * aim;  // ball can go left or right depending on aim
        speedY = -(totalSpeed - speedX.abs()); // ball goes up
      } else {
        // we hit the bottom of the block

        // make an aim number where the ball hit the bottom side of
        // the block.  -1 means bottom left, 0 is bottom middle, 1 is bottom right.
        // This number determines how much of the speed goes in the x direction.
        double middle = (block.position.left + block.position.right) / 2;
        double aim = (x - middle)/block.position.width*2;
        speedX = totalSpeed * aim;  // ball can go left or right depending on aim
        speedY = totalSpeed - speedX.abs(); // ball goes down
      }
    }

  }

  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() => lives <= 0;

}
