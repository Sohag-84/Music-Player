import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;

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

  playAudio({required String? uri,required index}) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
      isPlaying(true);
    } on Exception catch (e) {
      print("=== ==== ${e.toString()} ==== ===");
    }
  }
}
