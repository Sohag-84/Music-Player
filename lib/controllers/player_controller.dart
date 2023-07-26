// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;

  RxString duration = "".obs;
  RxString position = "".obs;

  RxDouble max = 0.0.obs;
  RxDouble value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
    } else {
      checkPermission();
    }
  }

  playAudio({required String? uri, required index}) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print("=== ==== ${e.toString()} ==== ===");
    }
  }

  ///for change time position
  updatePosition() {
    audioPlayer.durationStream.listen((event) {
      duration.value = event.toString().split(".")[0];
      max.value = event!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((event) {
      position.value = event.toString().split(".")[0];
      value.value = event.inSeconds.toDouble();
    });
  }

  ///for slider position
  changeDurationToSecond({required seconds}) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
}
