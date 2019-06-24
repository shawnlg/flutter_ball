import 'package:flutter/material.dart';
import 'package:flutter_ball/flutterball_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  FlutterballGame game = FlutterballGame();

  // define gestures the game can handle
  PanGestureRecognizer dragger = PanGestureRecognizer();
  dragger.onStart = game.onDragStart;
  dragger.onEnd = game.onDragEnd;
  dragger.onUpdate = game.onDragUpdate;

  runApp(game.widget);
  flameUtil.addGestureRecognizer(dragger);
}

