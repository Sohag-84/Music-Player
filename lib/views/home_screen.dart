// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        leading: Icon(Icons.sort_rounded, color: whiteColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: whiteColor,
            ),
          )
        ],
        title: Text(
          "Music Player",
          style: ourStyle(
            size: 18.sp,
            fontWeight: FontWeight.bold,
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
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            print("=== ==== ${snapshot.data} ==== ===");
            return Center(
              child: Text(
                "No song found",
                style: ourStyle(),
              ),
            );
          } else {
            print("=== ==== ${snapshot.data} ==== ===");
            return Padding(
              padding: EdgeInsets.all(8.w),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Obx(() {
                      return ListTile(
                        tileColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32.h,
                          ),
                        ),
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourStyle(
                            fontWeight: FontWeight.bold,
                            size: 15.sp,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data![index].artist.toString(),
                          style: ourStyle(size: 12.h),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? Icon(
                                Icons.play_arrow,
                                color: whiteColor,
                                size: 26.h,
                              )
                            : null,
                        onTap: () {
                          Get.to(
                            () => Player(
                              data: snapshot.data!,
                            ),
                            transition: Transition.downToUp,
                          );

                          ///play audio
                          controller.playAudio(
                            uri: snapshot.data![index].uri,
                            index: index,
                          );
                        },
                      );
                    }),
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
