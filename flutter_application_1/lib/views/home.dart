import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/text_style.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_application_1/views/player.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          'Music Player',
          style: ourStyle(
            family: bold,
            size: 18,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Songs Found',
                style: ourStyle(
                  family: bold,
                  size: 18,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var song = snapshot.data![index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => ListTile(
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourStyle(family: bold, size: 15),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: ourStyle(family: regular, size: 12),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            size: 40,
                            color: whiteColor,
                          ),
                        ),
                        trailing: controller.playIndex.value == index
                            ? Icon(
                                controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                                color: whiteColor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          // Call the playSong method to start playing the selected song
                          // controller.playSong(snapshot.data![index].uri, index);

                          // Navigate to the Player page
                          Get.to(
                            () => Player(data: snapshot.data![index]),
                            transition: Transition.downToUp,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
