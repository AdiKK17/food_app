import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/recipe.dart';

class ShowFavorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShowFavorites();
  }
}

class _ShowFavorites extends State<ShowFavorites> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Recipe>(context).createFavoriteList().then((_) {
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
          "Favorites",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
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
                    InkWell(
                      onTap: () async {
                        if (await canLaunch(Provider.of<Recipe>(context)
                            .favoriteRecipes[index]
                            .detailSource)) {
                          await launch(
                            Provider.of<Recipe>(context)
                                .favoriteRecipes[index]
                                .detailSource,
                            forceSafariVC: true,
                            forceWebView: true,
                          );
                        } else {
                          print("could not launch the url");
                        }
                      },
                      child: Container(
                        color: Colors.black38,
                        height: 350,
                        width: double.infinity,
                        child: GridTile(
                          child: Image.network(
                            Provider.of<Recipe>(context)
                                .favoriteRecipes[index]
                                .imageUrl,
                            fit: BoxFit.cover,
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.black38,
                            title: Text(
                              Provider.of<Recipe>(context)
                                  .favoriteRecipes[index]
                                  .title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          header: GridTileBar(
                            backgroundColor: Colors.black38,
                            title: Text(
                              Provider.of<Recipe>(context)
                                  .favoriteRecipes[index]
                                  .rating,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
//                    Container(
//                      width: double.infinity,
//                      height: 60,
//                      child: Center(
//                        child: IconButton(
//                          icon: Icon(
//                            Icons.favorite,
//                            color: Colors.black,
//                            size: 40,
//                          ),
//                          onPressed: () {
//                            Provider.of<Recipe>(context).favoriteIt(
//                                Provider.of<Recipe>(context)
//                                    .favoriteRecipes[index]
//                                    .id);
//                            Scaffold.of(context).hideCurrentSnackBar();
//                            Scaffold.of(context).showSnackBar(
//                              SnackBar(
//                                content: Text("recipe added to favorites"),
//                                duration: Duration(seconds: 2),
//                              ),
//                            );
//                          },
//                        ),
//                      ),
//                      color: Colors.lightGreen,
//                      margin: EdgeInsets.only(bottom: 10),
//                    )
                  ],
                );
              },
              itemCount: Provider.of<Recipe>(context).favoriteRecipes.length,
            ),
    );
  }
}
