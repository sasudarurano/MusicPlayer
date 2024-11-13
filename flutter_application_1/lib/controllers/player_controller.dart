import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  playSong(String? uri, int index) {
    playIndex.value = index;
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      try {
        audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(uri!),
          ),
        );
        audioPlayer.play();
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    isPlaying.toggle(); // Toggle the play state
  }

  checkPermission() async {
    var perm = await Permission.audio.request();
    if (perm.isGranted) {
      return audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
    } else {
      checkPermission();
    }
  }
}