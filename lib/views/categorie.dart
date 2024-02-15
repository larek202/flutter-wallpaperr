import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/widget.dart';


class Categorie extends StatefulWidget {
 // const Categorie({super.key});

  final String categorieName;

  Categorie({ required this.categorieName});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List <WallpaperModel> wallpapers =[];


  getSearchWallpapers(String query) async {
    var url = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=500");
    var respons = await http.get(
      url,
      headers: {"Authorization": apiKey},
    );
    //print(respons.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(respons.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {
    });
  }

  @override
  void initState() {
   getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              SizedBox(height: 16),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],),),
      ),
    );
  }
}
