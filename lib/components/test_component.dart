import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/bounce.dart';

class Tester extends Component {

  // instance variables
  Paint bounceLinePaint = Paint();  // paint the rectangle
  Paint ballLinePaint = Paint();  // paint the rectangle
  Paint reboundLinePaint = Paint();  // paint the rectangle

  // ball location
  var xBall = 40.0;
  var yBall = 120.0;

  // ball speed
  var xSpeed = 30.0;
  var ySpeed = -30.0;

  // bounce line
  var x1Bounce = 10.0;
  var y1Bounce = 110.0;
  var x2Bounce = 100.0;
  var y2Bounce = 110.0;

  // rebound speed
  var xRebound;
  var yRebound;

  Tester() : super() {
    bounceLinePaint.color = Colors.red;
    bounceLinePaint.style = PaintingStyle.stroke;
    bounceLinePaint.strokeWidth = 1.0;
    ballLinePaint.color = Colors.white;
    ballLinePaint.style = PaintingStyle.stroke;
    ballLinePaint.strokeWidth = 1.0;
    reboundLinePaint.color = Colors.blue;
    reboundLinePaint.style = PaintingStyle.stroke;
    reboundLinePaint.strokeWidth = 1.0;

    // tweak 45 0 135
    y1Bounce += 10; // 45 173 135

    print("ball speed: $xSpeed, $ySpeed");
    double angle = angleOfLine(xBall, yBall, xBall+xSpeed, yBall+ySpeed);
    print("angle of ball line: ${angle*180/pi}");
    angle = angleOfLine(x1Bounce, y1Bounce, x2Bounce, y2Bounce);
    print("angle of bounce line: ${angle*180/pi}");

    // call the bouncer
    // existing angles: 135 90 45
    // bounce line top right 10
    Offset o = bounceLine(xBall, yBall, xSpeed, ySpeed, 1, x1Bounce, y1Bounce, x2Bounce, y2Bounce);
    if (o != null) {
      xRebound = o.dx;
      yRebound = o.dy;
      print("new ball speed: $xRebound, $yRebound");
      double angle = angleOfLine(xBall+xSpeed, yBall+ySpeed,
                                 xBall+xSpeed+xRebound, yBall+ySpeed+yRebound);
      print("angle of rebound line: ${angle*180/pi}");
    }
  }


  void resize(Size size) {
  }

  void render(Canvas c) {
    c.drawLine(Offset(xBall, yBall), Offset(xBall+xSpeed, yBall+ySpeed), ballLinePaint);
    c.drawLine(Offset(x1Bounce, y1Bounce), Offset(x2Bounce, y2Bounce), bounceLinePaint);
    if (xRebound != null) {
      c.drawLine(Offset(xBall+xSpeed, yBall+ySpeed),Offset(xBall+xSpeed+xRebound, yBall+ySpeed+yRebound), reboundLinePaint);
    }
  }

  void update(double t) {
  }

}