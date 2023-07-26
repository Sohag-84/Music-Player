// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final SongModel data;
  Player({super.key, required this.data});

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  id: data.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: Icon(Icons.music_note, size: 48),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      data.displayNameWOExt,
                      style: ourStyle(
                        color: bgDarkColor,
                        fontWeight: FontWeight.bold,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      data.artist.toString(),
                      style: ourStyle(
                        color: bgDarkColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 12),

                    ///slider
                    Obx(() {
                      return Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: ourStyle(color: bgDarkColor),
                          ),
                          Expanded(
                            child: Slider(
                              thumbColor: sliderColor,
                              activeColor: sliderColor,
                              inactiveColor: bgColor,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller.changeDurationToSecond(
                                  seconds: newValue.toInt(),
                                );
                                newValue = newValue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: ourStyle(color: bgDarkColor),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: bgDarkColor,
                          ),
                        ),
                        Obx(() {
                          return CircleAvatar(
                            backgroundColor: bgDarkColor,
                            radius: 35,
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
                                    ? Icon(
                                        Icons.pause,
                                        size: 54,
                                        color: whiteColor,
                                      )
                                    : Icon(
                                        Icons.play_arrow_rounded,
                                        size: 54,
                                        color: whiteColor,
                                      ),
                              ),
                            ),
                          );
                        }),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: bgDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
