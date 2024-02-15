import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;


  const ImageView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}


class _ImageViewState extends State<ImageView> {
 var filePath;
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.imgUrl,
          child: Container(
            height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width ,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover)),
        ),
        Container(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x36FFFFFF),
                    Color(0x0FFFFFFF),
                  ]
                )
              ),
              child: Column(children: [
                Text("Set Wallpaper"),
                Text("Image will be saved in gallery"),
              ],),
            ),
            Text("Cancel", style: TextStyle(color: Colors.white),),
          ],),
        )
      ],),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl ?? "", // Добавляем проверку на null и используем пустую строку в качестве значения по умолчанию
            child: Visibility( // Оборачиваем виджет Image.network в Visibility
              visible: widget.imgUrl != null, // Показываем виджет только если imgUrl не null
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl ?? "", fit: BoxFit.cover), // Добавляем проверку на null и используем пустую строку в качестве значения по умолчанию
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              GestureDetector(
                onTap: (){
                  _save();

                },
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2,


                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ],
                        ),
                      ),
                      child: Column(children: [
                        Text("Set Wallpaper", style: TextStyle(
                            fontSize: 12, color: Colors.white70
                        ),),
                
                        Text("Image will be saved in gallery", style: TextStyle(
                            fontSize: 10, color: Colors.white70
                        ),)
                      ],),
                    ),
                  ],
                ),
              ),

                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                  Navigator.pop(context);
                },
                    child: Text("Cancel", style: TextStyle(color: Colors.white),)),
                SizedBox(height: 50),

              ],
            ),
          ),
        ],
      ),
    );
  }
  _save() async {

      await _askPermission();

    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }
/*
  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }*/
  _askPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.photos.request();
      if (status.isGranted) {
        // Разрешение предоставлено, можно выполнять необходимые действия
      } else if (status.isPermanentlyDenied) {
        // Пользователь навсегда отказался от предоставления разрешения,
        // можете показать диалог или сообщение пользователю
      }
    } else {
      var status = await Permission.storage.status;
      if (status.isGranted) {
        // Разрешение предоставлено, можно выполнять необходимые действия
      } else {
        // Разрешение не предоставлено, запросите его у пользователя
        status = await Permission.storage.request();
        if (status.isGranted) {
          // Разрешение предоставлено, можно выполнять необходимые действия
        } else if (status.isPermanentlyDenied) {
          // Пользователь навсегда отказался от предоставления разрешения,
          // можете показать диалог или сообщение пользователю
        }
      }
    }
  }



}
