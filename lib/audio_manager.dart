import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static late AudioPlayer _audioPlayer;
  static late AudioPlayer _secondaryPlayer;

  //background
  static const String BACKGROUND_EARLY = "assets/music/background_early.mp3";
  static const String BACKGROUND_MID = "assets/music/background_mid.mp3";
  static const String BACKGROUND_LATE = "assets/music/background_late.mp3";

  //answers
  static const String CORRECT = "assets/music/correct_answer.mp3";
  static const String CORRECT_SUPER = "assets/music/super_correct_answer.mp3";
  static const String FINAL = "assets/music/final_answer.mp3";
  static const String WRONG = "assets/music/wrong_answer.mp3";

  //jokers
  static const String HALF_HALF = "assets/music/half_half.mp3";
  static const String PUBLIC = "assets/music/public.mp3";
  static const String CALL = "assets/music/call_friend.mp3";



  static void initPlayer(){
    _audioPlayer = AudioPlayer();
    _secondaryPlayer = AudioPlayer();
  }

  static void playSound({required String sound, required LoopMode mode, required int playerNum}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSound = prefs.getBool("isSoundOn") ?? true;
    bool isMusic = prefs.getBool("isMusicOn") ?? true;
    if(playerNum == 1 && isMusic) {
      _audioPlayer.setAsset(sound);
      _audioPlayer.setLoopMode(mode);
      _audioPlayer.play();
    }else if(playerNum == 2 && isSound){
      _secondaryPlayer.setAsset(sound);
      _secondaryPlayer.setLoopMode(mode);
      _secondaryPlayer.play();
    }
  }

  static void stopPlayer(int playerNum){
    if(playerNum == 1){
      _audioPlayer.stop();
    }else if(playerNum == 2){
      _secondaryPlayer.stop();
    }else{
      _audioPlayer.stop();
      _secondaryPlayer.stop();
    }
  }

}

class Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AudioManager._audioPlayer.play();
      AudioManager._secondaryPlayer.play();
    } else {
      AudioManager._audioPlayer.pause();
      AudioManager._secondaryPlayer.pause();
    }
  }
}


