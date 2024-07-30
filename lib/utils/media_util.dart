
import 'dart:io';

import 'package:flutter_audio_recorder3/flutter_audio_recorder3.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';

import 'package:flutter_d0601/utils/log_util.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';



///媒体工具，负责申请权限，选照片，拍照，录音，播放语音
class MediaUtil{
  static FlutterSound flutterSound =  FlutterSound();
  // FlutterSoundPlayer myPlayer = FlutterSoundPlayer();

  static String pageName = "${Constants.appTitle} MediaUtil";

  static FlutterSoundRecord flutterSoundRecord=FlutterSoundRecord();

  MediaUtil._privateConstructor();
  static MediaUtil? _instance = MediaUtil._privateConstructor();
  static MediaUtil? get instance { return _instance;}

  static MediaUtil? getInstance() {
    _instance ??= MediaUtil._privateConstructor();
    return _instance;
  }
static FlutterAudioRecorder3? flutterAudioRecorder2;
  //开始录音
  static void startRecordAudio() async {
    LogUtil.logUtil("debug 准备录音并检查权限", tag: pageName);
    bool hasPermission = await  flutterSoundRecord.hasPermission();
    if (hasPermission) {
      LogUtil.logUtil("debug 录音权限已开启", tag: pageName);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.aac";
      // flutterAudioRecorder2 = FlutterAudioRecorder3(tempPath, audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
      // await flutterAudioRecorder2!.initialized;
      // flutterAudioRecorder2!.start();
      bool isRecording=await flutterSoundRecord.isRecording();
      if(!isRecording){
        await flutterSoundRecord.start(
            path: tempPath,
            encoder: AudioEncoder.AAC
        ); // or AudioFormat.WAV
        LogUtil.logUtil("debug 开始录音", tag: pageName);
      }
      // await flutterSoundRecord.initialized;
      // await flutterSoundRecord.start();

    } else {
      // BotToast.showText(text: "录音权限未开启");
    }
  }
  static void stopRecordAudio({required bool delete})async{
    bool isRecording=await flutterSoundRecord.isRecording();
    if(isRecording){
      String? path=await flutterSoundRecord.stop();
      // Setting the HTTP user agent
      final player = AudioPlayer();
      // Setting request headers
      if(!delete){
        final duration = await player.setFilePath(path!);
        startPlayAudio(path);
        LogUtil.logUtil("录音结束 $path  ${duration?.inSeconds}",tag: pageName);
      }else{
        File file=File(path!);
        if(file.existsSync()){
          file.delete();
        }
      }
    }
  }

  // //录音结束，通过 finished 返回本地路径和语音时长，注：Android 必须要加 file:// 头
  // void stopRecordAudio(Function(String? path, int duration) finished) async {
  //   var result = await flutterSoundRecord.stop();
  //   LogUtil.logUtil( "暂停 recording: path = $result，duration = ${flutterSoundRecord.getAmplitude()}", tag: pageName);
  //   LogUtil.logUtil("暂停 recording: duration = result",
  //       tag: pageName);
  //   if (result.duration!.inSeconds > 0) {
  //     String? path = result.path;
  //     if (path == null) {
  //       if (finished != null) {
  //         finished(null, 0);
  //       }
  //     }
  //     if (TargetPlatform.android == defaultTargetPlatform) {
  //       path = "file://" + path!;
  //     }
  //     if (finished != null) {
  //       finished(path!, result.duration!.inSeconds);
  //     }
  //   } else {
  //     BotToast.showText(text: "说话时间太短");
  //   }
  // }

  // static final player = AudioPlayer();
  //播放语音
  static void startPlayAudio(String? path) async{
    // ignore: unrelated_type_equality_checks
    // if(flutterSound.audioState==t_AUDIO_STATE.IS_STOPPED){ // 初始化
    //   await flutterSound.openAudioSession().then( (v){
    //
    //   } );
    // }

    ///UrlSource('https://example.com/my-audio.wav')
    // if(player.state==PlayerState.playing){
    //   player.stop();
    // }else{
    //   await player.play(DeviceFileSource(path!),ctx: AudioContext());
    // }
    if (flutterSound.audioState==t_AUDIO_STATE.IS_PLAYING) {
      stopPlayAudio();
    }else{
      flutterSound.startPlayer(path);
    }
  }

  //停止播放语音
  static void stopPlayAudio() {
    flutterSound.stopPlayer();
  }

  // // 销毁音频播放器
  // void closeAudioSession(){
  //   if(flutterSound.isRecording){
  //     flutterSound.colose();
  //   }
  // }

}