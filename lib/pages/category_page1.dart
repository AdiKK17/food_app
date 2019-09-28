import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/recipe_by_cuisine.dart';
import '../widgets/webview.dart';
import '../providers/recipe.dart';

class CategoryPage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryPage1();
  }
}

class _CategoryPage1 extends State<CategoryPage1> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<RecipeByCuisine>(context).fetchRecipes1(context, "breakfast");
      Provider.of<RecipeByCuisine>(context).fetchRecipes2(context, "brunch");
      Provider.of<RecipeByCuisine>(context).fetchRecipes3(context, "snacks");
      Provider.of<RecipeByCuisine>(context)
          .fetchRecipes4(context, "dinner")
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String _appropriateTitleText(String name, int index) {
    return name.contains("Breakfast")
        ? Provider.of<RecipeByCuisine>(context)
                    .cuisineList1[index]
                    .title
                    .length >=
                40
            ? "${Provider.of<RecipeByCuisine>(context).cuisineList1[index].title.substring(0, 40)}.."
            : Provider.of<RecipeByCuisine>(context).cuisineList1[index].title
        : name.contains("Brunch")
            ? Provider.of<RecipeByCuisine>(context)
                        .cuisineList2[index]
                        .title
                        .length >=
                    40
                ? "${Provider.of<RecipeByCuisine>(context).cuisineList2[index].title.substring(0, 40)}.."
                : Provider.of<RecipeByCuisine>(context)
                    .cuisineList2[index]
                    .title
            : name.contains("Snacks")
                ? Provider.of<RecipeByCuisine>(context)
                            .cuisineList3[index]
                            .title
                            .length >=
                        40
                    ? "${Provider.of<RecipeByCuisine>(context).cuisineList3[index].title.substring(0, 40)}.."
                    : Provider.of<RecipeByCuisine>(context)
                        .cuisineList3[index]
                        .title
                : Provider.of<RecipeByCuisine>(context)
                            .cuisineList4[index]
                            .title
                            .length >=
                        40
                    ? "${Provider.of<RecipeByCuisine>(context).cuisineList4[index].title.substring(0, 40)}.."
                    : Provider.of<RecipeByCuisine>(context)
                        .cuisineList4[index]
                        .title;
  }

  String _appropriateSourceUrl(String name, int index) {
    return name.contains("Breakfast")
        ? Provider.of<RecipeByCuisine>(context).cuisineList1[index].detailSource
        : name.contains("Brunch")
            ? Provider.of<RecipeByCuisine>(context)
                .cuisineList2[index]
                .detailSource
            : name.contains("Snacks")
                ? Provider.of<RecipeByCuisine>(context)
                    .cuisineList3[index]
                    .detailSource
                : Provider.of<RecipeByCuisine>(context)
                    .cuisineList4[index]
                    .detailSource;
  }


  void _favoriteRecipe(int index,String name){

    if(name.contains("Breakfast")){
      if (Provider.of<RecipeByCuisine>(
          context)
          .cuisineList1[index]
          .isFavorite) {
        Provider.of<Recipe>(
            context)
            .favoriteIt(
            context,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList1[index]
                .title,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList1[index]
                .imageUrl,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList1[index]
                .rating,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList1[index]
                .id,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList1[index]
                .detailSource);
        Fluttertoast.showToast(
            msg: "Recipe added to Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }

    if(name.contains("Brunch")){
      if (Provider.of<RecipeByCuisine>(
          context)
          .cuisineList2[index]
          .isFavorite) {
        Provider.of<Recipe>(
            context)
            .favoriteIt(
            context,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList2[index]
                .title,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList2[index]
                .imageUrl,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList2[index]
                .rating,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList2[index]
                .id,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList2[index]
                .detailSource);
        Fluttertoast.showToast(
            msg: "Recipe added to Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }


    if(name.contains("Snacks")){
      if (Provider.of<RecipeByCuisine>(
          context)
          .cuisineList3[index]
          .isFavorite) {
        Provider.of<Recipe>(
            context)
            .favoriteIt(
            context,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList3[index]
                .title,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList3[index]
                .imageUrl,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList3[index]
                .rating,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList3[index]
                .id,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList3[index]
                .detailSource);
        Fluttertoast.showToast(
            msg: "Recipe added to Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }


    if(name.contains("Dinner")){
      if (Provider.of<RecipeByCuisine>(
          context)
          .cuisineList4[index]
          .isFavorite) {
        Provider.of<Recipe>(
            context)
            .favoriteIt(
            context,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList4[index]
                .title,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList4[index]
                .imageUrl,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList4[index]
                .rating,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList4[index]
                .id,
            Provider.of<RecipeByCuisine>(
                context)
                .cuisineList4[index]
                .detailSource);
        Fluttertoast.showToast(
            msg: "Recipe added to Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }

//    Fluttertoast.showToast(
//        msg: "Recipe added to Favorites",
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.lightGreen,
//        textColor: Colors.black,
//        fontSize: 16.0
//    );

  }


  Widget _buildCategoryCards(String name) {
    return Container(
      color: Colors.white,
      height: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Text(
              name,
              style: TextStyle(fontSize: 30, fontFamily: "Montserrat"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  child: Card(
                    elevation: 20,
                    child: Wrap(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            FadeInImage(
                              fit: BoxFit.cover,
                              height: 200,
                              width: 180,
                              placeholder: AssetImage("assets/dessert.jpg"),
                              image: NetworkImage(
                                name.contains("Breakfast")
                                    ? Provider.of<RecipeByCuisine>(context)
                                        .cuisineList1[index]
                                        .imageUrl
                                    : name.contains("Brunch")
                                        ? Provider.of<RecipeByCuisine>(context)
                                            .cuisineList2[index]
                                            .imageUrl
                                        : name.contains("Snacks")
                                            ? Provider.of<RecipeByCuisine>(
                                                    context)
                                                .cuisineList3[index]
                                                .imageUrl
                                            : Provider.of<RecipeByCuisine>(
                                                    context)
                                                .cuisineList4[index]
                                                .imageUrl,
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 4,
                              child: IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  name.contains("Breakfast") ?
                                  Provider.of<RecipeByCuisine>(context)
                                      .cuisineList1[index]
                                      .isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border : name.contains("Brunch") ?  Provider.of<RecipeByCuisine>(context)
                                      .cuisineList2[index]
                                      .isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border : name.contains("Snacks") ?  Provider.of<RecipeByCuisine>(context)
                                      .cuisineList3[index]
                                      .isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border : Provider.of<RecipeByCuisine>(context)
                                      .cuisineList4[index]
                                      .isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.tealAccent
                                  ,
                                ),
                                onPressed: () { name.contains("Breakfast")
                                    ? Provider.of<RecipeByCuisine>(context)
                                        .toggleCuisineFavoriteStatus1(index)
                                    : name.contains("Brunch")
                                        ? Provider.of<RecipeByCuisine>(context)
                                            .toggleCuisineFavoriteStatus2(index)
                                        : name.contains("Snacks")
                                            ? Provider.of<RecipeByCuisine>(
                                                    context)
                                                .toggleCuisineFavoriteStatus3(
                                                    index)
                                            : Provider.of<RecipeByCuisine>(
                                                    context)
                                                .toggleCuisineFavoriteStatus4(
                                                    index);
                                _favoriteRecipe(index,name);
                                },
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            if (await canLaunch(
                                Provider.of<RecipeByCuisine>(context)
                                    .cuisineList1[index]
                                    .detailSource)) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WbviewScreen(
                                  _appropriateSourceUrl(name, index),
                                ),
                              ));
                            }
                          },
                          child: ListTile(
                            title: Text(
                              _appropriateTitleText(name, index),
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Nexa"),
                            ),
                            subtitle:  SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: double.parse(
                                    (1 + Random().nextInt(6 - 1)).toString()),
                                size: 18.0,
                                color: Colors.greenAccent,
                                borderColor: Colors.greenAccent,
                                spacing: 0.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount:
                  Provider.of<RecipeByCuisine>(context).cuisineList1.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: Colors.lightGreen,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildCategoryCards("Breakfast"),
                  SizedBox(
                    height: 10,
                  ),
                  _buildCategoryCards("Brunch"),
                  SizedBox(
                    height: 10,
                  ),
                  _buildCategoryCards("Snacks"),
                  SizedBox(
                    height: 10,
                  ),
                  _buildCategoryCards("Dinner"),
                ],
              ),
            ),
    );
  }
}
