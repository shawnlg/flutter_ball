import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class TextDraw extends Component {
  // instance variables
  int lives = 1;  // used to destroy the component
  Paint paint;  // paint the rectangle
  Paint border;  // paint the border
  Rect position;  // position of block
  final topMargin;

  // show text inside box
  TextSpan textSpan;  // used to paint text
  TextPainter tp = TextPainter(
    textDirection: TextDirection.ltr,
  );

  TextDraw(this.position, this.textSpan, {
    this.topMargin:0.0,
    Color boxColor, Color borderColor,
    textAlign:TextAlign.center,
    borderThickness:1.0, scale:2.0,
  }) : super() {
    if (boxColor != null) {
      paint = Paint();
      paint.color = boxColor;
      paint.style = PaintingStyle.fill;
    }
    if (borderColor != null) {
      border = Paint();
      border.color = borderColor;
      border.style = PaintingStyle.stroke;
      border.strokeWidth = borderThickness;
    }

    tp.textAlign = textAlign;
    tp.textScaleFactor = scale;
    tp.text = textSpan;  // text to draw
    tp.layout(minWidth: position.width, maxWidth: position.width, );

    // see if box is too short
    if (tp.height > position.height) {
      position = Rect.fromLTRB(position.left, position.top, position.right, position.top + tp.height);
    }

  }

  // change text being displayed
  set text(TextSpan span) {
    tp.text = span;
    tp.layout(minWidth: position.width, maxWidth: position.width,);

    // see if box is too short
    if (tp.height > position.height) {
      position = Rect.fromLTRB(position.left, position.top, position.right,
          position.top + tp.height);
    }
  }

  void resize(Size size) {
  }

  void render(Canvas c) {
    // draw the box, the border, and then the text on top
    if (paint != null) c.drawRect(position, paint);
    if (border != null) c.drawRect(position, border);
    tp.paint(c, Offset(position.left, position.top + topMargin));
  }

  void update(double t) {
  }

  bool destroy() => lives <= 0;

}