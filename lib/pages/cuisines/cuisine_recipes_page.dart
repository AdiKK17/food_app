import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../providers/recipe_by_cuisine.dart';
import '../../providers/recipe.dart';
import '../../widgets/webview.dart';

class CuisineRecipesPage extends StatefulWidget {
  final String title;

  CuisineRecipesPage(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CuisineRecipesPage();
  }
}

class _CuisineRecipesPage extends State<CuisineRecipesPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RecipeByCuisine>(context)
            .fetchRecipes(context,widget.title)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,fontFamily: "Oswald"),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      color: Colors.lightGreen,
                      height: 430,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 280,
                            width: double.infinity,
                            color: Colors.white,
                            child: Card(
                              elevation: 15,
                              child: GridTile(
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunch(
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .detailSource)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => WbviewScreen(
                                              Provider.of<RecipeByCuisine>(
                                                  context)
                                                  .cuisineList[index]
                                                  .detailSource),
                                        ),
                                      );
                                    }
                                  },
                                  onDoubleTap: () {
                                    Provider.of<Recipe>(context).favoriteIt(
                                        context,
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .title,
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .imageUrl,
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .rating,
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .id,
                                        Provider.of<RecipeByCuisine>(context)
                                            .cuisineList[index]
                                            .detailSource);
                                    Scaffold.of(context).hideCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                        Text("Recipe added to favorites"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch(
                                        "https://www.youtube.com/results?search_query=${Provider.of<RecipeByCuisine>(context).cuisineList[index].title}")) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => WbviewScreen(
                                              "https://www.youtube.com/results?search_query=${Provider.of<RecipeByCuisine>(context).cuisineList[index].title}"),
                                        ),
                                      );
                                    }
                                  },
                                  child: Image.network(
                                    Provider.of<RecipeByCuisine>(context)
                                        .cuisineList[index]
                                        .imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              Provider.of<RecipeByCuisine>(context)
                                  .cuisineList[index]
                                  .title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Provider.of<Recipe>(context).favoriteIt(
                                      context,
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .title,
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .imageUrl,
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .rating,
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .id,
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .detailSource);
                                  Scaffold.of(context).hideCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Recipe added to favorites"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              SmoothStarRating(
                                  allowHalfRating: true,
                                  starCount: 5,
                                  rating: double.parse(
                                      Provider.of<RecipeByCuisine>(
                                          context)
                                          .cuisineList[index]
                                          .rating) >=
                                      80
                                      ? 5
                                      : 3.5,
                                  size: 40.0,
                                  color: Colors.deepOrangeAccent,
                                  borderColor: Colors.white,
                                  spacing: 0.0),
                              IconButton(
                                icon: Icon(
                                  Icons.videocam,
                                  size: 35,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  if (await canLaunch(
                                      Provider.of<RecipeByCuisine>(context)
                                          .cuisineList[index]
                                          .detailSource)) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WbviewScreen(
                                            Provider.of<RecipeByCuisine>(context)
                                                .cuisineList[index]
                                                .detailSource),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount:
                  Provider.of<RecipeByCuisine>(context).cuisineList.length,
            ),
    );
  }
}
