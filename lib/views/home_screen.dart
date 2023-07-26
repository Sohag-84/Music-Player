// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            size: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                tileColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                leading: Icon(Icons.music_note, color: whiteColor, size: 32),
                title: Text(
                  "Music name",
                  style: ourStyle(
                    fontWeight: FontWeight.bold,
                    size: 15,
                  ),
                ),
                subtitle: Text(
                  "Artist name",
                  style: ourStyle(size: 12),
                ),
                trailing: Icon(Icons.play_arrow, color: whiteColor, size: 26),
              ),
            );
          },
        ),
      ),
    );
  }
}
