import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';
import 'package:music/main.dart';
import 'package:music/view/favouritescreen/favouritescreen.dart';
import 'package:music/view/nowplayingscreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

List? favourites = box.get("favourites");

Widget popup({required songId, required context}) {
  final temp = databaseSongs(dbSongs, songId);
  return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (favouriteController) {
        return PopupMenuButton(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(15.0).r,
            ),
          ),
          color: Colors.black,
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          itemBuilder: (context) => [
            favourites!
                    .where((element) =>
                        element.id.toString() == temp.id.toString())
                    .isEmpty
                ? PopupMenuItem(
                    onTap: () async {
                      // musicController.addToFavoutire(temp);
                      favouriteController.addToFavoutire(temp);
                    },
                    child: const Text(
                      "Add to Favourite",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : PopupMenuItem(
                    onTap: () async {
                      // musicController.removeFromFavourite(temp);
                    },
                    child: const Text(
                      'Remove From Favourites',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Add to Playlist",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {
              playlistshowbottomsheet(
                context: context,
                playlistNames: temp,
                currentplaysong: temp,
              );
            }
          },
        );
      });
}
