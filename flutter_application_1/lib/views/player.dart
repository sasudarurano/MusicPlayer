import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';


class Player extends StatelessWidget {
  final SongModel data;
  const Player({super.key, required this.data});  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              alignment: Alignment.center,
              // color: Colors.red,
              child: QueryArtworkWidget(
                id: data.id,
                 type: ArtworkType.AUDIO,
                 artworkHeight: double.infinity,
                 artworkWidth: double.infinity,
                 nullArtworkWidget: const Icon(Icons.music_note,size: 48,color: whiteColor,),

                 )
            ),
          ),
          const SizedBox(
            height: 48
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
              child: Column(
                children: [
                  Text(
                    'Song Name',
                    style: ourStyle(
                      color: bgDarkColor,
                     family: bold,
                      size: 24,
                      
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                   Text(
                    'Artist Name',
                    style: ourStyle(
                      color: bgDarkColor,
                     family: regular,
                      size: 18,
                    ),
                  ),
                   const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        "00:00", style: ourStyle(
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
                          value: 0.0, 
                          onChanged: (newValue) {},
                        ),
                      ),
                      Text(
                        "00:00", style: ourStyle(
                          color: bgDarkColor,
                          family: regular,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.skip_previous_rounded,size:40,color: bgDarkColor,),
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: bgDarkColor,
                        child: Transform.scale(
                          scale: 2.5,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow_rounded,color:whiteColor),
                          ),
                        )
                       
                      ),
                     
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.skip_next_rounded,size:40, color: bgDarkColor,),
                      ),
                    ],
                  )

                ],),
              
            ),
          ),
        ],
      ),

    ),
    );
  }
}