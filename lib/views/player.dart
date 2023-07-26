// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final SongModel data;
  const Player({super.key, required this.data});

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
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(Icons.music_note, size: 48),
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
                    Row(
                      children: [
                        Text(
                          "0:0",
                          style: ourStyle(color: bgDarkColor),
                        ),
                        Expanded(
                          child: Slider(
                            thumbColor: sliderColor,
                            activeColor: sliderColor,
                            inactiveColor: bgColor,
                            value: 0.0,
                            onChanged: (value) {},
                          ),
                        ),
                        Text(
                          "04:00",
                          style: ourStyle(color: bgDarkColor),
                        ),
                      ],
                    ),
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
                        CircleAvatar(
                          backgroundColor: bgDarkColor,
                          radius: 35,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_arrow,
                                size: 54,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
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
