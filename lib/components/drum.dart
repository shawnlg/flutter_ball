import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flutter_ball/flutterball_game.dart';

class Drum extends SpriteComponent  {
  Rect hitRect;
  final FlutterballGame game;
  final String sound;

  Drum(this.game, double x, double y, double size, String image, this.sound) : super.square(size, image) {
    this.x = x;
    this.y = y;
    hitRect = Rect.fromLTWH(x, y, width, height);
    Flame.audio.play(sound);  // play once so it's ready for taps
  }

  void update(double t) {
    if (game.wasTapped && hitRect.contains(Offset(game.tapX,game.tapY))) {
      game.wasTapped = false;  // reset tap
      Flame.audio.play(sound);
    }
  }

  bool destroy() {
    return false;
  }

}
