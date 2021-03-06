import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';

enum DragState {
  NOT_DRAGGING,  // user not dragging anything
  DRAGGING_ME,   // user dragging this block
  DRAGGING_OTHER,// user dragging something else
}

class Shape extends Component {
  // instance variables
  final FlutterballGame game;
  int _lives;  // how many hits until the block dies
  Paint paint = Paint();  // paint the rectangle
  Paint border = Paint();  // paint the border
  List<Offset> points;  // coordinates of shape non-rotated centered at 0,0
  List<Offset> _points;  // coordinates of currently drawn shape used for bounce detection
  double x=0;  // center of shape
  double y=0;  // center of shape
  double _x=0;  // previous center of shape
  double _y=0;  // previous center of shape
  double r=0;  // angle of rotation
  double _r=0;  // previous angle of rotation
  double dx=0;  // speed of x
  double dy=0;  // speed of y
  double dr=0;  // speed of rotation
  Path drawPath;  // shape to be drawn

  // show lives inside block
  TextPainter tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    textScaleFactor: 1.5,
  );

  // create a shape
  Shape(this.game, this.points, {lives:10, Color color=Colors.white, Color borderColor=Colors.white,
        this.x, this.y, this.r,
        xDelta:0.0, yDelta:0.0, rDelta:0.0,
        double borderThickness=1,
    }) : super() {
    dx = xDelta;
    dy = yDelta;
    dr = rDelta;
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

    normalize();  // center shape around 0,0
    transform();  // move/rotate shape if necessary
    this.lives = lives;
  }

  void set lives (int l) {
    _lives = l;
    TextSpan span = TextSpan(text: _lives.toString(), style: TextStyle(color: Colors.black));
    tp.text = span;  // text to draw
    double width = drawPath.getBounds().width;
    tp.layout(minWidth: 10, );
  }


  // normalize the list of shape points so they are around 0,0
  void normalize() {
    // make a path with shape
    Path path = Path();
    path.addPolygon(points, true);

    // get center of polygon
    Offset center = path.getBounds().center;

    // subtract center from each point in the list to move it to 0,0
    for (int i=0; i<points.length; i++) {
      points[i] = points[i].translate(-center.dx, -center.dy);
    }

    // move path by subtracting center also
    // and set that as the drawing path
    drawPath = path.shift(Offset(-center.dx, -center.dy));
  }

  // rotate a point around 0,0 by angle
  // then move it by x,y
  static Offset rotatePoint(Offset point, double angle, double x, double y) {
    angle = angle * (pi/180); // Convert to radians
    var _x = cos(angle) * point.dx - sin(angle) * point.dy;
    var _y = sin(angle) * point.dx + cos(angle) * point.dy;
    return Offset(_x+x,_y+y);
  }

  // rotate a list of points around 0,0 by angle
  // then move them by x,y
  static List<Offset> rotatePoints(List<Offset> points, double angle, double x, double y) {
    var newPoints = List<Offset>();
    points.forEach((point) => newPoints.add(rotatePoint(point,angle,x,y)));
    return newPoints;
  }

  // transform the shape with possibly new rotation and x,y
  void transform() {
    // see if we need to rotate
    if (r != _r) {
      // rotation angle changed
      List<Offset> newPoints = rotatePoints(points,r,x,y);
      drawPath = Path();  // new path with rotated points
      drawPath.addPolygon(newPoints, true);
      _r = r;  // reset previous
      _x = x;  // we put shape back to 0,0
      _y = y;
      _points = newPoints;  // points are up to date with path
    }

    // see if we need to move
    if (x != _x || y != _y) {
      // we just need to move path by the difference
      drawPath = drawPath.shift(Offset(x-_x, y-_y));
      _x = x;  // reset previous position
      _y = y;
      _points = null;  // need to recreate if needed
    }
  }

  void resize(Size size) {
  }

  void render(Canvas c) {
    if (paint != null) c.drawPath(drawPath, paint);
    if (border != null) c.drawPath(drawPath, border);
    tp.paint(c, Offset(x-10,y-10));
  }

  void update(double t) {
    // move/rotate the shape
    x += t*dx;
    y += t*dy;
    r += t*dr;
    transform();  // do any necessary movement of shape points
  }


  bool destroy() => _lives <= 0;

}