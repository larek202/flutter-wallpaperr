import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projekt/data/data.dart';
import 'package:projekt/models/wallpaper_model.dart';
import 'package:projekt/views/categorie.dart';
import 'package:projekt/views/search.dart';
import 'package:projekt/widgets/widget.dart';
import 'package:projekt/models/wallpaper_model.dart';
import '../models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List <CategorieModel> categories = [];
  List <WallpaperModel> wallpapers =[];

  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var url = Uri.parse("https://api.pexels.com/v1/curated?per_page=500");
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
  void initState(){
    getTrendingWallpapers();
    categories=getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: brandName(),
          elevation: 0.0,
        ),
      body: SingleChildScrollView(
        child: Container(child: Column(
          children: <Widget>[
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>
                          Search(
                            searchQuery: searchController.text ,
                          )
                      ));
                },

                child: Container(
                    child: Icon(Icons.search)),
              )
            ],),
          ),
          SizedBox(height: 16),
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                  
                    return CategorieTile(
        
                        imgUrl: categories[index].imgUrl,
                        title: categories[index].categorieName);
                  }),
            ),

            wallpapersList(wallpapers: wallpapers, context: context)
        
          ],),),
      ),
    );
  }


}

class CategorieTile extends StatelessWidget {

  final  String imgUrl, title;
  CategorieTile({required this.imgUrl, required this.title});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (context) => Categorie(
            categorieName: title.toLowerCase(),
            )
        ));
        },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl, height: 50,
                width: 100,
                fit: BoxFit.cover,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
      
             color: Colors.black26,
              height: 50, width: 100,
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),),),
          ),
        ],),
      ),
    );
  }
}
