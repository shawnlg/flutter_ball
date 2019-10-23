import 'package:flame/flame.dart';

class AudioHelper {
  static void play(String sound) {
    print('Playing $sound');
    Flame.audio.playLongAudio(sound);
    //Flame.audio.play(sound);
  }
}