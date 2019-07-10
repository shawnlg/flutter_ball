import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';

enum DragState {
  NOT_DRAGGING,  // user not dragging anything
  DRAGGING_ME,   // user dragging this block
  DRAGGING_OTHER,// user dragging something else
}

class Block extends Component {
  // class variables apply to all blocks
  static bool canDrag = false;  // set to true when we want blocks to be dragged

  // instance variables
  final FlutterballGame game;
  final bool draggable;  // if this block can be dragged
  final bool bounce;  // true if ball can bounce off of this block
  int lives;  // how many hits until the block dies
  Paint paint = Paint();  // paint the rectangle
  Paint border = Paint();  // paint the border
  Rect position;  // position of block

  // show text inside block
  String displayText;  // what to display
  String previousText;  // to detect if text changes
  TextStyle textStyle = TextStyle(color: Colors.white);  // how to display text
  TextSpan textSpan;  // used to paint text
  TextPainter tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    textScaleFactor: 1.5,
  );

  // handle block dragging
  DragState dragState = DragState.NOT_DRAGGING;  // user not dragging
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // y coordinate uf oser's finger

  // create a block
  Block(this.game, {this.position, this.lives=10, this.displayText=null,
        Color color=Colors.white, Color borderColor=Colors.white,
        this.textStyle,
        this.bounce=true,
        double borderThickness=1, this.draggable=true,
    }) : super() {
    paint.color = color;
    paint.style = PaintingStyle.fill;
    border.color = borderColor;
    border.style = PaintingStyle.stroke;
    border.strokeWidth = borderThickness;
  }

  void resize(Size size) {
  }

  void render(Canvas c) {
    // draw the block, the border, and then the text on top
    c.drawRect(position, paint);
    c.drawRect(position, border);
    if (displayText != null) {
      tp.paint(c, position.translate(0, 10).topLeft);
    }
  }

  void update(double t) {
    // see if we have to update the text being displayed
    if (displayText != null && displayText != previousText) {
      textSpan = TextSpan(text: displayText, style: textStyle);
      tp.text = textSpan;  // text to draw
      tp.layout(minWidth: position.width, );
      previousText = displayText;  // only update once
    }

    // update position if being dragged
    if (draggable && canDrag && game.isDragging) { // user currently dragging
      if (dragState == DragState.NOT_DRAGGING) {
        // nothing is being dragged yet, so it might be this block
        dragX = game.dragX; // record where dragging started
        dragY = game.dragY;
        if (position.contains(Offset(dragX,dragY))) {
          // we are being dragged
          dragState = DragState.DRAGGING_ME;
        } else {
          // something else being dragged
          dragState = DragState.DRAGGING_OTHER;
        }
      } else if (dragState == DragState.DRAGGING_ME) {
        // this block was already being dragged, so move it
        position = position.translate(game.dragX - dragX, game.dragY - dragY);
        dragX = game.dragX; // record last finger position
        dragY = game.dragY;
      }
    } else {
      // user not dragging
      dragState = DragState.NOT_DRAGGING;
    }
  }


  bool destroy() => lives <= 0;

}