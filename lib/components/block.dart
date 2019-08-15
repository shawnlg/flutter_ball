import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';

class Block extends Component {

  // instance variables
  final FlutterballGame game;
  int _lives;  // how many hits until the block dies
  Paint paint = Paint();  // paint the rectangle
  Rect position;  // position of block
  // show lives inside block
  TextPainter tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    textScaleFactor: 1.5,
  );

  // create a block
  Block(this.game, {this.position, Color color=Colors.white, lives=10,}) : super() {
    paint.color = color;
    paint.style = PaintingStyle.fill;
    this.lives = lives;

  }

  void set lives (int l) {
    _lives = l;
    TextSpan span = TextSpan(text: _lives.toString(), style: TextStyle(color: Colors.black));
    tp.text = span;  // text to draw
    tp.layout(minWidth: position.width, );
  }

  int get lives => _lives;

  void resize(Size size) {
  }

  void render(Canvas c) {
    // draw the block and then the text on top
    c.drawRect(position, paint);
    tp.paint(c, position.translate(0, 10).topLeft);
  }

  void update(double t) {
  }


  bool destroy() => lives <= 0;

}