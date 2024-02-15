import 'package:flutter/material.dart';
import 'package:projekt/views/image_view.dart';

import '../models/wallpaper_model.dart';

Widget brandName(){

  return Center(
    child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          children: [
            TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black54)),
            TextSpan(text: 'Flutter', style: TextStyle(color: Colors.orange)),
          ],
        ),
    ),
  );

  /*
  return Row (
    mainAxisAlignment:MainAxisAlignment.center ,
    children: <Widget> [
    Text("Wallpaper",
      style:TextStyle(color: Colors.black54) ,
    ),
    Text("Hrohii",
      style:TextStyle(color: Colors.orange) ,
    ),
  ],);*/
}
/*

*/
/*

}*/

Widget wallpapersList({required List<WallpaperModel> wallpapers, required BuildContext context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              if (wallpaper.src?.portrait != null) { // проверяем на null
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageView(imgUrl: wallpaper.src!.portrait!),
                  ),
                );
              }
            },
            child: Hero(
              tag: wallpaper.src?.portrait ?? "", // проверяем на null и добавляем пустую строку, если portrait равен null
              child: Container(
                child: wallpaper.src?.portrait != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(wallpaper.src!.portrait!, fit: BoxFit.cover),
                )
                    : Placeholder(),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}



/*
Widget wallpapersList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            physics: NeverScrollableScrollPhysics(),
            children: wallpapers.map((wallpaper) {
              return GridTile(
                child: Container(
                  child: wallpaper.src?.portrait != null
                      ? Image.network(wallpaper.src!.portrait!)
                      : Placeholder(),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

*/
