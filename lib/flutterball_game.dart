import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flutter_ball/components/text.dart';

class FlutterballGame extends BaseGame {
  // instance variables
  bool isDragging = false;  // true when user is dragging across the screen
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // x coordinate uf oser's finger
  bool wasTapped = false;  // set to true when screen tapped
  double tapX;   // x coordinate uf oser's finger
  double tapY;   // x coordinate uf oser's finger

  // make a new game
  FlutterballGame() {
    // add simple text block to game
    Rect pos = Rect.fromLTRB(100, 100, 200, 200);
    TextStyle style = TextStyle(color: Colors.black, fontSize: 10, );
    TextSpan span = TextSpan(text: "By default, text is centered.  Notice how the box grows to hold the text.", style: style);
    var text = TextDraw(pos, span, borderColor: Colors.green, boxColor: Colors.lightBlueAccent);
    add(text);

    // add complex text to game
    pos = Rect.fromLTRB(  0, 500, 500, 600);
    span = TextSpan(
      text: 'Can you ',
      style: TextStyle(color: Colors.yellow),
      children: <InlineSpan>[
        TextSpan(
          text: 'find the',
          style: TextStyle(
            color: Colors.green,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
        TextSpan(
          text: ' secret?\n',
        ),
      ],
    );
    text = TextDraw(pos, span, textAlign: TextAlign.left);
    add(text);
  }

  // gesture handlers
  void onDragStart(DragStartDetails d) {
    isDragging = true;
    dragX = d.globalPosition.dx;
    dragY = d.globalPosition.dy;
  }

  void onDragEnd(DragEndDetails d) {
    isDragging = false;
  }

  void onDragUpdate(DragUpdateDetails d) {
    dragX = d.globalPosition.dx;
    dragY = d.globalPosition.dy;
  }

  void onTapDown(TapDownDetails d) {
    tapX = d.globalPosition.dx;
    tapY = d.globalPosition.dy;
    wasTapped = true;
  }

}