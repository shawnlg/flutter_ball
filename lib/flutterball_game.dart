import 'package:flame/game.dart';
import 'package:flutter_ball/components/ball.dart';

class FlutterballGame extends BaseGame {

  // make a new game
  FlutterballGame() {
    // make a new ball game component
    var ball = Ball();

    // tell the game about this component
    add(ball);
  }

}