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
const LOOP_SIZE = 64;
const BEAT_LENGTH = 0.1;  // seconds for each beat in the loop
const METRONOME_BEATS = 8;  // tick sound this many beats apart
const BUTTON_PRESS_SOUND = 'drum/metro off.wav';  // what to play when button is pressed

class DrumController extends Component {

  // instance variables
  FlutterballGame game;
  double sizeX=0;  // size of the screen in the x direction
  double sizeY=0;  // size of the screen in the y direction
  double pctX=0;  // pixels as a percentage
  double pctY=0;  // pixels as a percentage
  State state = State.STARTUP;
  List<Drum> drums;
  Sprite recordButton = Sprite('drum/record.jpg');
  Sprite playButton = Sprite('drum/play.jpg');
  Sprite stopButton = Sprite('drum/stop.jpg');
  Rect button1Rect;  // where to place the first button
  Rect button2Rect;  // where to place the second button
  List<String> drumTrack = List(LOOP_SIZE);
  int currentBeat;  // which beat of the loop we are in
  double timeNextBeat;  // when we have the next beat
  int metroBeat;  // which beat to play the next metronome tick

  // constructor
  DrumController(this.game) : super() {
    currentBeat = 0;
    metroBeat = 0;
    timeNextBeat = game.currentTime() + 1;  // start keeping track of beats soon
  }

  // called once for every beat
  void beat() {
    // play metronome if recording
    if (state == State.RECORD) {
      if (currentBeat == metroBeat) {
        String sound = metroBeat == 0 ? 'drum/metro main.wav' : 'drum/metro off.wav';
        Flame.audio.play(sound);

        // set next metronome beat
        metroBeat += METRONOME_BEATS;
        if (metroBeat >= LOOP_SIZE) {
          metroBeat = 0;
        }
      }

      // increment beat number
      currentBeat++;
      if (currentBeat >= LOOP_SIZE) {
        currentBeat = 0;
      }

    }

  }

  void render(Canvas c) {
    // what we do depends on the state of the drum machine
    switch (state) {
      case State.STARTUP:
        break;
      case State.READY:
        break;
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
    }

  }

  void update(double t) {
    // what we do depends on the state of the drum machine
    switch (state) {
      case State.STARTUP:
        break;
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
          currentBeat = 0;  // start recording in 1 second
          timeNextBeat = game.currentTime() + 1;  // start keeping track of beats soon
          metroBeat = 0;  // start ticking on first beat of loop
        }

        // see if user tapped on play button
        if (game.wasTapped && button2Rect.contains(Offset(game.tapX,game.tapY))) {
          game.wasTapped = false;  // reset tap
          Flame.audio.play(BUTTON_PRESS_SOUND);
          state = State.PLAY;
          currentBeat = 0;  // start playing in 1 second
          timeNextBeat = game.currentTime() + 1;  // start keeping track of beats soon
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
    }

    // count off the beat
    if (game.currentTime() > timeNextBeat) {
      timeNextBeat += BEAT_LENGTH;
      beat();
    }
  }

  void resize(Size size) {
    if (size.width == 0) return;  // don't bother

    // save screen width and height
    sizeX = size.width;
    sizeY = size.height;
    pctX = sizeX/100;
    pctY = sizeY/100;
    state = State.READY;

    // save the button locations
    button1Rect = Rect.fromLTWH(pctX*10, pctY*80, pctX*20, pctX*20);
    button2Rect = Rect.fromLTWH(pctX*40, pctY*80, pctX*20, pctX*20);

  }

}