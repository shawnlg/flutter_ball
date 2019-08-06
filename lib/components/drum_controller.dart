import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/drum.dart';

enum State {
  STARTUP,  // game is starting up, no size yet
  READY,    // game is ready to start adding components
  TAP,      // in tap mode, just play what is tapped
  RECORD,   // record a drum loop
  PLAY,     // play a recorded drum loop
}

// constants
const BUTTON_PRESS_SOUND = 'drum/metro main.wav';  // what to play when button is pressed

class DrumController extends Component {

  // instance variables
  FlutterballGame game;
  double width=0;  // size of the screen in the x direction
  double height=0;  // size of the screen in the y direction
  double pctX=0;  // pixels as a percentage
  double pctY=0;  // pixels as a percentage
  State state = State.STARTUP;
  List<Drum> drums;
  Sprite recordButton = Sprite('drum/record.jpg');
  Sprite playButton = Sprite('drum/play.jpg');
  Sprite stopButton = Sprite('drum/stop.jpg');
  Rect button1Rect;  // where to place the first button
  Rect button2Rect;  // where to place the second button

  // constructor
  DrumController(this.game) : super() {
  }

  void render(Canvas c) {
    // what we do depends on the state of the drum machine
    switch (state) {
      case State.TAP:  // show the record and play buttons
        recordButton.renderRect(c, button1Rect);
        playButton.renderRect(c, button2Rect);
        break;
      case State.RECORD:  // show the stop button
        stopButton.renderRect(c, button2Rect);
        break;
      case State.PLAY:  // show the stop button
        stopButton.renderRect(c, button2Rect);
        break;
      default:
    }

  }

  void update(double t) {
    // what we do depends on the state of the drum machine
    switch (state) {
      case State.READY:
        // create the drums
        drums = [
          Drum(game,pctX*10, pctY*10, pctX*20, 'drum/frame drum.jpg', 'drum/frame drum.wav'),
          Drum(game,pctX*40, pctY*10, pctX*20, 'drum/cymbols.jpg', 'drum/cymbols.wav'),
          Drum(game,pctX*70, pctY*10, pctX*20, 'drum/echo.jpg', 'drum/echo.wav'),
          Drum(game,pctX*10, pctY*30, pctX*20, 'drum/woodblock.jpg', 'drum/woodblock.wav'),
          Drum(game,pctX*40, pctY*30, pctX*20, 'drum/maracas.jpg', 'drum/maracas.wav'),
          Drum(game,pctX*70, pctY*30, pctX*20, 'drum/open hat.jpg', 'drum/open hat.wav'),
          Drum(game,pctX*10, pctY*50, pctX*20, 'drum/tambourine.jpg', 'drum/tambourine.wav'),
          Drum(game,pctX*40, pctY*50, pctX*20, 'drum/triangle.jpg', 'drum/triangle.wav'),
          Drum(game,pctX*70, pctY*50, pctX*20, 'drum/whistle.jpg', 'drum/whistle.wav'),
        ];

        // add them to the game
        drums.forEach((drum) => game.add(drum));
        state = State.TAP;  // play taps
        break;
      case State.TAP:
        // see if user tapped on record button
        if (game.wasTapped && button1Rect.contains(Offset(game.tapX,game.tapY))) {
          game.wasTapped = false;  // reset tap
          Flame.audio.play(BUTTON_PRESS_SOUND);
          state = State.RECORD;
        }

        // see if user tapped on play button
        if (game.wasTapped && button2Rect.contains(Offset(game.tapX,game.tapY))) {
          game.wasTapped = false;  // reset tap
          Flame.audio.play(BUTTON_PRESS_SOUND);
          state = State.PLAY;
        }

        break;
      case State.RECORD:
        // see if user tapped on stop button
        if (game.wasTapped && button2Rect.contains(Offset(game.tapX,game.tapY))) {
          game.wasTapped = false;  // reset tap
          Flame.audio.play(BUTTON_PRESS_SOUND);
          state = State.TAP;
        }
        break;
      case State.PLAY:
        // see if user tapped on stop button
        if (game.wasTapped && button2Rect.contains(Offset(game.tapX,game.tapY))) {
          game.wasTapped = false;  // reset tap
          Flame.audio.play(BUTTON_PRESS_SOUND);
          state = State.TAP;
        }
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

    // save the button locations
    button1Rect = Rect.fromLTWH(pctX*10, pctY*80, pctX*20, pctX*20);
    button2Rect = Rect.fromLTWH(pctX*40, pctY*80, pctX*20, pctX*20);

  }

}