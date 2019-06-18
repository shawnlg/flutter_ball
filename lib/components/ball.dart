import 'dart:ui';
import 'package:flame/components/component.dart';

class Ball extends Component {
  // instance variables
  double x;  // the x location of the ball
  double y;  // the y location of the ball
  double speedX;  // speed in the x direction
  double speedY;  // speed in the y direction
  double sizeX;  // size of the screen in the x direction
  double sizeY;  // size of the screen in the y direction
  int lives = 10;  // how many bounces until the ball dies

  // create a ball
  Ball() : super() {
    print("new Ball");
  }

  // the game engine will tell you what the screen size is
  void resize(Size size) {
    print("ball.resize: size = $size");
  }

  // draw this component whenever the game engine tells you to
  void render(Canvas c) {

  }

  // update this component whenever the game engine tells you to
  void update(double t) {

  }


  // tell the game engine if this component should be destroyed
  // whenever it asks
  bool destroy() {
    return false;
  }

}
