import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_application_1/controllers/player_controller.dart';
import 'package:get/get.dart';


class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key,required this.data});  
  
 

  @override
  Widget build(BuildContext context) {
     var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(
            ()=>Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                 
                ),
                alignment: Alignment.center,
                // color: Colors.red,
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                   type: ArtworkType.AUDIO,
                   artworkHeight: double.infinity,
                   artworkWidth: double.infinity,
                   nullArtworkWidget: const Icon(Icons.music_note,size: 48,color: whiteColor,),
            
                   )
              ),
            ),
          ),
          const SizedBox(
            height: 20
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        color: bgDarkColor,
                       family: bold,
                        size: 21,
                        
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                     Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        color: bgDarkColor,
                       family: regular,
                        size: 18,
                      ),
                    ),
                     const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      ()=> Row(
                        children: [
                          Text(
                            controller.position.value,
                             style: ourStyle(
                              color: bgDarkColor,
                              family: regular,
                              size: 18,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              thumbColor: sliderColor,
                              inactiveColor: bgColor,
                              activeColor: sliderColor,
                              min: const Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              value: controller.value.value,  
                              onChanged: (newValue) {
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue=newValue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                             style: ourStyle(
                              color: bgDarkColor,
                              family: regular,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                       Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  IconButton(
                    onPressed: () {
                    if (controller.playIndex.value > 0) {
                      controller.playSong(data[controller.playIndex.value - 1].uri, controller.playIndex.value - 1);
                    }
                    },
                    icon: const Icon(Icons.skip_previous_rounded, size: 40, color: bgDarkColor),
                  ),
                  Obx(
                    () => CircleAvatar(
                    radius: 35,
                    backgroundColor: bgDarkColor,
                    child: Transform.scale(
                      scale: 2.5,
                      child: IconButton(
                      onPressed: () {
                        if (controller.isPlaying.value) {
                        controller.audioPlayer.pause();
                        controller.isPlaying(false);
                        } else {
                        controller.audioPlayer.play();
                        controller.isPlaying(true);
                        }
                      },
                      icon: controller.isPlaying.value
                        ? const Icon(Icons.pause_rounded, color: whiteColor)
                        : const Icon(Icons.play_arrow_rounded, color: whiteColor),
                      ),
                    ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                    if (controller.playIndex.value < data.length - 1) {
                      controller.playSong(data[controller.playIndex.value + 1].uri, controller.playIndex.value + 1);
                    }
                    },
                    icon: const Icon(Icons.skip_next_rounded, size: 40, color: bgDarkColor),
                  ),
                  ],
                )
                
                  ],),
              ),
              
            ),
          ),
        ],
      ),

    ),
    );
  }
}