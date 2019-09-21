import 'dart:ui';

import 'package:flame/components/component.dart';

import '../audio_helper.dart';
import '../flutterball_game.dart';
import 'drum_controller.dart';

class Drum extends SpriteComponent  {
  Rect hitRect;
  final FlutterballGame game;
  final DrumController controller;
  final String sound;

  Drum(this.game, this.controller, double x, double y, double size, String image, this.sound) : super.square(size, image) {
    this.x = x;
    this.y = y;
    hitRect = Rect.fromLTWH(x, y, width, height);
    AudioHelper.play(sound);  // play once so it's ready for taps
  }

  void update(double t) {
    if (game.wasTapped && hitRect.contains(Offset(game.tapX,game.tapY))) {
      game.wasTapped = false;  // reset tap
      AudioHelper.play(sound);
      controller.drumTap(this);
    }
  }

  bool destroy() {
    return false;
  }

}
