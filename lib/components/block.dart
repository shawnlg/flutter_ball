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
  int _lives;  // how many hits until the block dies
  Paint paint = Paint();  // paint the rectangle
  Rect position;  // position of block
  // show lives inside block
  TextPainter tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    textScaleFactor: 1.5,
  );
  
  // handle block dragging
  DragState dragState = DragState.NOT_DRAGGING;  // user not dragging
  double dragX;   // x coordinate uf oser's finger
  double dragY;   // y coordinate uf oser's finger
  final bool draggableBlock;  // if this block can be dragged

  // create a block
  Block(this.game, {this.position, Color color=Colors.white, lives=10,
        this.draggableBlock = false,}) : super() {
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
    // update position if being dragged
    if (canDrag && draggableBlock && game.isDragging) { // user currently dragging
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