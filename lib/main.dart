import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  FlutterballGame game = FlutterballGame();

  // load assets
  Flame.images.loadAll(<String>[
    'drum/cowbell.jpg',
    'drum/cymbols.jpg',
    'drum/echo.jpg',
    'drum/frame drum.jpg',
    'drum/maracas.jpg',
    'drum/open hat.jpg',
    'drum/tambourine.jpg',
    'drum/triangle.jpg',
    'drum/whistle.jpg',
    'drum/woodblock.jpg',
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bounce.wav',
    'drum/cowbell.wav',
    'drum/cymbols.wav',
    'drum/echo.wav',
    'drum/frame drum.wav',
    'drum/maracas.wav',
    'drum/metro main.wav',
    'drum/metro off.wav',
    'drum/open hat.wav',
    'drum/tambourine.wav',
    'drum/triangle.wav',
    'drum/whistle.wav',
    'drum/woodblock.wav',
  ]);

  // define gestures the game can handle
  PanGestureRecognizer dragger = PanGestureRecognizer();
  dragger.onStart = game.onDragStart;
  dragger.onEnd = game.onDragEnd;
  dragger.onUpdate = game.onDragUpdate;

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;

  runApp(game.widget);

  // gesture recognizers must be added after runapp
  flameUtil.addGestureRecognizer(dragger);
  flameUtil.addGestureRecognizer(tapper);
}

