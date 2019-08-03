import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/drum.dart';

enum State {
  STARTUP,  // game is starting up, no size yet
  READY,    // game is ready to start adding components
  TAP,      // in tap mode, just play what is tapped
  RECORD,   // record a drum loop
  PLAY,     // play a recorded drum loop
}

class DrumController extends Component {
  // instance variables
  FlutterballGame game;
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  double pctX=0;  // pixels as a percentage
  double pctY=0;  // pixels as a percentage
  State state = State.STARTUP;
  List<Drum> drums;

  // constructor
  DrumController(this.game) : super() {
  }

  void render(Canvas c) => null;

  void update(double t) {
    // what we do depends on the state of the drum machine
    switch (state) {
      case State.READY:
        // create the drums
        drums = [
          Drum(game, pctX*10, pctY*10, pctX*20, 'drum/frame drum.jpg', 'drum/frame drum.wav'),
          Drum(game, pctX*40, pctY*10, pctX*20, 'drum/cymbols.jpg', 'drum/cymbols.wav'),
          Drum(game, pctX*70, pctY*10, pctX*20, 'drum/echo.jpg', 'drum/echo.wav'),
          Drum(game, pctX*10, pctY*30, pctX*20, 'drum/woodblock.jpg', 'drum/woodblock.wav'),
          Drum(game, pctX*40, pctY*30, pctX*20, 'drum/maracas.jpg', 'drum/maracas.wav'),
          Drum(game, pctX*70, pctY*30, pctX*20, 'drum/open hat.jpg', 'drum/open hat.wav'),
          Drum(game, pctX*10, pctY*50, pctX*20, 'drum/tambourine.jpg', 'drum/tambourine.wav'),
          Drum(game, pctX*40, pctY*50, pctX*20, 'drum/triangle.jpg', 'drum/triangle.wav'),
          Drum(game, pctX*70, pctY*50, pctX*20, 'drum/whistle.jpg', 'drum/whistle.wav'),
        ];

        // add them to the game
        drums.forEach((drum) => game.add(drum));
        state = State.TAP;  // play taps
        break;
      default:
    }
  }

  void resize(Size size) {
    if (size.width == 0) return;  // don't bother

    // save screen width and height
    width = size.width;
    height = size.height;
    pctX = width/100;
    pctY = height/100;
    state = State.READY;
  }

}