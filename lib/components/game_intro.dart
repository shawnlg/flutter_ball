import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter_ball/components/block.dart';
import 'package:flutter_ball/components/ball.dart';
import 'package:flutter_ball/components/game_play.dart';

enum IntroState {
  WAITING,  // waiting for screen size info
  STARTING, // putting up the intro screen
  BALLS,   // showing random balls
  HELP, // showing help screen
  DEAD, // destroy component
}

class GameIntro extends Component {
  // constants
  static const int NUMBER_OF_BALLS = 100;
  static const double BALL_SIZE = 5.0;
  static const PaintingStyle BALL_STYLE = PaintingStyle.fill;
  static const HELP_TEXT =
    "Drag your finger to launch a ball. "
    "The longer you\ndrag, the faster the ball will go. "
    "The ball will go in\nthe direction you drag.\n\n"
    "Try to bounce the ball and get rid of the blocks. "
    "You\ncan drag around the red block to aim the ball.\n\n"
    "Tap the screen to close help."
      ;

  // instance variables
  final FlutterballGame game;
  IntroState state = IntroState.WAITING;
  double sizeX=0;  // size of the screen in the x direction
  double sizeY=0;  // size of the screen in the y direction
  Block gameTitle;  // game title text
  Block startButton;
  Block levelPlus;
  Block levelMinus;
  Block helpButton;
  Random rnd = Random();  // rnandom number generator

  // constructor
  GameIntro(this.game, ) : super() {

  }

  // make blocks to display title and buttons
  void makeBlocks() {
    gameTitle = Block(game, position: Rect.fromLTWH(sizeX*0.1, 10, sizeX*0.8, 200),
      displayText: "Flutter\nBall", color: null, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(gameTitle);

    startButton = Block(game, position: Rect.fromLTWH(sizeX*0.3, sizeY*0.5, sizeX*0.4, 100),
      displayText: "Start\nLevel ${game.level}", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 25, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(startButton);

    levelMinus = Block(game, position: Rect.fromLTWH(0, sizeY*0.5, 100, 100),
      displayText: "-", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(levelMinus);

    levelPlus = Block(game, position: Rect.fromLTWH(sizeX*0.75, sizeY*0.5, 100, 100),
      displayText: "+", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.blue),
      bounce: false, draggable: false,
    );
    game.add(levelPlus);

    helpButton = Block(game, position: Rect.fromLTWH(sizeX*0.3, sizeY*0.8, sizeX*0.4, 100),
      displayText: "Help", color: Colors.blueGrey, borderColor: null,
      textStyle: TextStyle(fontSize: 50, color: Colors.red),
      bounce: false, draggable: false,
    );
    game.add(helpButton);

  }

  // start the balls bouncing
  void startBalls() {
    for (int i=0; i<NUMBER_OF_BALLS; i++) {
      double x = rnd.nextDouble()*sizeX;
      double y = rnd.nextDouble()*sizeY;
      double speedX = rnd.nextDouble()*0.4 - 0.2;
      double speedY = rnd.nextDouble()*0.4 - 0.2;
      Color color;
      switch (rnd.nextInt(6)) {
        case 0:
          color = Colors.white;
          break;
        case 1:
          color = Colors.blue;
          break;
        case 2:
          color = Colors.green;
          break;
        case 3:
          color = Colors.deepOrange;
          break;
        case 4:
          color = Colors.pink;
          break;
        case 5:
          color = Colors.purple;
          break;
      }
      var ball = Ball(game, color: color, size: BALL_SIZE,
          speedX: speedX, speedY: speedY, style: BALL_STYLE,
          lives: 99, sound: false, x: x, y: y );
      game.add(ball);
    } // for all balls
  }

  void resize(Size size) {
    if (size.width <= 0) return;

    // save screen width and height
    game.clearComponents();
    sizeX = size.width;
    sizeY = size.height;
    state = IntroState.STARTING;
  }


  void render(Canvas c) => null;

  void update(double t) {
    switch (state) {
      case IntroState.STARTING:
        startBalls();
        makeBlocks();
        state = IntroState.BALLS;
        break;
      case IntroState.HELP:
        // if help screen is tapped, we clear it and start over
        if (game.wasTapped) {
          game.wasTapped = false;  // reset tap
          game.clearComponents();  // removes help block
          state = IntroState.STARTING;  // puts intro screen back and waits for taps again
        }
        break;
      case IntroState.BALLS:
        // check if any button was tapped
        if (game.wasTapped) {
          // something was tapped, so end it
          game.wasTapped = false;  // reset tap
          if (helpButton.position.contains(Offset(game.tapX,game.tapY))) {
            // clear screen of components and put up help screen
            game.clearComponents();
            Block helpTitle = Block(game, position: Rect.fromLTWH(0, 0, sizeX, 50),
              displayText: "Help", color: null, borderColor: null,
              textStyle: TextStyle(fontSize: 20, color: Colors.blue, ),
              bounce: false, draggable: false,
            );
            game.add(helpTitle);
            Block helpScreen = Block(game, position: Rect.fromLTWH(0, 50, sizeX, 50),
              displayText: HELP_TEXT, color: null, borderColor: null, textAlign: TextAlign.left,
              textStyle: TextStyle(fontSize: 12, color: Colors.blue, ),
              bounce: false, draggable: false,
            );
            game.add(helpScreen);
            state = IntroState.HELP;
          }
          if (startButton.position.contains(Offset(game.tapX,game.tapY))) {
            // remove all components and add the game player component
            game.clearComponents();
            GamePlay gamePlay = GamePlay(game);
            game.add(gamePlay);
            state = IntroState.DEAD;
          }
          if (levelMinus.position.contains(Offset(game.tapX,game.tapY))) {
            // subtract one from the game level and update start button text
            if (game.level > 1) {
              game.level--;
              startButton.displayText = "Start\nLevel ${game.level}";
            }
          }
          if (levelPlus.position.contains(Offset(game.tapX,game.tapY))) {
            // subtract one from the game level and update start button text
            if (game.level < GamePlay.MAX_LEVELS) {
              game.level++;
              startButton.displayText = "Start\nLevel ${game.level}";
            }
          }
        }
        break;
      default:
    }
  }

  bool destroy() => state == IntroState.DEAD;

}