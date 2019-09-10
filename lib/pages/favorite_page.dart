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
        backgroundColor: Colors.grey,
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
      body: Provider.of<Recipe>(context).favoriteRecipes.length == 0
          ? Center(
              child: Text(
                "You have no favorites",
                style: TextStyle(fontSize: 30),
              ),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(margin: EdgeInsets.all(10),color: Colors.black12,child: ListTile(
                      contentPadding: EdgeInsets.all(20),
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
                      leading: CircleAvatar(radius: 30.0,backgroundImage: NetworkImage(Provider.of<Recipe>(context)
                          .favoriteRecipes[index]
                          .imageUrl),),
                        title: Text(Provider.of<Recipe>(context).favoriteRecipes[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      subtitle: Text("Rating - ${Provider.of<Recipe>(context).favoriteRecipes[index].rating}"),
                    ),);
                  },
                  itemCount:
                      Provider.of<Recipe>(context).favoriteRecipes.length,
                ),
    );
  }
}
