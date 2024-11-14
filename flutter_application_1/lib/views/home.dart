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
      body: Stack(
        children: [
          // Song list view
          FutureBuilder<List<SongModel>>(
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
                  padding: const EdgeInsets.only(bottom: 80.0), // Padding for bottom player
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: ourStyle(family: regular, size: 12),
                              overflow: TextOverflow.ellipsis,
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
                              controller.playSong(snapshot.data![index].uri, index);
                              Get.to(
                                () => Player(
                                  data: snapshot.data!,
                                ),
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

            // Draggable bottom player
            Obx(() => controller.isPlaying.value
              ? DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.6,
                builder: (context, scrollController) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                    () => Player(
                      data: controller.data,
                    ),
                    transition: Transition.downToUp,
                    );
                  },
                  child: Container(
                  color: whiteColor,
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    
                    controller: scrollController,
                    child: Column(
                      
                    children: [
                      Obx(
                        
                        () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              controller.data[controller.playIndex.value].displayNameWOExt,
                              style: ourStyle(family: bold, size: 16, color: bgDarkColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.data[controller.playIndex.value].artist ?? 'Unknown Artist',
                              style: ourStyle(family: regular, size: 12, color: bgDarkColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            ],
                          ),
                          ),
                          Row(
                          children: [
                            IconButton(
                            onPressed: controller.audioPlayer.seekToPrevious,
                            icon: const Icon(Icons.skip_previous, color: bgDarkColor),
                            ),
                            IconButton(
                            onPressed: () {
                              if (controller.isPlaying.value) {
                              controller.audioPlayer.pause();
                              } else {
                              controller.audioPlayer.play();
                              }
                              controller.isPlaying.toggle();
                            },
                            icon: Icon(
                              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                              color: bgDarkColor,
                            ),
                            ),
                            IconButton(
                            onPressed: controller.audioPlayer.seekToNext,
                            icon: const Icon(Icons.skip_next, color: bgDarkColor),
                            ),
                          ],
                          ),
                        ],
                        ),
                        
                      ),
                      const SizedBox(height: 5),
                      LinearProgressIndicator(
                      value: controller.value.value / controller.max.value,
                      color: sliderColor,
                      backgroundColor: bgDarkColor.withOpacity(0.5),
                      ),
                    ],
                    ),
                  ),
                  ),
                );
                },
              )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
