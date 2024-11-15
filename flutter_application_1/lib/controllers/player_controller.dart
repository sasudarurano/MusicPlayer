import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var isLoading = false; // Flag to prevent rapid calls

  var data = <SongModel>[].obs; // Define the data variable to hold the list of songs

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (state.processingState == ProcessingState.completed) {
        // When the song is complete, play the next song
        nextSong();
      }
    });
  }

  void updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  void changeDurationToSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  Future<void> playSong(String? uri, int index) async {
    if (isLoading) return; // Prevent rapid calls
    isLoading = true; // Set loading flag

    playIndex.value = index;

    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
      updatePosition();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      debugPrint(e.toString());
    }

    isPlaying.value = true; // Set the play state to true
    isLoading = false; // Reset loading flag
  }

  void nextSong() {
    if (playIndex.value < data.length - 1) {
      playSong(data[playIndex.value + 1].uri, playIndex.value + 1);
    } else {
      // Optional: Stop the player or loop back to the start if at the end of the playlist
      audioPlayer.stop();
      isPlaying.value = false;
    }
  }

  checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      data.value = await audioQuery.querySongs(
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
