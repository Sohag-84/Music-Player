// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  Player({super.key, required this.data});

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 300.h,
                width: 300.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  artworkFit: BoxFit.fitHeight,
                  nullArtworkWidget: Icon(
                    Icons.music_note,
                    size: 150.h,
                    color: whiteColor,
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 12.h),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              child: Obx(() {
                return Column(
                  children: [
                    SizedBox(height: 12.h),
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        color: bgDarkColor,
                        fontWeight: FontWeight.bold,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        color: bgDarkColor,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),

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
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.playAudio(
                              uri: data[controller.playIndex.value - 1].uri,
                              index: controller.playIndex.value - 1,
                            );
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 40.h,
                            color: bgDarkColor,
                          ),
                        ),
                        Obx(() {
                          return Center(
                            child: MaterialButton(
                              shape: CircleBorder(),
                              color: bgDarkColor,
                              padding: EdgeInsets.all(5.h),
                              onPressed: () {},
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
                                    ? Center(
                                        child: Icon(
                                          Icons.pause,
                                          size: 30.h,
                                          color: whiteColor,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 30.h,
                                          color: whiteColor,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        }),
                        IconButton(
                          onPressed: () {
                            controller.playAudio(
                              uri: data[controller.playIndex.value + 1].uri,
                              index: controller.playIndex.value + 1,
                            );
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40.h,
                            color: bgDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
