import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/recipe.dart';
import '../widgets/webview.dart';

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
      Provider.of<Recipe>(context).createFavoriteList(context).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Recipe>(context).createFavoriteList(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(187, 239, 176, 0.8),
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
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Provider.of<Recipe>(context).favoriteRecipes.length == 0
                ? Center(
                    child: Text(
                      "You have no favorites",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
//                        color: Color.fromRGBO(10, 33, 15, 0.7),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.all(10),
//                          color: Colors.black12,
                          color: Color.fromRGBO(187, 239, 176, 0.8),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            onTap: () async {
                              if (await canLaunch(Provider.of<Recipe>(context)
                                  .favoriteRecipes[index]
                                  .detailSource)) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WbviewScreen(
                                        Provider.of<Recipe>(context)
                                            .favoriteRecipes[index]
                                            .detailSource),
                                  ),
                                );
                              }
                            },
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  Provider.of<Recipe>(context)
                                      .favoriteRecipes[index]
                                      .imageUrl),
                            ),
                            title: Text(
                              Provider.of<Recipe>(context)
                                  .favoriteRecipes[index]
                                  .title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "Rating - ${Provider.of<Recipe>(context).favoriteRecipes[index].rating.substring(0,5)}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => Provider.of<Recipe>(context)
                                    .deFavoriteIt(context, index)),
                          ),
                        ),
                      );
                    },
                    itemCount:
                        Provider.of<Recipe>(context).favoriteRecipes.length,
                  ),
      ),
    );
  }
}
