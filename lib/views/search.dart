import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  //const Search({super.key});

  final String searchQuery;

  Search({ required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();
  List <WallpaperModel> wallpapers =[];

  /*getSearchWallpapers(String query) async {
    var url = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=20");
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
  */
  getSearchWallpapers(String query) async {
    var url = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=500");
    var response = await http.get(
      url,
      headers: {"Authorization": apiKey},
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<WallpaperModel> newWallpapers = [];
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
        newWallpapers.add(wallpaperModel);
      });

      setState(() {

        wallpapers.clear();
        wallpapers.addAll(newWallpapers);
      });
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();

    searchController.text = widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                    color: Color(0xdafcdfc6),
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: <Widget> [
                  Expanded(
        
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "search wallpaper",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      getSearchWallpapers(searchController.text);
                    },
                    child: Container(
                        child: Icon(Icons.search)),
                  )
                ],),
              ),
              SizedBox(height: 16),
              wallpapersList(wallpapers: wallpapers, context: context)
        ],),),
      ),
    );
  }
}
